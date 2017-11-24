Pod::Spec.new do |s|
  s.name     = 'PMSideMenuView_swif'
  s.version  = '1.0.1'
  s.license  = 'MIT'
  s.summary  = 'swift based popular side menu view.'
  s.homepage = 'https://github.com/peromasamune/PMSideMenuView_swift'
  s.author   = { "Peromasamune" => "peromasamune00375421@gmail.com" }
  s.source   = { :git => "https://github.com/peromasamune/PMSideMenuView_swift.git", :tag => "#{s.version}" }
  s.platform = :ios
  s.source_files = 'PMSideMenuViewController/*.{h,m,swift}'
  s.framework = 'UIKit' , 'QuartzCore'
end
