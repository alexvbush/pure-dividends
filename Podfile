# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

target 'Pure Dividends' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Pure Dividends

  pod 'RIBs', '~> 0.9.0'

  pod 'RxSwift', '~> 4.0.0'
  pod 'Money-FlightSchool', '~> 1.1.1'
  pod 'SnapKit', '~> 5.0.0'

  target 'Pure DividendsTests' do
    inherit! :search_paths
    # Pods for testing
    pod 'RxBlocking', '~> 4.0.0'
  end

  target 'Pure DividendsUITests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'PDNetworking' do
    pod 'Alamofire'
    pod 'RxAlamofire', '~> 4.0.0'
    target 'PDNetworkingTests' do
      pod 'RxBlocking', '~> 4.0.0'
    end
  end

end
