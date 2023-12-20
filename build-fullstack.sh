# This script was written by Jas Bertovic and FRC Team 1540, the parts written by the former are being used by FRC Team 1540 under the Mozilla Public License 2.0 (see SCRIPT_LICENSE.md)

#!/usr/bin/env bash

# this script concurrently builds the frontend and backend. if either fails, the errors are logged.
# this uses `script` to capture color of output and it writes the status to a file to capture error codes since `script`` does not return that.
# stopping this script will orphan either build, so they will still consume system resources until finished.

# if you wish to change to cargo run, the server will continue to run and still take up the port.
# see https://stackoverflow.com/questions/11583562/how-to-kill-a-process-running-on-particular-port-in-linux
# kill $(lsof -t -i:8080) (add -9 for extra power)

bun_output=$(mktemp)
cargo_output=$(mktemp)
bun_status=$(mktemp)
cargo_status=$(mktemp)

# run in background, capture outputs, error codes
script -q -c "cd frontend && bun i && bun run build; echo \$? > $bun_status" /dev/null > $bun_output 2> $bun_output
bun_pid=$!

script -q -c "cargo build; echo \$? > $cargo_status" /dev/null > $cargo_output 2> $cargo_output
cargo_pid=$!

wait $bun_pid
bun_exit_status=$(cat $bun_status)

# log if something failed
if [ $bun_exit_status -ne 0 ]; then
    echo "Frontend build failed:"
    cat $bun_output
fi

wait $cargo_pid
cargo_exit_status=$(cat $cargo_status)

if [ $cargo_exit_status -ne 0 ]; then
    echo "Backend build failed:"
    cat $cargo_output
fi

rm $bun_output
rm $cargo_output

if [ $bun_exit_status -eq 0 ] && [ $cargo_exit_status -eq 0 ]; then
    echo "Build success"
fi