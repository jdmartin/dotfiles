self: super:

{
  nano = super.nano.overrideAttrs (old: {
    configureFlags = (old.configureFlags or []) ++ [
      "--enable-nls"
      "--disable-libmagic"
    ];
    buildInputs = (old.buildInputs or []) ++ [ super.gettext ];
  });
}

