////
//// App
////
////

import gleam/io
import gleam/option
import gleam/result

import gbr/js/global
import gbr/js/jsdocument
import gbr/js/jselement
import gbr/js/storage
import gbr/js/token_list
import gbr/shared/try

const name = "gbr/ui/dark_mode"

fn db() {
  use db <- result.map(
    storage.local()
    |> try.new()
    |> try.context("Getting local storage")
    |> try.unwrap(),
  )
  db
}

pub fn is_enabled() -> Result(Bool, String) {
  use db <- result.map(db())

  let get_item =
    storage.get_item(db, name)
    |> try.new()
    |> try.context("Getting local storage item " <> name)
    |> try.unwrap()

  case get_item {
    Ok(item) -> item == "true"
    Error(err) -> {
      io.println_error(err)
      global.match_media("(prefers-color-scheme: dark)")
    }
  }
}

pub fn from_media() -> Result(Bool, String) {
  case is_enabled() {
    Ok(True) -> {
      jsdocument.body()
      |> jselement.class_list()
      |> token_list.add_one("dark")
      Ok(True)
    }
    Ok(False) -> {
      jsdocument.body()
      |> jselement.class_list()
      |> token_list.remove_one("dark")
      Ok(False)
    }
    Error(err) -> Error(err)
  }
}

pub fn toggle(force: Bool) -> Result(Bool, String) {
  let enabled = case force {
    True ->
      jsdocument.body()
      |> jselement.class_list()
      |> token_list.toggle("dark", option.Some(True))
    False ->
      jsdocument.body()
      |> jselement.class_list()
      |> token_list.toggle("dark", option.None)
  }

  let to_storage = case enabled {
    True -> "true"
    False -> "false"
  }

  use db <- result.try(db())
  use _ <- result.map(
    storage.set_item(db, name, to_storage)
    |> try.new()
    |> try.context(
      "Setting local storage item " <> name <> " value " <> to_storage,
    )
    |> try.unwrap(),
  )

  enabled
}
