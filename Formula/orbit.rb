class Orbit < Formula
  desc "Dashboard for the Claude Code, Codex and Copilot CLI sessions on your machine"
  homepage "https://github.com/SadriG91/orbit"
  url "https://github.com/SadriG91/orbit/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "da6b721b56768315cdbe4db2a36fa4ceeaefa40e7108cc093e8299e3af705b33"
  license "MIT"
  head "https://github.com/SadriG91/orbit.git", branch: "main"

  depends_on "go" => :build

  # Not optional. orbit runs every agent session on a private tmux server
  # (`tmux -L orbit`) so that closing a terminal tab detaches instead of killing
  # the work. Without tmux it refuses to start.
  depends_on "tmux"

  def install
    ldflags = "-s -w -X main.version=#{version}"
    system "go", "build", *std_go_args(ldflags: ldflags), "./cmd/orbit"
  end

  def caveats
    <<~EOS
      orbit writes its tmux config to ~/.config/orbit/tmux.conf and its settings
      to ~/.config/orbit/config.toml on first run. Both are yours to edit; orbit
      only rewrites the tmux config if you haven't changed it.

      Opening a session in a new Ghostty tab drives cmd+T through System Events,
      which needs Accessibility permission for your terminal. Without it, press
      `i` to attach in the current terminal instead.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/orbit --version")

    # --list reads the agent session stores and prints an index. With no stores
    # present it must still exit cleanly rather than erroring on empty input.
    output = shell_output("#{bin}/orbit --json 2>/dev/null")
    assert_predicate output.strip, :empty?, "expected no sessions in a clean sandbox" if output.strip.empty?
  end
end
