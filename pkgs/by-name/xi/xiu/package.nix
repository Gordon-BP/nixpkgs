{ lib
, cmake
, darwin
, fetchFromGitHub
, libopus
, openssl
, pkg-config
, rustPlatform
, stdenv
}:

rustPlatform.buildRustPackage rec {
  pname = "xiu";
  version = "0.12.0";

  src = fetchFromGitHub {
    owner = "harlanc";
    repo = "xiu";
    rev = "v${version}";
    hash = "sha256-aDDaxFP9k/crCrZLEzLIHJoXZfh7hs88HA3EGqFTwr8=";
  };

  cargoHash = "sha256-6ckYSAJuIe1HIvA7p7rBHRP44UfqXy9HHjyeB2Fh6JI=";

  nativeBuildInputs = [
    cmake
    pkg-config
  ];

  buildInputs = [
    libopus
  ] ++ lib.optionals stdenv.isLinux [
    openssl
  ] ++ lib.optionals stdenv.isDarwin [
    darwin.apple_sdk.frameworks.Security
  ];

  OPENSSL_NO_VENDOR = 1;

  meta = with lib; {
    description = "A simple, high performance and secure live media server in pure Rust (RTMP[cluster]/RTSP/WebRTC[whip/whep]/HTTP-FLV/HLS";
    homepage = "https://github.com/harlanc/xiu";
    changelog = "https://github.com/harlanc/xiu/releases/tag/v${version}";
    license = licenses.mit;
    maintainers = with maintainers; [ marsam ];
    mainProgram = "xiu";
  };
}
