//
//  CMSingleton.h
//  CMKit-HCCategory
//
//  Created by HC on 16/10/28.
//  Copyright © 2016年 HC. All rights reserved.
//


/**
 作用-->
 单例快速集成文件
 
 使用-->
 1. 导入 CMSingleton.h
 2. 在.h里调用 CMSingleton_h(类名)
 3. 在.m里调用 CMSingleton_m(类名)
 
 如对MBProgressHUD的经典单例再封装
 .h文件：CMSingleton_h(ProgressHUD)
 .m文件：CMSingleton_m(ProgressHUD)
 */


// .h文件
#define CMSingleton_h(name) + (instancetype)shared##name;


// .m文件
#if __has_feature(objc_arc) // ARC

#define CMSingleton_m(name) \
static id _instance = nil; \
+ (id)allocWithZone:(struct _NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
return _instance; \
} \
\
+ (instancetype)shared##name \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [[self alloc] init]; \
});\
return _instance; \
} \
+ (id)copyWithZone:(struct _NSZone *)zone \
{ \
return _instance; \
}

#else // 非ARC

#define CMSingleton_m(name) \
static id _instance; \
+ (id)allocWithZone:(struct _NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
return _instance; \
} \
\
+ (instancetype)shared##name \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [[self alloc] init]; \
}); \
return _instance; \
} \
\
- (oneway void)release \
{ \
\
} \
\
- (id)autorelease \
{ \
return _instance; \
} \
\
- (id)retain \
{ \
return _instance; \
} \
\
- (NSUInteger)retainCount \
{ \
return 1; \
} \
\
+ (id)copyWithZone:(struct _NSZone *)zone \
{ \
return _instance; \
}

#endif

