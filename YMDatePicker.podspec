Pod::Spec.new do |spec|
  spec.name         = "YMDatePicker"
  spec.version      = "0.3"
  spec.summary      = "The calendar-style date picker with weekly and monthly mode"
  spec.homepage     = "https://github.com/jyu0414/YMDatePicker"
  spec.license      = { :type => 'MIT', :file => 'LICENSE' }
  spec.author             = { "Masakaz Ozaki" => "masakaz@ieee.org" }
  spec.source       = { :git => "https://github.com/jyu0414/YMDatePicker.git", :tag => "v0.3" }
  spec.source_files  = "Sources/**/*.{swift,h}"
  spec.resources = "Sources/**/*.{json,png,xib}"
  spec.swift_version = "5.1"
  spec.platform = :ios, "11.0"
  spec.frameworks = "UIKit"

end
