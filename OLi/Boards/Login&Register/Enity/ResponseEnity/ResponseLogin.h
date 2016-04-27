//
//  ResponseLogin.h
//  OLi
//
//  Created by Brooks on 16/4/27.
//  Copyright © 2016年 王建雨. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RspInfo;
@class UserInfo;

@interface ResponseLogin : NSObject

@property (nonatomic, strong)RspInfo *rspInfo;
@property (nonatomic, strong)UserInfo *userInfo;

@end

@interface UserInfo : NSObject
@property (nonatomic, copy)NSString *id;
@property (nonatomic, copy)NSString *account;
@property (nonatomic, copy)NSString *nickname;
@property (nonatomic, copy)NSString *realname;
@property (nonatomic, copy)NSString *regionname;
@property (nonatomic, copy)NSString *examdate;
@property (nonatomic, copy)NSString *mobile;

@end

//{
//    "rspInfo": {
//        "rspType": "响应类型",
//        "rspCode": "1000",
//        "rspDesc": "登录成功"
//    },
//    "rspData": {
//        "userInfo": {
//            "id": "1",
//            "account": "fengweichao@hotmail.com",
//            "nickname": "",
//            "realname": "",
//            "regionname": "山东省",
//            "examdate": "2016-5-10",
//            "mobile": "18600642006"
//        }
//    }
//}
