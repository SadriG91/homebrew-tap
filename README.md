# homebrew-tap

Homebrew formulas for [SadriG91](https://github.com/SadriG91)'s projects.

## Usage

```sh
brew install SadriG91/tap/<formula>
```

## Formulas

| Formula | Project | Description |
|---|---|---|
| `fanknob` | [fanknob](https://github.com/SadriG91/fanknob) | Knob-style fan control + temperature monitoring for Apple Silicon Macs |

### fanknob

```sh
brew install SadriG91/tap/fanknob

# fan control needs the root helper daemon (one time):
sudo brew services start fanknob
```

Update:

```sh
brew update && brew upgrade fanknob
sudo brew services restart fanknob
```

Formulas build from source on your machine, so no code signing or Gatekeeper
approval is involved.
