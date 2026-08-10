cask "macbat" do
  version "0.8.1"
  sha256 "1e55a486343710fca2939498b460082eb6751c9e034741cb3e41e7c7dc7bd4f6"

  url "https://github.com/1architect/macbat-releases/releases/download/v#{version}/MacBat-#{version}-23.zip"
  name "MacBat"
  desc "Battery time estimator and energy management utility"
  homepage "https://giovaniman8.gumroad.com/l/macbat"

  depends_on macos: ">= :tahoe"

  app "MacBat.app"

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/MacBat.app"]
  end

  uninstall quit: "com.giovanimanto.macbat"

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

  zap trash: [
    "~/Library/Application Support/MacBat",
    "~/Library/Preferences/com.giovanimanto.macbat.plist",
  ]
end
