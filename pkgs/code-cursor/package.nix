{
  lib,
  stdenv,
  fetchurl,
  appimageTools,
  makeWrapper,
}:

let
  inherit (stdenv) hostPlatform;
  
  sourcesJson = lib.importJSON ./sources.json;
  sources = lib.mapAttrs (
    _: info:
    fetchurl {
      inherit (info) url hash;
    }
  ) sourcesJson.sources;

  pname = "cursor";
  version = sourcesJson.version;
  
  src = sources.${hostPlatform.system} or (throw "Unsupported system: ${hostPlatform.system}");

  appimageContents = appimageTools.extractType2 {
    inherit pname version src;
  };
in
appimageTools.wrapType2 {
  inherit pname version src;

  extraInstallCommands = ''
    install -Dm444 ${appimageContents}/cursor.desktop -t $out/share/applications
    substituteInPlace $out/share/applications/cursor.desktop \
      --replace-quiet 'Exec=AppRun' 'Exec=${pname}' \
      --replace-quiet 'Exec=cursor' 'Exec=${pname}'
    
    for size in 16 32 48 64 128 256 512; do
      install -Dm444 ${appimageContents}/usr/share/icons/hicolor/''${size}x''${size}/apps/cursor.png \
        $out/share/icons/hicolor/''${size}x''${size}/apps/cursor.png || true
    done
  '';

  meta = {
    description = "AI-powered code editor built on vscode";
    homepage = "https://cursor.com";
    changelog = "https://cursor.com/changelog";
    license = lib.licenses.unfree;
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
    maintainers = with lib.maintainers; [ zachspar ];
    platforms = [ "x86_64-linux" "aarch64-linux" ];
    mainProgram = "cursor";
  };
}
