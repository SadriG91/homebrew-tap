# homebrew-tap

Homebrew casks for [SadriG91](https://github.com/SadriG91)'s projects.

## Usage

```sh
brew install --cask SadriG91/tap/<name>
```

## Casks

| Cask | Project | Description |
|---|---|---|
| `fanknob` | [fanknob](https://github.com/SadriG91/fanknob) | Knob-style fan control + temperature monitoring for Apple Silicon Macs |

### fanknob

```sh
brew install --cask SadriG91/tap/fanknob
```

Installs the menu-bar app, the `fanknob` CLI, and the root helper daemon — which
is loaded for you. Fan control works as soon as the install finishes; there is no
second setup command.

Update and remove:

```sh
brew upgrade --cask fanknob
brew uninstall --cask fanknob        # --zap also drops saved configuration
```

Uninstalling stops the daemon before deleting anything, and the daemon hands the
fans back to the firmware as it exits — so removing fanknob can't leave them
stuck at a fixed speed.
