#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint lifecycle_events.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'lifecycle_events'
  s.version          = '1.0.0'
  s.summary          = 'Detect app lifecycle events'
  s.description      = <<-DESC
  A Flutter plugin which detects app lifecycle events like moving to and from foreground, background and context switching.
                       DESC
  s.homepage         = 'https://github.com/daughterlycare/flutter_lifecycle_events'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Daughterly Care Community Services Limited' => 'it@daughterlycare.com.au' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '11.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
