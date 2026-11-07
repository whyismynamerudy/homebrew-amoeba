cask "amoeba" do
  version "0.1.1"
  sha256 "586a6363a6045fcd86c39933bc1a8ef38e3b44e326efe7ad48ce7f4ed9297549"

  url "https://github.com/whyismynamerudy/amoeba/releases/download/v#{version}/orca-macos-arm64.dmg"
  name "Amoeba"
  desc "Chat-first desktop app for Claude and Codex coding agents"
  homepage "https://github.com/whyismynamerudy/amoeba"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: :monterey

  app "Amoeba.app"
  binary "#{appdir}/Amoeba.app/Contents/Resources/bin/amoeba"

  # Unsigned build: clear quarantine so Gatekeeper doesn't block first launch.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Amoeba.app"]
  end

  zap trash: [
    "~/.amoeba",
    "~/Library/Application Support/Amoeba",
    "~/Library/Caches/com.amoeba.desktop",
    "~/Library/HTTPStorages/com.amoeba.desktop",
    "~/Library/Preferences/com.amoeba.desktop.plist",
    "~/Library/Saved Application State/com.amoeba.desktop.savedState",
  ]
end
