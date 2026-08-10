cask "macbat" do
  version "0.8.6"
  sha256 "acbfd1df94d2c5e5466690bd957888f526041063fbf1fb5e9fd7c40ffd0c6461"

  url "https://github.com/1architect/macbat-releases/releases/download/v#{version}/MacBat-#{version}.zip"
  name "MacBat"
  desc "Battery time estimator and energy management utility"
  homepage "https://giovaniman8.gumroad.com/l/macbat"

  depends_on macos: :tahoe

  app "MacBat.app"

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/MacBat.app"]
  end

  uninstall_postflight do
    sudoers_paths = [
      "/etc/sudoers.d/macbat-economia",
      "/etc/sudoers.d/macbat-lowpowermode",
    ]
    if sudoers_paths.any? { |path| File.exist?(path) }
      system_command "/bin/rm",
                     args: ["-f", *sudoers_paths],
                     sudo: true
    end
  end

  uninstall quit: "com.giovanimanto.macbat"

  zap trash: [
    "~/Library/Application Support/MacBat",
    "~/Library/Preferences/com.giovanimanto.macbat.plist",
  ]
end
