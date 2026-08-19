cask "multiprompter" do
  version "1.1"
  sha256 "c2f85f8eddde37678de797422deb836f850a16b4555a8dd0597c6e9133d590b7"

  url "https://github.com/bradtraversy/multiprompter-releases/releases/download/v#{version}/Multiprompter.dmg"
  name "Multiprompter"
  desc "Multi-window teleprompter with synced scrolling"
  homepage "https://multiprompter.app/"

  depends_on macos: :sequoia

  app "Multiprompter.app"

  zap trash: [
    "~/Library/Containers/com.traversy.Multiprompter",
    "~/Library/Saved Application State/com.traversy.Multiprompter.savedState",
  ]
end
