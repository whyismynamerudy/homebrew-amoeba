cask "amoeba" do
  version "0.1.3"
  sha256 "d0de08ab33b841f94bc73e14369c43a03abea43dd93816073e38de09a59482f2"

  url "https://github.com/whyismynamerudy/amoeba/releases/download/v#{version}/orca-macos-arm64.dmg"
  name "Amoeba"
  desc "Chat-first desktop app for Claude and Codex coding agents"
  homepage "https://github.com/whyismynamerudy/amoeba"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true

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
