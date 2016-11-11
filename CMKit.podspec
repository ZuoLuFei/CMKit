
Pod::Spec.new do |s|
  s.name         = 'CMKit'
  s.version      = '0.0.3'
  s.summary      = 'A project about iOS development Contains lots of tools and Category.'
  s.homepage     = 'https://github.com/ZuoLuFei/CMKit'
  s.license      = 'MIT'
  s.author             = { 'ZuoLuFei' => 'yuan_ren_ge@163.com' }
  s.platform     = :ios, '7.0'
  s.source       = { :git => 'https://github.com/ZuoLuFei/CMKit.git', :tag => 's.version' }
  s.source_files  = 'CMKit/CMKit-Category(分类)/**/*.{h,m}'
  # s.frameworks  = 'UIKit'
  s.requires_arc = true

  s.subspec 'Category' do |category|
    category.source_files = 'CMKit/CMKit-Category(分类)/**/*.{h,m}'
  end

  s.subspec 'AlertView' do |alertView|
    alertView.source_files = 'CMKit/CMKit-Tool(工具类)/Tool-AlertView(警告框)/*.{h,m}'
  end

  s.subspec 'AnimationEffect' do |animationEffect|
    animationEffect.source_files = 'CMKit/CMKit-Tool(工具类)/Tool-AnimationEffect(动画特效)/*.{h,m}'
  end

  s.subspec 'Cryptor' do |cryptor|
    cryptor.source_files = 'CMKit/CMKit-Tool(工具类)/Tool-Cryptor(加密、解密)/*.{h,m}'
  end

  s.subspec 'ProgressHUD+CMKit' do |progressHUD|
    progressHUD.source_files = 'CMKit/CMKit-Tool(工具类)/Tool-HUD(提示框)/*.{h,m}'
    progressHUD.dependency 'MBProgressHUD', '~> 1.0.0'
  end

end
