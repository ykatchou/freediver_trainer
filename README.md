# freediver_trainer

**This application is still a WIP.**

The intention is to built a small app allowing to generate freediving training sessions.

It is done as a hobby.

## Licensing

This project is built under MIT license.

## Technologies

The application is built with a client-server approach.

The server side is done in Rust and intend to do the storage and user authentication.

The client side is done in Elm and does implement both the rendering and the "business" rules.

## Get started

### Prerequisites Back-end

The back-end uses rust, so rustlang should be installed.

After that, a simple `cargo install` within the srv folder should be enough.

### Prerequisites Front-end

The front-end uses elm, which is built in javascript, so npm is needed.

A simple `npm install` should be enough.


### Simply run the whole project

`make run`

### Other makefile targets :

- `make front-build`: build the static js file from elm files 
- `make back-build`: build the rust back-end.

# Current TODO

- [ ] Back-end: implement GET one plan
- [ ] Back-end: implement GET all plans
- [ ] Back-end: implement PUT plan
- [ ] Back-end: implement PATCH plan
- [ ] Back-end: implement DELETE plan
- [ ] Back-end: add logging
- [ ] Back-end: add authentication and limit plans changes for authenticated user (read-only remains available unauthenticated)
- [ ] Back-end: restrict changes to current user's plan only
- [ ] Front-end: Retrieve a specific plan from back-end API
- [ ] Front-end: PATCH a specific plan using the back-end API
- [ ] Front-end: Allow to add new training part
- [ ] Front-end: Allow to add new training exercise
- [ ] Front-end: Allow to add new training exercise sub part
- [ ] Front-end: Allow to change orders of each item
- [ ] Front-end: List all plans
- [ ] Front-end: Add delete a plan
- [ ] Front-end: Add read-only mode (sharable)

