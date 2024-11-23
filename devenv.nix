{ pkgs, lib, config, inputs, ... }:

{
  # https://devenv.sh/basics/
  env.GREET = "devenv";

  # https://devenv.sh/packages/
  packages = [ pkgs.git ];

  scripts.phx.exec = "iex -S mix phx.server";

  # https://devenv.sh/languages/
  languages.elixir = {
    enable = true;
    package = pkgs.beam.packages.erlang_27.elixir_1_17;
  };
  languages.javascript = {
    enable = true;
    package = pkgs.nodejs_22;
  };

  # https://devenv.sh/processes/
  # processes.cargo-watch.exec = "cargo-watch";

  # https://devenv.sh/services/
  # services.postgres.enable = true;

  # https://devenv.sh/scripts/

  enterShell = ''
    mix setup
  '';

  # https://devenv.sh/tasks/
  # tasks = {
  #   "myproj:setup".exec = "mytool build";
  #   "devenv:enterShell".after = [ "myproj:setup" ];
  # };

  # https://devenv.sh/tests/
  enterTest = ''
    echo "Running tests"
    mix test
  '';

  # https://devenv.sh/pre-commit-hooks/
  pre-commit.hooks.check-merge-conflicts.enable = true;
  pre-commit.hooks.check-added-large-files.enable = true;
  pre-commit.hooks.detect-private-keys.enable = true;
  pre-commit.hooks.end-of-file-fixer.enable = true;
  pre-commit.hooks.trim-trailing-whitespace.enable = true;

  pre-commit.hooks.mix-format = {
    enable = true;
    entry = "mix format";
  };

  pre-commit.hooks.mix-test = {
    enable = true;
    entry = "mix test";
    pass_filenames = false;
  };

  # See full reference at https://devenv.sh/reference/options/
}
