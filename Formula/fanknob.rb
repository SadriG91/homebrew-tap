class Fanknob < Formula
  desc "Knob-style fan control and temperature monitoring for Apple Silicon"
  homepage "https://github.com/SadriG91/fanknob"
  url "https://github.com/SadriG91/fanknob/archive/refs/tags/v1.3.1.tar.gz"
  sha256 "dcd08fa297237bddef5d1b81d1867497e26e8d6c7435d29168e6a2cf7b60710b"
  license "MIT"
  head "https://github.com/SadriG91/fanknob.git", branch: "main"

  bottle do
    root_url "https://github.com/SadriG91/homebrew-tap/releases/download/fanknob-1.3.1"
    sha256 cellar: :any_skip_relocation, all: "af18d058f12bba27fe6f14109188c53a3872119d24b5572f1e1485f229f830e0"
  end

  depends_on :macos
  depends_on arch: :arm64
  depends_on xcode: ["16.0", :build]

  def install
    system "swift", "build", "-c", "release", "--disable-sandbox"
    bin.install ".build/release/fanknob"
    bin.install ".build/release/fanknobd"

    # Assemble the menu-bar app (same layout as `make app`).
    contents = prefix/"Fanknob.app/Contents"
    (contents/"MacOS").mkpath
    (contents/"Resources").mkpath
    cp "app/Info.plist", contents/"Info.plist"
    cp "assets/AppIcon.icns", contents/"Resources/AppIcon.icns"
    cp ".build/release/FanknobApp", contents/"MacOS/FanknobApp"
  end

  # Root helper daemon: performs the privileged SMC writes so the CLI and app
  # never need sudo. Start it with:  sudo brew services start fanknob
  service do
    run [opt_bin/"fanknobd"]
    require_root true
    keep_alive true
    log_path var/"log/fanknobd.log"
    error_log_path var/"log/fanknobd.log"
  end

  def caveats
    <<~EOS
      Reading fans/temperatures works immediately. Fan CONTROL needs the root
      helper daemon (one-time setup):

        sudo brew services start fanknob

      The menu-bar app is at:
        #{opt_prefix}/Fanknob.app
      To keep it in /Applications:
        cp -R #{opt_prefix}/Fanknob.app /Applications/

      If you previously installed fanknob manually (`sudo make install`),
      remove that copy first from your checkout:  sudo make uninstall

      Safety: in manual mode YOU own thermal management, not the firmware.
      Use the hold/auto-revert feature or return to auto when done.
    EOS
  end

  test do
    assert_match "knob-style fan control", shell_output(bin/"fanknob")
  end
end
