# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'NoHandl' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Example
  pod 'UICircularProgressRing'
  pod 'Alamofire', '~> 4.0'
  pod 'SwiftyJSON'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |configuration|
      configuration.build_settings['SWIFT_VERSION'] = "4.2"
    end
  end
end