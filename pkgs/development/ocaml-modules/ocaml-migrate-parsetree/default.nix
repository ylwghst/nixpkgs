{ stdenv, fetchFromGitHub, ocaml, findlib, ocamlbuild, jbuilder, result }:

if !stdenv.lib.versionAtLeast ocaml.version "4.02"
then throw "ocaml-migrate-parsetree is not available for OCaml ${ocaml.version}"
else

stdenv.mkDerivation rec {
   name = "ocaml${ocaml.version}-ocaml-migrate-parsetree-${version}";
   version = "1.0.5";

   src = fetchFromGitHub {
     owner = "let-def";
     repo = "ocaml-migrate-parsetree";
     rev = "v${version}";
     sha256 = "1wj66nb16zijacpfrcm7yi0hlg315v71nxri3ia7r0sa3mlzxl34";
   };

   buildInputs = [ ocaml findlib ocamlbuild jbuilder ];
   propagatedBuildInputs = [ result ];

   installPhase = ''
     for p in *.install
     do
       ${jbuilder.installPhase} $p
     done
   '';

   meta = {
     description = "Convert OCaml parsetrees between different major versions";
     license = stdenv.lib.licenses.lgpl21;
     maintainers = [ stdenv.lib.maintainers.vbgl ];
     inherit (src.meta) homepage;
     inherit (ocaml.meta) platforms;
   };
}
