{ inputs, lib, ... }:
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
      packages = {
        scikit-learn-1-3-2 = pkgs.callPackage ../pkgs/scikit-learn-1-3-2 { };
      };
    };
}
