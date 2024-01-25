#
# Be sure to run `pod lib lint ThirdPartLogin.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ThirdPartLogin'
  s.version          = '1.0.1'
  s.summary          = 'iOS developer tools'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/wangzhen0302/ThirdPartLogin'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'wangzhen0302' => 'winston.wang@uptech.ai' }
  s.source           = { :git => 'https://github.com/wangzhen0302/ThirdPartLogin.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '13.0'
  s.swift_version = '5.0'
  
#  s.default_subspec = "All"
#  
#  #所有广告
#  s.subspec "All" do |all|
#      all.dependency 'ThirdPartLogin/Core'
#      all.dependency 'ThirdPartLogin/Apple'
#      all.dependency 'ThirdPartLogin/FaceBook'
#      all.dependency 'ThirdPartLogin/Google'
#  end
  
  
  s.subspec "Core" do |core|
      core.source_files = 'ThirdPartLogin/Classes/Core/*'
  end
  
#  s.source_files = 'ThirdPartLogin/Classes/*'
  
  s.subspec 'Apple' do |apple|
      apple.dependency 'ThirdPartLogin/Core'
      apple.source_files = 'ThirdPartLogin/Classes/Apple/**/*'
  end
  
  s.subspec 'FaceBook' do |faceBook|
      faceBook.dependency 'ThirdPartLogin/Core'
      faceBook.dependency 'FBSDKCoreKit'
      faceBook.dependency 'FBSDKLoginKit'
      faceBook.source_files = 'ThirdPartLogin/Classes/FaceBook/**/*'
  end
  
  s.subspec 'Google' do |google|
      google.dependency 'ThirdPartLogin/Core'
      google.dependency 'GoogleSignIn'
      google.source_files = 'ThirdPartLogin/Classes/Google/**/*'
  end
  

  
  
#   s.resource_bundles = {
#     'ThirdPartLogin' => ['ThirdPartLogin/Assets/*.png']
#   }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
