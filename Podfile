# Uncomment the next line to define a global platform for your project
# platform :ios, '10.0'

use_frameworks!
platform :ios, '10.0'
inhibit_all_warnings!

target 'ToolClass' do
  use_frameworks!


  pod 'AFNetworking'
  pod "Alamofire"
  pod 'Masonry'
  pod 'SnapKit'
  pod 'SwiftyJSON'
  pod 'MBProgressHUD'
  pod 'MJRefresh'
  pod 'ZLCollectionViewFlowLayout' 


  target 'ToolClassTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'ToolClassUITests' do
    # Pods for testing
  end

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      deployment_target = config.build_settings['IPHONEOS_DEPLOYMENT_TARGET']
      if !deployment_target.nil? && !deployment_target.empty? && deployment_target.to_f < 10.0
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '10.0'
      end
      
      # Exclude the 'ExampleFramework' from the simulator build
      
      
    end
  end
end
