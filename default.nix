{ pkgs ? import <nixpkgs> { config.allowUnfree = true; }
, src ?  builtins.filterSource (path: type:
    type != "unknown" &&
    baseNameOf path != ".git" &&
    baseNameOf path != "result" &&
    baseNameOf path != "dist") ./.
}:
let
  servant02 = pkgs.fetchgit {
    url = https://github.com/haskell-servant/servant.git;
    rev = "refs/heads/servant-0.2";
    sha256 = "0mcn9d8hnijws1p8y6h3r0298f1x8mya2nshyi46mprrj2kn8wmm";
  };
  servantServer02 = pkgs.fetchgit {
    url = https://github.com/haskell-servant/servant-server.git;
    rev = "refs/heads/servant-server-0.2";
    sha256 = "1x2ik9ws64ms31vr9rvj1m6f68q5qaayx406135wnbs78lb8yclj";
  };
in
pkgs.haskellPackages.buildLocalCabalWithArgs {
  name = "servant-client";
  inherit src;
  args = {
      servant = import servant02 {};
      servantServer = import servantServer02 {};
  };
}
