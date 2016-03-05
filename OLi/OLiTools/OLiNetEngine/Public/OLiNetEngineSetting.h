//
//  OLiNetEngineSetting.h
//  OLiNetEngine
//
//  Created by Brooks on 15/6/30.
//  Copyright (c) 2015年 王建雨. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "OLiNetEngine.h"

//#warning 发布必须移除Debug目录  及以下框内的全部宏定义 by Brooks
//1 修改为最新版本号
//2 确认以下框内全部注释掉

/**==================================================================*/
//发布请注释 输出NSLOG等
#define OLi_HTTP_DEBUG_REQUEST           //请求NSLOG
#define OLi_HTTP_DEBUG_RESPONSE          //返回NSLOG
#define OLi_HTTP_DEBUG_REQUEST_DOMAIN    //请求的接口和ServiceName NSLOG
#define OLi_HTTP_DEBUG_REQUEST_DOMAIN_InterFace //请求的接口

//正式、测试地址切换、UMeng事件、页面跟踪 总开关，发布请注释
#define OLi_Server_Debug
////发布必须移除Debug目录


//  协议版本号
#define OLi_ProtocolVer                  @"20151012001"

//打印调试记录 OLi_UMENG调试，禁止修改！！！！！！
#ifdef OLi_Server_Debug

#define def_ShowLog             YES //友盟的log
#define def_TEST                YES
#define OLiLog(fmt, ...)         NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);

#else

#define def_ShowLog             NO
#define def_TEST                NO
#define OLiLog(fmt, ...)

#endif


typedef struct _APIDomainDic {
    __unsafe_unretained NSString		*stringDomain;//域名地址
} APIDomainDic;

//这里的第几行对应下面的type 的int数值
static const APIDomainDic DomainDic[] = {
    //type 数值为0:
    {@"http://bkcar.cn"}, //正式地址
    //type 数值为1:
//    {@"http://bbs.fblife.com/"} //测试地址
    {@"https://github.com/"}
    //https://github.com/thoughtbot/Markoff/archive/master.zip
};

typedef enum {
    outer_Domain = 0,             //外部正式地址域名Type
    test_Domain = 1               //测试域名Type
} InterfaceURLType;

@interface OLiNetEngineSetting : NSObject

@end

