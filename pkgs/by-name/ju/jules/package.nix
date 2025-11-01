{
  lib,
  stdenv,
  buildNpmPackage,
  fetchFromGitHub,
}:

buildNpmPackage (finalAttrs: {
  pname = "jules";
  version = "0.1.40";

  src = fetchFromGitHub {
    owner = "google";
    repo = "jules";
    tag = "v${finalAttrs.version}";
    hash = "sha256-ABnfxLMtY8E5KqJkrtIlPB4ML7CSFvjizCabv7i7SbU=";
  };

  npmDepsHash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    ln -s $out/lib/node_modules/@google/jules/dist/index.js $out/bin/jules
    chmod +x "$out/bin/jules"
    runHook postInstall
  '';

  passthru.updateScript = { };

  meta = {
    description = "AI agent that brings the power of Gemini directly into your terminal";
    homepage = "https://github.com/google/jules";
    license = lib.licenses.asl20;
    sourceProvenance = with lib.sourceTypes; [ fromSource ];
    maintainers = with lib.maintainers; [ ];
    platforms = lib.platforms.all;
    mainProgram = "jules";
  };
})
