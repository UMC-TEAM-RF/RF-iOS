# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'RF' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  
  pod 'Alamofire'
  pod 'SnapKit', '~> 5.6.0'
  pod 'FSCalendar'
  pod 'Tabman', '~> 3.0'
  pod 'RxSwift', '6.5.0'
  pod 'RxCocoa', '6.5.0'
  pod 'Mantis', '~> 2.14.1'
  pod 'StompClientLib'
  pod 'RealmSwift', '~>10'

  post_install do |installer|
    installer.generated_projects.each do |project|
      project.targets.each do |target|
        target.build_configurations.each do |config|
          config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
        end
      end
    end
  end
end
