platform :ios, '14.0'
use_frameworks!

def core_infra
  pod 'SwiftLint'
end

target 'MovieDB' do 
  core_infra

  target 'MovieDBTests' do
    inherit! :search_paths
  end
end
