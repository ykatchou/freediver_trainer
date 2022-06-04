#[macro_use] extern crate rocket;
use rocket::fs::relative;
use rocket::fs::FileServer;

#[get("/training_plan")]
async fn get_all_training_plan() -> String {
    format!("GET ALL TRAINING")
}

#[get("/training_plan/<id>")]
async fn get_unit_training_plan(id: u64) -> String {
    format!("GET TRAINING {}", id)
}

#[post("/training_plan/<id>")]
async fn save_unit_training_plan(id: u64) -> String {
    format!("SAVE TRAINING {}", id)
}


#[launch]
fn rocket() -> _ {
    rocket::build()
        .mount("/api/", routes![get_all_training])
        .mount("/api/", routes![get_unit_training])
        .mount("/api/", routes![save_unit_training])
        .mount("/", FileServer::from(relative!("html")))

}
