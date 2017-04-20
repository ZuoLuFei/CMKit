
Pod::Spec.new do |s|
  s.name         = 'CMKit'
  s.version      = '0.2.2'
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

  s.subspec 'FirstLetterCityList' do |firstLetterCityList|
    firstLetterCityList.source_files = 'CMKit/CMKit-Tool(工具类)/Tool-CityList(城市列表)/FirstLetterCityList(城市首字母列表)/**/*.{h,m}'
    firstLetterCityList.resources = 'CMKit/CMKit-Tool(工具类)/Tool-CityList(城市列表)/FirstLetterCityList(城市首字母列表)/CMCityList.bundle'
  end

  s.subspec 'ThreeLevelCityList' do |threeLevelCityList|
    threeLevelCityList.source_files = 'CMKit/CMKit-Tool(工具类)/Tool-CityList(城市列表)/ThreeLevelCityList(城市三级列表)/**/*.{h,m}'
    threeLevelCityList.resources = 'CMKit/CMKit-Tool(工具类)/Tool-CityList(城市列表)/ThreeLevelCityList(城市三级列表)/CMThreeLevelCityList.bundle'
  end

  s.subspec 'FMDBOperation' do |fmdbOperation|
    fmdbOperation.source_files = 'CMKit/CMKit-Tool(工具类)/Tool-FMDBOperation(FMDB操作)/**/*.{h,m}'
    fmdbOperation.library = 'sqlite3'
  end

  s.subspec 'PictureBrowse' do |pictureBrowse|
    pictureBrowse.source_files = 'CMKit/CMKit-Tool(工具类)/Tool-PictureBrowse(图片浏览器)/*.{h,m}'
    pictureBrowse.dependency 'SDWebImage', '~> 4.0.0-beta2'
    pictureBrowse.resources = 'CMKit/CMKit-Tool(工具类)/Tool-PictureBrowse(图片浏览器)/MSSBrowse.bundle'
  end

  s.subspec 'UnLock' do |unLock|
    unLock.source_files = 'CMKit/CMKit-Tool(工具类)/Tool-UnLock(手势、指纹解锁)/*.{h,m}'
    unLock.resources = 'CMKit/CMKit-Tool(工具类)/Tool-UnLock(手势、指纹解锁)/DWUNlock.bundle'
  end

  s.subspec 'SemiScene' do |semiScene|
    semiScene.source_files = 'CMKit/CMKit-Tool(工具类)/Tool-SemiScene(半挂式场景切换)/*.{h,m}'
    semiScene.frameworks  = 'QuartzCore'
  end

  s.subspec 'DropdownAmplify' do |dropdownAmplify|
    dropdownAmplify.source_files = 'CMKit/CMKit-Tool(工具类)/Tool-DropdownAmplify(下拉放大)/*.{h,m}'
  end

  s.subspec 'ShimmerLabel' do |shimmerLabel|
    shimmerLabel.source_files = 'CMKit/CMKit-Tool(工具类)/Tool-ShimmerLabel(闪烁文字)/*.{h,m}'
  end

  s.subspec 'ProgressView' do |progressView|
    progressView.source_files = 'CMKit/CMKit-Tool(工具类)/Tool-ProgressView(进度条)/*.{h,m}'
    progressView.dependency 'UICountingLabel'
  end


end
