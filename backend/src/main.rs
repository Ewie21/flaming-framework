// use axum::{
//     routing::get,
//     Router
// };
// use tower_http::services::{ServeDir, ServeFile};

// #[tokio::main]
// async fn main() {
//     let app = init_router();
//         // .route("/", get(hello_world()));
//     let listener = tokio::net::TcpListener::bind("0.0.0.0:3000").await.unwrap(); // 0.0.0.0 makes it compatable with docker images
//     axum::serve(listener, app).await.unwrap();
// }

// fn init_router() -> Router {
//     Router::new().nest_service("/", 
//         ServeDir::new("dist")
//         .not_found_service(ServeFile::new("dist/index.html")) // fallback
//     )
// }

// fn hello_world() -> &'static str {
//     "Hello World!"
// }

#[tokio::main]
async fn main() {

}