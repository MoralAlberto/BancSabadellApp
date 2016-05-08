source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'

use_frameworks!

pod 'OAuthSwift'
pod 'Haneke', '~> 1.0'
pod 'Prephirences'

def testing_pods
    pod 'Quick'
    pod 'Nimble'
    pod 'OHHTTPStubs'
end

target 'BancAppTests' do
    testing_pods
end

target 'BancAppUITests' do
    testing_pods
end

