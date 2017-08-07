# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'RNApp' do
  # Uncomment the next line if you're using Swift or would like to use dynamic frameworks
  # use_frameworks!

  # Pods for RNApp

  target 'RNAppTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'RNAppUITests' do
    inherit! :search_paths
    # Pods for testing
  end
pod 'React', :path => './ReactComponents/node_modules/react-native', :subspecs => [
'Core',
  'ART',
  'RCTActionSheet',
  'RCTAdSupport',
  'RCTGeolocation',
  'RCTImage',
  'RCTNetwork',
  'RCTPushNotification',
  'RCTSettings',
  'RCTText',
  'RCTVibration',
  'RCTWebSocket',
  'RCTLinkingIOS',
]

pod "GameLive"

  # Explicitly include Yoga if you are using RN >= 0.42.0
#  pod "Yoga", :path => "./ReactComponents/node_modules/react-native/ReactCommon/yoga"
end
