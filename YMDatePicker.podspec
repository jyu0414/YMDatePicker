Pod::Spec.new do |spec|
  spec.name         = "YMDatePicker"
  spec.version      = "v0.1"
  spec.summary      = "The calendar-style date picker with weekly and monthly mode"
  spec.homepage     = "https://github.com/jyu0414/YMDatePicker"
  spec.license      = { :type => 'MIT', :file => 'LICENSE' }
  spec.author             = { "Masakaz Ozaki" => "masakaz@ieee.org" }
  spec.source       = { :git => "https://github.com/jyu0414/YMDatePicker.git", :tag => "#{spec.version}" }
  spec.source_files  = "Sources/**/**/*.{swift,xib,h}"
  spec.swift_version = "5.1"
  spec.platform = :ios, "11.0"
end
