cask "amoeba" do
  version "0.1.0"
  sha256 "e837c330e2ae45e043c8dd1c90fc2c459f609ca65a8a7632e1998528d2de293a"

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
