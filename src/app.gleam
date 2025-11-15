////
//// Gleam UI with vite demo.
////
//// Demo [vite-plugin-gleam](https://github.com/gleam-br/vite-plugin-gleam) + [@tailwindcss/vite](https://tailwindcss.com/docs/installation/using-vite) plugins.
////
//// ## Setup
////
//// Follow steps [here](https://github.com/gleam-br/gbr_ui?tab=readme-ov-file#vite-tailwindcssvite).
////
//// ## Build
////
//// ```sh
//// npm run build
//// ```
////
//// ## Run
////
//// ```sh
//// npm run dev
//// ```
////
//// ## About
////
////

import lustre
import lustre/attribute as a
import lustre/effect
import lustre/element/html

import gbr/ui/logo

// import gbr/ui/header
// import gbr/ui/layout
// import gbr/ui/notification
// import gbr/ui/sidebar
// import gbr/ui/user

import dark_mode

pub fn main() -> Nil {
  let assert Ok(_) = dark_mode.from_media()

  let assert Ok(_runtime) =
    lustre.application(init, update, view)
    |> lustre.start("body", Nil)

  Nil
}

type Model {
  Model(loading: Bool)
}

type Msg {
  // OnHeader(header.Events)
  // OnUser(user.Events)
  OnDarkMode
  // OnNotify(Bool)
  // OnLoading(Bool)
}

fn init(_) {
  #(Model(loading: True), effect.none())
}

fn update(m: Model, msg: Msg) {
  case msg {
    // OnHeader(header.OnDarkMode) -> {
    //   let assert Ok(_) = dark_mode.toggle(False)
    //   #(m, effect.none())
    // }
    OnDarkMode -> {
      let assert Ok(_) = dark_mode.toggle(False)
      #(m, effect.none())
    }
    //_ -> #(m, effect.none())
  }
}

fn view(_m: Model) {
  let logo =
    logo.new("logo-id", "/img/logo2.png")
    |> logo.href("/")
    |> logo.dark("/img/logo.png")
    |> logo.icon("/img/logo-icon.webp")
  // let user =
  //   user.of(OnUser)
  //   |> user.profile(user.Profile(
  //     username: "salespaulo",
  //     email: "salespaulo@horusinfo.com.br",
  //     full_name: "Paulo R. A. Sales",
  //     department: "GTSUP",
  //     picture: "/img/profile.png",
  //   ))
  // let notification = notification.of(False, OnNotify)
  // let header = header.of(OnHeader, False, True, logo, user, notification)
  // let sidebar = sidebar.of()
  let content =
    html.h1([a.class("text-4xl text-gray-900 dark:text-gray-100")], [
      html.text("Bem-vindo!"),
      logo
        |> logo.render(),
    ])

  // let home =
  //   html.div([a.class("bg-gray-100 dark:bg-gray-900")], [
  //     layout.of(header:, sidebar:)
  //     |> layout.content(content)
  //     |> layout.layout(),
  //   ])

  let testing = False

  case testing {
    //True -> element.none()
    // home
    False ->
      html.div(
        [a.class("flex h-screen overflow-hidden bg-gray-100 dark:bg-gray-900")],
        [content],
      )
  }
}
