#
# Be sure to run `pod lib lint TTPromptKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'TTPromptKit'
  s.version          = '0.1.3'
  s.summary          = 'TTPromptKit'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/ClaudeLi/TTPromptKit.git'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'ClaudeLi' => 'claudeli@yeah.net' }
  s.source           = { :git => 'https://github.com/ClaudeLi/TTPromptKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.public_header_files = 'TTPromptKit/TTPromptKit.h'
  s.source_files = 'TTPromptKit/TTPromptKit.h'

  s.subspec 'TTAlert' do |ss|
    ss.source_files = 'TTPromptKit/TTAlert/**/*'
  end

  s.subspec 'TTGuide' do |ss|
    ss.source_files = 'TTPromptKit/TTGuide/**/*'
  end

  s.subspec 'TTHUD' do |ss|
    ss.source_files = 'TTPromptKit/TTHUD/**/*'
    ss.dependency 'MBProgressHUD', '~> 0.9.2'
  end

  # s.resource_bundles = {
  #   'TTPromptKit' => ['TTPromptKit/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
end
