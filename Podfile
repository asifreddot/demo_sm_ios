# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'smart to do' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
	pod 'IQKeyboardManagerSwift', '~> 6.3.0'
    pod 'Firebase/Auth'
    pod 'Firebase/Crashlytics'
    pod 'Firebase/Analytics'
    pod 'GoogleSignIn'

end

post_install do |installer|
    installer.generated_projects.each do |project|
        project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '16.0'
            end
        end
    end
end
