# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'DanBee_iOS' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  inhibit_all_warnings!
  # Pods for DanBee_iOS
  pod 'SwiftLint'
  pod 'SideMenu', '~> 6.0'
  pod 'Alamofire', '~> 4.8.2'
  pod 'RxSwift', '~> 5.0'
  pod 'RxCocoa', '~> 5.0'
  pod 'SwiftyJSON', '~> 4.0'
  pod 'NMapsMap', '~> 3.2.0'
  pod 'CheckboxButton'
  pod 'RxOptional', '~> 4.0.0'
  pod 'MaterialCard', '~> 1.1.4'

  post_install do |installer|
    installer.pods_project.targets.each do |target|
      if ['CheckboxButton'].include? target.name
        target.build_configurations.each do |config|
          config.build_settings['SWIFT_VERSION'] = '4'
        end
      end
    end
  end

  
  target 'DanBee_iOSTests' do
    inherit! :search_paths
    # Pods for testing
  end
end
