# CMKit
A project about iOS development Contains lots of tools and Category.


Getting Started【开始使用】
Features【能做什么】
.....


Installation【安装】
From CocoaPods【使用CocoaPods】
pod 'CMKit' ->'0.1.0'

Manually【手动导入】
.....

Examples【示例】
.....

/**********************************************************************/
CMKit目录说明

A.CMKit/CMKit.h   框架头文件，记录目标框架当前版本，开发作者，所有的分类(Category)头文件及部分工具类头文件，可根据项目需求自行导入相关头文件

B.CMKit/CMKit-Category/Category-Foundation 整理的所有Foundation框架分类目录

C.CMKit/CMKit-Category/Category-UIKit 整理的所有UIKit框架分类目录

D.CMKit/CMKit-Tool/Tool-####/Sample 工具类演示Demo目录，仅做参考，不导入目标项目

E.CMKit/CMKit-Tool/Tool-####/Tool 工具类目录，开发中直接导入目标项目参考Demo使用

/**********************************************************************/

2016-11-8 Version：1.0.1 Build：1

更新内容：

1.修改CMKit.pch 和 info.plist 的预编译地址为相对地址，避免编译时找不到pch和plist文件

2.增加3D Touch功能

3.增加CommonSuperClass(共用父类)--目前暂时只整理UIViewController和UINavigationController

4.增加NewFeatures(新特性)

5.增加README.md说明文档

/**********************************************************************/

2016-11-3 Version：1.0 Build：1

更新内容：

一.第一次整合CMKit，共分为三个版块

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

1.10 ThirdPartyLogin(第三方登录) -- 新浪微博

1.11 Macro(宏)

1.12 Cryptor(数据加密/解密)

2.Foundation分类(关于Foundation框架的分类)

3.UIKit分类(关于UIKit框架的分类)
