module MotionAcknowledgements
  class Settings
    attr_accessor :resources_path

    def initialize options={}
      @resources_path    = options[:resources_path] || "resources"
    end

    def write
      if should_write?
        puts "\nCreating the Settings.bundle folder in your resources folder with a Root.plist"
        puts "The acknowledgements file generated by CocoaPods (rake pod:install) will be copied to your app each time you run `rake`"
        FileUtils.mkpath settings_bundle
        File.open(plist_file, 'w') {|f| f.write(plist_content) }
      else
        puts "Warning: There is already a Settings.bundle file in your resources folder."
        puts "Please remove it or manually add the acknowledgements to your current Root.plist file."
        puts ""
        puts "More info here: https://github.com/CocoaPods/CocoaPods/wiki/Acknowledgements"
      end
    end

    def should_write?
      !File.exist? settings_bundle
    end

    def settings_bundle
      "#{resources_path}/Settings.bundle"
    end

    def plist_file
      settings_bundle << "/Root.plist"
    end

    def plist_content
<<"PLIST"
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>StringsTable</key>
  <string>Root</string>
  <key>PreferenceSpecifiers</key>
  <array>
    <dict>
      <key>Type</key>
      <string>PSChildPaneSpecifier</string>
      <key>Title</key>
      <string>Acknowledgements</string>
      <key>File</key>
      <string>Acknowledgements</string>
    </dict>
  </array>
</dict>
</plist>
PLIST
    end

  end
end
