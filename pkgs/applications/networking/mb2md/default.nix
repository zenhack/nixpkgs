{ stdenv, fetchurl, perl, TimeDate }:

stdenv.mkDerivation rec {
  version = "3.20";
  name = "mb2md-${version}";

  src = fetchurl {
    url = "http://batleth.sapienti-sat.org/projects/mb2md/${name}.pl.gz";
    sha256 = "0bvkky3c90738h3skd2f1b2yy5xzhl25cbh9w2dy97rs86ssjidg";
  };


  buildInputs = [ perl TimeDate ];
  propagatedBuildInputs = [ perl TimeDate ];

  unpackCmd = ''
    # HACK: unpack is expected to create a directory, but we only have the one
    # file. We do this to make it happy.
    mkdir ${name}
    gunzip < $curSrc > ${name}/${name}.pl
  '';


  installPhase = ''
    install -Dm755 ${name}.pl $out/bin/mb2md
  '';

  meta = {
      description = "Tool to convert Mbox mailboxes to Maildir format";
      homepage = "http://batleth.sapienti-sat.org/projects/mb2md/";
      license = stdenv.lib.licenses.gpl2;
      maintainers = [ stdenv.lib.maintainers.zenhack ];
      platforms = stdenv.lib.platforms.all;
    };
}
