# CMKit
一个包含很多分类和工具类的快速集成项目。

使用前请先下载、运行并查看Demo。

/************************************导入**********************************/

【手动导入】

根据目录结构，找到对应功能，将Tool目录中的文件拖入项目，再import相关头文件即可

【CocoaPods导入】

整个工具类：pod 'CMKit', '~> 0.0.7'

    分类：pod 'CMKit/Category', '~> 0.0.7'

    警告框：pod 'CMKit/AlertView', '~> 0.0.7’

    动画效果：pod 'CMKit/AnimationEffect', '~> 0.0.7’

    HUD提示框：pod 'CMKit/ProgressHUD', '~> 0.0.7’

    二维码：pod 'CMKit/QRCode', '~> 0.0.7’

    新特性：pod 'CMKit/NewFeatures', '~> 0.0.7’  (目前使用传入图片数组即可，后期会不断完善)

    公用父类：pod 'CMKit/CommonSuperClass', '~> 0.0.7’  (目前暂时只整理CMBaseViewController和CMBaseNavigationController，根据使用若有补充之处，请及时提出)

    3DTouch：待更新

    相机、相册：待更新

    加密、解密：待更新

上拉、下拉刷新：pod 'MJRefresh', '~> 3.1.12'

图片缓存：pod 'SDWebImage', '~> 4.0.0-beta2'

无限轮播：pod 'SDCycleScrollView','~> 1.64'

网络请求：pod 'AFNetworking', '~> 3.0'  （CMKit网络请求demo中包含网络请求基础工具类CMHttpClientTool和业务封装工具类CMPostRequest，请参考）

    




/**********************************************************************/

【示例】

请下载、运行并查看Demo


/**********************************************************************/

【CMKit目录说明】

A.CMKit/CMKit.h   框架头文件，记录目标框架当前版本，开发作者，所有的分类(Category)头文件及部分工具类头文件，可根据项目需求自行导入相关头文件或使用CocoaPods导入使用

B.CMKit/CMKit-Category/Category-Foundation 整理的所有Foundation框架分类目录

C.CMKit/CMKit-Category/Category-UIKit 整理的所有UIKit框架分类目录

D.CMKit/CMKit-Tool/Tool-####/Sample 工具类演示Demo目录，仅做参考，不导入目标项目

E.CMKit/CMKit-Tool/Tool-####/Tool 工具类目录，开发中直接导入目标项目参考Demo使用


/**********************************************************************/
【功能列表】

Demo共分为三个版块，目前集成功能如下：

1 Tool

    1.1 NetWork(网络请求)

    1.2 ImageCache(图片缓存)

    1.3 AlterView(警告框)

    1.4 QRCode(二维码/条形码)

    1.5 AnimationEffect(动画特效)

    1.6 MBProgressHUD(提示框)

    1.7 ImagePicker(相机/相册)

    1.8 Refresh(上拉/下拉刷新)

    1.9 CyclePicture(无限轮播)

    1.10 Cryptor(数据加密/解密)

    1.11 增加3D Touch功能

    1.12 增加CommonSuperClass(共用父类)--目前暂时只整理UIViewController和UINavigationController

    1.13 增加NewFeatures(新特性)

    1.14 ThirdPartyLogin(第三方登录) -- 新浪微博

    1.15 Macro(宏)

2.Foundation分类(关于Foundation框架的分类)

3.UIKit分类(关于UIKit框架的分类)
