cask "fanknob" do
  version "1.4.1"
  sha256 "d01d1f258ff8c96a7cda2e2cc0a26ac6e068e98a85a6d6de6f3c8714b0fd2248"

  url "https://github.com/SadriG91/fanknob/releases/download/v#{version}/Fanknob-#{version}.pkg"
  name "Fanknob"
  desc "Knob-style fan control and temperature monitoring for Apple Silicon"
  homepage "https://github.com/SadriG91/fanknob"

  # The SMC fan keys this drives only exist on Apple Silicon, and the binaries
  # target macOS 15. The package itself refuses to install elsewhere too.
  depends_on macos: :sequoia
  depends_on arch: :arm64

  pkg "Fanknob-#{version}.pkg"

  # Order matters, and Homebrew guarantees it: launchctl runs before pkgutil.
  # Stopping the daemon sends it SIGTERM, and fanknobd hands the fans back to
  # the firmware on the way out — so by the time the binaries are deleted the
  # fans are already back under firmware control. Reverse the order and an
  # uninstall would strand them at a fixed speed with no tool left to fix it.
  #
  # login_item covers the legacy login-item registration. The app's "launch at
  # login" uses SMAppService, whose entry macOS prunes itself once the app is
  # gone, so this is belt-and-braces rather than the mechanism.
  uninstall launchctl:  "com.fanknob.daemon",
            login_item: "Fanknob",
            pkgutil:    "com.fanknob.pkg"

  zap trash: [
    "/Library/Application Support/fanknob",
    "/var/log/fanknobd.log",
  ]

  caveats <<~EOS
    Fan control is live already — the installer loaded the root daemon for you.

    In manual mode YOU own thermal management, not the firmware. Prefer a curve
    (`fanknob preset balanced`) over a fixed speed if you're leaving an override
    on, and note the thermal watchdog hands control back above 95°C by default.
  EOS
end
