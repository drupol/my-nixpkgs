{ inputs, ... }:

{
  perSystem =
    {
      config,
      self',
      inputs',
      pkgs,
      system,
      ...
    }:
    {
      _module.args.pkgs = import inputs.nixpkgs {
        inherit system;
        overlays = [
          inputs.self.overlays.default
          (final: prev: { scikit-learn-1-2 = (import inputs.scikit-learn-1-2 { inherit system; }); })
        ];
        config = { };
      };

      overlayAttrs = config.packages;
    };
}
