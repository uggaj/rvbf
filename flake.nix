{
  description = "rvbf: A Brainfuck interpreter";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  outputs =
    { self, nixpkgs }:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
    in
    {
      devShells.x86_64-linux.default = pkgs.mkShell {
        packages = with pkgs; [
          pkgsCross.riscv64.buildPackages.gcc
          pkgsCross.riscv64.buildPackages.binutils
          qemu
        ];
      };
    };
}
