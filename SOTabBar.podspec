#
# Be sure to run `pod lib lint SOTabBar.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SOTabBar'
  s.version          = '1.1.3'
  s.summary          = 'A light way to add customization with animation to your tab bar view'
  s.swift_version = "4.2"
# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
 It is an iOS UI library for adding animation to iOS tabbar items and icons
                       DESC

  s.homepage         = 'https://github.com/Ahmadalsofi/SOTabBar'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Ahmadalsofi' => 'alsofiahmad@yahoo.com' }
  s.source           = { :git => 'https://github.com/Ahmadalsofi/SOTabBar.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://www.linkedin.com/in/ahmad-alsofi-677787177/'

  s.ios.deployment_target = '9.3'

  s.source_files = 'SOTabBar/Classes/**/*'
  
  # s.resource_bundles = {
  #   'SOTabBar' => ['SOTabBar/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
