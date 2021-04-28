# Uncomment the next line to define a global platform for your project
platform :ios, '12.0'

target 'iTunesMedia' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for iTunesMedia
  pod 'Alamofire', '~> 5.2.2'
  pod 'Kingfisher', '~> 5.14.1'
  pod 'RealmSwift', '~> 5.3.6'
  pod 'R.swift', '~> 5.2.2'
  pod 'RxCocoa', '~> 5.1.1'
  pod 'RxSwift', '~> 5.1.1'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
    end
  end
end
