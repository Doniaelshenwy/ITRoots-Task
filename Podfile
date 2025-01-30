# Uncomment the next line to define a global platform for your project
platform :ios, '12.0'

target 'ITRoots-Task' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for ITRoots-Task

   pod 'DropDown' 
   pod 'CDAlertView' 

end
post_install do |pi|
    pi.pods_project.targets.each do |t|
        t.build_configurations.each do |config|
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '15.0'
        end
    end
end 
