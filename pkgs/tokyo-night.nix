{ lib, stdenv, fetchzip, }:

stdenv.mkDerivation rec {
  pname = "tokyo-night";
  version = "1.0.0";

  src = fetchzip {
    url = "https://github.com/Fausto-Korpsvart/Tokyo-Night-GTK-Theme/archive/refs/heads/master.zip";
    sha256 = "sha256-b35J6NsFkUNM/yxMe7bi0kpyuI/pGLnCywCEDLHLf5A=";
  };

  installPhase = ''
    mkdir -p $out/share/themes/
    cp -r themes/* $out/share/themes/
  '';


  meta = with lib; {
    homepage = "https://github.com/Fausto-Korpsvart/Tokyo-Night-GTK-Theme";
    description = "Fast, reliable, and secure dependency management for javascript";
    maintainers = with maintainers; [
      Fausto-Korpsvart
    ];
  };
}
