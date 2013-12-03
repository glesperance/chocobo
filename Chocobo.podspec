#
# Be sure to run `pod spec lint NAME.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# To learn more about the attributes see http://docs.cocoapods.org/specification.html
#
Pod::Spec.new do |s|
  s.name         = "Chocobo"
  s.version      = "0.1.0"
  s.summary      = "Backbone-ish up your iOS models"
  s.description  = <<-DESC
                    An optional longer description of Chocobo

                    * Markdown format.
                    * Don't worry about the indent, we strip it!
                   DESC
  s.homepage     = "https://github.com/PetroFeed/chocobo"
  # s.screenshots  = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license      = 'MIT'
  s.author       = { "markhazlett" => "mark@petrofeed.com" }
  s.source       = { :git => "http://github.com/PetroFeed/chocobo.git", :tag => s.version.to_s }

  s.platform     = :ios, '7.0'
  s.ios.deployment_target = '7.0'
  s.requires_arc = true

  s.source_files = 'Classes'
  s.resources = 'Assets'

  s.ios.exclude_files = 'Classes/osx'
  s.public_header_files = 'Classes/**/*.h'

  s.dependency "AFNetworking", "~> 2.0"
end
