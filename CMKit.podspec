
Pod::Spec.new do |s|
  s.name         = 'CMKit'
  s.version      = '0.1.3'
  s.summary      = 'A project about iOS development Contains lots of tools and Category.'
  s.homepage     = 'https://github.com/ZuoLuFei/CMKit'
  s.license      = 'MIT'
  s.author             = { 'ZuoLuFei' => 'yuan_ren_ge@163.com' }
  s.platform     = :ios, '7.0'
  s.source       = { :git => 'https://github.com/ZuoLuFei/CMKit.git', :tag => s.version }
  # s.frameworks  = 'UIKit'
  s.public_header_files = 'CMKit/CMKit.h'
  s.source_files = 'CMKit/CMKit.h'
  s.requires_arc = true

  s.subspec 'Category' do |category|
    category.source_files = 'CMKit/CMKit-Category(分类)/**/*.{h,m}'
  end

  s.subspec 'AlertView' do |alertView|
    alertView.source_files = 'CMKit/CMKit-Tool(工具类)/Tool-AlertView(警告框)/*.{h,m}'
  end

  s.subspec 'AnimationEffect' do |animationEffect|
    animationEffect.source_files = 'CMKit/CMKit-Tool(工具类)/Tool-AnimationEffect(动画特效)/**/*.{h,m}'
    animationEffect.dependency 'CMKit/Category'
  end

  s.subspec 'ProgressHUD' do |progressHUD|
    progressHUD.source_files = 'CMKit/CMKit-Tool(工具类)/Tool-HUD(提示框)/*.{h,m}'
    progressHUD.resources = 'CMKit/CMKit-Tool(工具类)/Tool-HUD(提示框)/MBProgressHUD+CMKit.bundle'
    progressHUD.frameworks   = 'CoreGraphics', 'QuartzCore'
  end

  s.subspec 'QRCode' do |qrCode|
    qrCode.source_files = 'CMKit/CMKit-Tool(工具类)/Tool-QRCode(二维码)/*.{h,m}'
    qrCode.resources = 'CMKit/CMKit-Tool(工具类)/Tool-QRCode(二维码)/CMQRCodeManager.bundle'
    qrCode.dependency 'CMKit/AlertView'
    qrCode.frameworks  = 'AVFoundation'
  end

  s.subspec 'CommonSuperClass' do |commonSuperClass|
    commonSuperClass.source_files = 'CMKit/CMKit-Tool(工具类)/Tool-CommonSuperClass(共用父类)/*.{h,m}'
  end

  s.subspec 'NewFeatures' do |newFeatures|
    newFeatures.source_files = 'CMKit/CMKit-Tool(工具类)/Tool-NewFeatures(新特性)/*.{h,m}'
  end

  s.subspec 'ImagePicker' do |imagePicker|
    imagePicker.source_files = 'CMKit/CMKit-Tool(工具类)/Tool-ImagePicker(相机、相册)/CMImagePickerManager.{h,m}'
    imagePicker.frameworks  = 'AVFoundation','AssetsLibrary','Photos'
  end

  s.subspec 'CityList' do |cityList|
    cityList.source_files = 'CMKit/CMKit-Tool(工具类)/Tool-CityList(城市列表)/**/*.{h,m}'
    cityList.resources = 'CMKit/CMKit-Tool(工具类)/Tool-CityList(城市列表)/CMCityList.bundle'
  end

  s.subspec 'FMDBOperation' do |fmdbOperation|
    fmdbOperation.source_files = 'CMKit/CMKit-Tool(工具类)/Tool-FMDBOperation(FMDB操作)/**/*.{h,m}'
    fmdbOperation.library = 'sqlite3'
  end


end
