# nix-pkgs

A collection of nix packages

## Packages

- [**code-cursor**](./pkgs/code-cursor) - AI-powered code editor built on vscode (v2.4.31)

## Usage

### With Flakes

```bash
# Run a package
nix run github:zachspar/nix-pkgs#code-cursor

# Add to your flake.nix
{
  inputs.nix-pkgs.url = "github:zachspar/nix-pkgs";
}
```

### Without Flakes

```bash
nix-build -A code-cursor
```

See individual package READMEs for detailed usage instructions.
