#
# Be sure to run `pod lib lint DSControls.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'DSControls'
  s.version          = '0.9.1'
  s.summary          = 'iOS UIView/CALayer Animations Sequence, Groups and Stacks'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Fast create animations sequences, groups, Stacks. See Readme and Example for more information.
                       DESC

  s.homepage         = 'https://github.com/DimasSup/DSControls'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'DimasSup' => 'dima.teleban@gmail.com' }
  s.source           = { :git => 'https://github.com/DimasSup/DSControls.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.3'

#  s.source_files = 'DSControls/Classes/**/*'
  s.frameworks = 'UIKit'
  
  s.subspec 'Animations' do |anims|
	  anims.source_files   = 'DSControls/Classes/{AnimationSupport}/**/*'
	  anims.public_header_files = 'DSControls/Classes/{AnimationSupport}/*.h'
  end
  
  s.subspec 'Controls' do |controls|
	  controls.source_files   = 'DSControls/Classes/{Controls}/**/*'
	  controls.public_header_files = 'DSControls/Classes/{Controls}/**/*.h'
  end
  
  # s.resource_bundles = {
  #   'DSControls' => ['DSControls/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  
  # s.dependency 'AFNetworking', '~> 2.3'
end
