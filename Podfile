source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'

use_frameworks!

pod 'OAuthSwift'
pod 'PocketAPI', :git => 'https://github.com/Pocket/Pocket-ObjC-SDK', :commit => '08b4cd79385f4084de70e797567937d568205ffa'

pod 'Haneke', '~> 1.0'
pod 'Prephirences'

def testing_pods
    pod 'Quick'
    pod 'Nimble'
end

target 'BancAppTests' do
    testing_pods
end

target 'BancAppUITests' do
    testing_pods
end

