# homebrew-fanknob

Homebrew tap for [fanknob](https://github.com/SadriG91/fanknob) — knob-style
fan control and temperature monitoring for Apple Silicon Macs.

## Install

```sh
brew install SadriG91/fanknob/fanknob

# fan control needs the root helper daemon (one time):
sudo brew services start fanknob
```

## Update

```sh
brew update
brew upgrade fanknob
sudo brew services restart fanknob
```

The formula builds from source on your machine, so no code signing or
Gatekeeper approval is involved.
