cask "multiprompter" do
  version "1.0"
  sha256 "4c339f4c82b46fdd7c458497260de1ce19e45ee4e692a774e658deb6bc2bfe29"

  url "https://github.com/bradtraversy/multiprompter/releases/download/v#{version}/Multiprompter-#{version}.zip"
  name "Multiprompter"
  desc "Multi-window teleprompter with synced scrolling"
  homepage "https://github.com/bradtraversy/multiprompter"

  depends_on macos: ">= :sequoia"

  app "Multiprompter.app"

  zap trash: [
    "~/Library/Containers/com.traversy.Multiprompter",
    "~/Library/Saved Application State/com.traversy.Multiprompter.savedState",
  ]
end
