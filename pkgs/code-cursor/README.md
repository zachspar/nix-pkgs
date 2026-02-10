# code-cursor

AI-powered code editor built on vscode

**Current Version:** 2.4.31  
**VSCode Version:** 1.105.1

## Usage

### With Flakes

```bash
# Run directly
nix run github:zachspar/nix-pkgs#code-cursor

# Install to profile
nix profile install github:zachspar/nix-pkgs#code-cursor

# Add to your flake.nix
{
  inputs.nix-pkgs.url = "github:zachspar/nix-pkgs";
  
  # Then use in your configuration
  environment.systemPackages = [
    inputs.nix-pkgs.packages.${system}.code-cursor
  ];
}
```

### Without Flakes

```bash
# Build and run
nix-build -A code-cursor
./result/bin/cursor

# Install to profile
nix-env -f . -iA code-cursor
```

### As an Overlay

```nix
{
  nixpkgs.overlays = [
    (import (fetchTarball "https://github.com/zachspar/nix-pkgs/archive/main.tar.gz")).overlays.default
  ];
  
  environment.systemPackages = with pkgs; [
    code-cursor
  ];
}
```

## Updating

To update the package to the latest version:

```bash
cd pkgs/code-cursor
./update.sh
```

The update script will:
1. Fetch the latest version from the Cursor API
2. Download all platform-specific AppImages/DMGs
3. Calculate and verify hashes
4. Update `sources.json` with the new version and URLs

## Supported Platforms

- `x86_64-linux` (Linux x64)
- `aarch64-linux` (Linux ARM64)
- `x86_64-darwin` (macOS Intel)
- `aarch64-darwin` (macOS Apple Silicon)

## Links

- [Homepage](https://cursor.com)
- [Changelog](https://cursor.com/changelog)
- [NixOS/nixpkgs package](https://github.com/NixOS/nixpkgs/tree/nixos-unstable/pkgs/by-name/co/code-cursor)

