# Uncomment the next line to define a global platform for your project
# platform :ios, '10.0'

target 'Roommate' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Roommate
	pod 'Alamofire'
	pod 'AlamofireObjectMapper'
	pod 'ObjectMapper'
	pod 'SDWebImage'
	pod “TTRangeSlider”
	pod 'GooglePlaces'
  	pod 'GooglePlacePicker'
  	pod 'GoogleMaps'
	pod 'ObjectMapper+Realm'
	pod 'SkyFloatingLabelTextField'
	pod 'Firebase/Core'
	pod 'MBProgressHUD'
	pod 'SwiftyJSON'

end

# Workaround for Cocoapods issue #7606
post_install do |installer|
    installer.pods_project.build_configurations.each do |config|
        config.build_settings.delete('CODE_SIGNING_ALLOWED')
        config.build_settings.delete('CODE_SIGNING_REQUIRED')
    end
end