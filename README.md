# CMKit
一个包含很多分类和工具类的快速集成项目。

使用前请先下载、运行并查看Demo。

/**********************************************************************/

##【导入】
CMKit支持手动导入和CocoaPods导入两种方式

##【手动导入】

根据目录结构，找到对应功能，将Tool目录中的文件拖入项目，再import相关头文件即可

##【CocoaPods安装及使用】
[CocoaPods](http://cocoapods.org)是一个关于Objective-C和Swift的第三方依赖库管理工具。可通过["Getting Started" guide for more information](https://github.com/AFNetworking/AFNetworking/wiki/Getting-Started-with-AFNetworking)了解更多。

###初次安装CocoaPods：

- 检查ruby源地址并替换
```bash
$ gem sources -l
```
- 移除ruby源地址，替换为国内阿里云ruby地址(原因你懂的)
```bash
$ gem sources --remove https://rubygems.org/
$ gem sources -a http://rubygems-china.oss.aliyuncs.com
```
- 再次检查ruby源地址
```bash
$ gem sources -l
```

- 安装CocoaPods
```bash
$ sudo gem install cocoapods
```

- 下载更新podspec库
```bash
$ pod setup
```
> 若在pod setup步骤后一直卡住，参照[使用CocoaPods时遇到pod setup失败的解决办法](http://www.cocoachina.com/bbs/read.php?tid=193398)

###Podfile导入使用
```ruby
platform :ios, ‘7.0’

target ‘TargetName’ do
pod 'CMKit', '~> 0.1.5’
pod 'AFNetworking', '~> 3.0'
end
```

###CMKit pod目录概述

####----------UTOUU 集成工具类(若只使用CMKit工具类中的指定功能，可根据如下目录单独导入)


整个工具类[具体地址](https://github.com/ZuoLuFei/CMKit)：pod 'CMKit', '~> 0.1.5'

    分类：pod 'CMKit/Category', '~> 0.1.5'

    警告框：pod 'CMKit/AlertView', '~> 0.1.5’

    动画效果：pod 'CMKit/AnimationEffect', '~> 0.1.5’

    HUD提示框：pod 'CMKit/ProgressHUD', '~> 0.1.5’

    二维码：pod 'CMKit/QRCode', '~> 0.1.5’

    新特性：pod 'CMKit/NewFeatures', '~> 0.1.5’  (目前使用传入图片数组即可，后期会不断完善)

    公用父类：pod 'CMKit/CommonSuperClass', '~> 0.1.5’  (目前暂时只整理CMBaseViewController和CMBaseNavigationController，根据使用若有补充之处，请及时提出)

    相机、相册：pod 'CMKit/ImagePicker', '~> 0.1.5’    打开系统自带相册选择和相机，多选图片请移步下面'图片选择器'框架

    城市列表选择：pod 'CMKit/CityList', '~> 0.1.5’

    FMDB操作：pod 'CMKit/FMDBOperation', '~> 0.1.5’
    
    图片浏览器：pod 'CMKit/PictureBrowse', '~> 0.1.5’

    手势、指纹解锁：pod 'CMKit/UnLock', '~> 0.1.5’



####----------常用第三方框架选型

上拉、下拉刷新[具体地址](https://github.com/CoderMJLee/MJRefresh)：pod 'MJRefresh', '~> 3.1.12'     

无限轮播[具体地址](https://github.com/gsdios/SDCycleScrollView)：pod 'SDCycleScrollView','~> 1.64' 

垂直瀑布流[具体地址](https://github.com/chiahsien/CHTCollectionViewWaterfallLayout)：pod 'CHTCollectionViewWaterfallLayout'

图片缓存[具体地址](https://github.com/rs/SDWebImage)：pod 'SDWebImage', '~> 4.0.0-beta2' 

网络请求[具体地址](https://github.com/AFNetworking/AFNetworking)：pod 'AFNetworking', '~> 3.0'

    CMKit网络请求demo中包含网络请求基础工具类CMHttpClientTool和业务封装工具类CMPostRequest，请参考CMKit->Example->CMKit->CMKit-Tool(工具类)->FrameworkManager->NetWork(网络请求)->Sample->Networking Extenslons） 

图片选择器[具体地址](https://github.com/banchichen/TZImagePickerController)：pod 'TZImagePickerController'

字典转模型工具[具体地址](https://github.com/CoderMJLee/MJExtension#Features):pod 'MJExtension'

侧滑菜单控制器[具体地址](https://github.com/pkluz/PKRevealController):pod 'PKRevealController'

图片裁剪[具体地址](https://github.com/TimOliver/TOCropViewController):pod 'TOCropViewController'

二维码扫描、生成[具体地址](https://github.com/MxABC/LBXScan):pod 'LBXScan','~> 1.1.1'


    
/**********************************************************************/

##【示例】

请下载、运行并查看Demo


/**********************************************************************/

##【CMKit目录说明】

1 CMKit 

    CMKit.h  框架头文件，记录目标框架当前版本，开发作者，所有的分类(Category)头文件及部分工具类头文件
    
    CMKit-Category(分类)

        Category-Foundation 所有Foundation框架分类目录

        Category-UIKit 所有UIKit框架分类目录

    CMKit-Tool(工具类)

        FrameworkManager   第三方框架选型

            #### 框架目录，开发中可直接手动导入目标项目，请参考Demo使用

        UtouuCreate  UTOUU编写的工具类

            #### 工具类目录，开发中可直接手动导入目标项目，请参考Demo使用

2 Example 演示Demo目录

3 CMKit.podspec Cocoapods编辑目录

4 LICENSE 许可证文件 (默认MIT许可证)

5 README.md github说明文件

/**********************************************************************/

##【功能列表】

Demo共分为三个版块，目前集成功能如下：

1 UtouuCreate

    1.1 AlterView(警告框)

    1.2 AnimationEffect(动画特效)

    1.3 MBProgressHUD(提示框)

    1.4 ImagePicker(相机/相册)

    1.5 Cryptor(数据加密/解密)

    1.6 3D Touch

    1.7 CommonSuperClass(共用父类)--目前暂时只整理UIViewController和UINavigationController

    1.8 NewFeatures(新特性)

    1.9 ThirdPartyLogin(第三方登录) -- 新浪微博

    1.10 Macro(宏)

    1.11 SystemFontInfo(系统字体列表)

    1.12 CityList(城市列表选择)

    1.13 FMDBOperation(FMDB操作)

    1.14 PictureBrowse(图片浏览器)

    1.15 UnLock(手势、指纹解锁)


2 FrameworkManager

    2.1 NetWork(网络请求)

    2.2 ImageCache(图片缓存)

    2.3 ImageMultipleChoice(图片多选器)

    2.4 Refresh(上拉/下拉刷新)

    2.5 CyclePicture(无限轮播)

    2.6 VerticalWaterFlow(垂直瀑布流)

    2.7 RevealController(侧滑菜单控制器)

    2.8 CropPicture(图片裁剪)

    2.9 QRCode(二维码/条形码)

3 Foundation分类(关于Foundation框架的分类)

    3.1 NSArray+CMKit

    3.2 NSData+CMKit

    3.3 NSDate+CMKit

    3.4 NSDictionary+CMKit

    3.5 NSFileManager+CMKit

    3.6 NSMutableArray+CMKit

    3.7 NSMutableDictionary+CMKit

    3.8 NSNumber+CMKit

    3.9 NSObject+CMKit

    3.10 NSProcessInfo+CMKit

    3.11 NSString+CMKit


4 UIKit分类(关于UIKit框架的分类)

    4.1 UIButton+CMKit

    4.2 UIColor+CMKit

    4.3 UIDevice+CMKit

    4.4 UIImage+CMKit

    4.5 UIImageView+CMKit

    4.6 UILabel+CMKit

    4.7 UINavigationBar+CMKit

    4.8 UIScreen+CMKit

    4.9 UIScrollView+CMKit

    4.10 UITableView+CMKit

    4.11 UITextField+CMKit

    4.12 UIToolbar+CMKit

    4.13 UIView+CMKit

    4.14 UIWebView+CMKit

    4.15 UIWindow+CMKit

    4.16 UIView+Layout


