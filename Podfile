source 'https://github.com/CocoaPods/Specs.git'
use_frameworks!
platform :ios, '9.0'

target 'ECaFT' do
	pod "SlidingTabBar"
	pod "SwiftyJSON"
	pod "Firebase/Core"
	pod "Firebase/Database"
	pod "Firebase/Storage”
	pod "ImageScrollView"
	pod 'SnapKit', '~> 4.0.0'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '4.0'
    end
  end
end
