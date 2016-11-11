
Pod::Spec.new do |s|
  s.name         = 'CMKit'
  s.version      = '0.0.1'
  s.summary      = 'A project about iOS development Contains lots of tools and Category.'
  s.homepage     = 'https://github.com/ZuoLuFei/CMKit'
  s.license      = 'MIT'
  s.author             = { 'ZuoLuFei' => 'yuan_ren_ge@163.com' }
  s.platform     = :ios, '7.0'
  s.source       = { :git => 'https://github.com/ZuoLuFei/CMKit.git', :tag => '0.0.1' }
  s.source_files  = 'CMKit/CMKit-Category(分类)/**/*.{h,m}'
  # s.framework  = 'UIKit'
  s.requires_arc = true

  s.subspec 'Category' do |category|
    category.source_files = 'CMKit/CMKit-Category(分类)/**/*.{h,m}'
  end

  s.subspec 'AlertView' do |alertView|
    alertView.source_files = 'CMKit/CMKit-Tool(工具类)/Tool-AlertView(警告框)/*.{h,m}'
  end

end
