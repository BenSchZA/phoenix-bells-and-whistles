{ pkgs ? import <nixpkgs> {} }:

with pkgs;

let
  inherit (lib) optional optionals;

  elixir = beam.packages.erlangR21.elixir_1_7;
  nodejs = nodejs-10_x;
  postgresql = postgresql_10;
in

mkShell {
  buildInputs = [ elixir nodejs nodePackages.npm git postgresql ]
    ++ optional stdenv.isLinux inotify-tools # For file_system on Linux.
    ++ optionals stdenv.isDarwin (with darwin.apple_sdk.frameworks; [
      # For file_system on macOS.
      CoreFoundation
      CoreServices
    ]);

    # Put the PostgreSQL databases in the project diretory.
    shellHook = ''
      export DATABASE_URL=postgres://postgres:postgres@db/basic
      export SECRET_KEY_BASE=GDfhPu29ZU0xorkCWh4TcdGKGVNEtK/AbDz6GB0zEhqzEWKq6xUrC7UKmNsIPQLY

      # Initial setup
      mix deps.get --only prod
      MIX_ENV=prod mix compile

      # Compile assets
      npm run deploy --prefix ./assets
      mix phx.digest

      # Custom tasks (like DB migrations)
      MIX_ENV=prod mix ecto.migrate

      # Finally run the server
      PORT=4001 MIX_ENV=prod mix phx.server
    '';
}
