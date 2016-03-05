//
//  NSObject+OLiNetEngine.m
//  OLiNetEngine
//
//  Created by Brooks on 15/6/30.
//  Copyright (c) 2015年 王建雨. All rights reserved.
//

#import "NSObject+OLiNetEngine.h"
#import <objc/runtime.h>

@implementation NSObject (OLiNetEngine)

/**
 *  根据数据集合&类型，获取对象
 *
 *  @param dictionary 数据集合
 *  @param className  类型，建议使用NSStringFromClass(cls)
 */
- (id)objectWithDictionary:(NSDictionary *)dictionary className:(NSString *)className
{
    if (![dictionary isKindOfClass:[NSDictionary class]]) return nil;
    return [self objectPropertyWithDictionary:dictionary className:className];
}

- (id)objectPropertyWithDictionary:(NSDictionary *)dictionary className:(NSString *)className
{
    NSString *className_ = CapitalizedFirstCharacter(className);
    
    id responseObject = NSClassFromString(className_).new;
    [self copyProperty2Object:responseObject withClass:[responseObject class] withDictionary:dictionary];
    return responseObject;
}

- (void)copyProperty2Object:(id)object withClass:(Class)objectClass withDictionary:(NSDictionary *)dictionary
{
    if (objectClass != [NSObject class] && object && dictionary) {
        unsigned propertyCount = 0;
        objc_property_t *properties = class_copyPropertyList(objectClass, &propertyCount);
        for ( int i = 0 ; i < propertyCount ; i++ ) {
            objc_property_t property = properties[i];
            NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
            id propertyValue = dictionary[propertyName];
            if (propertyValue) {
                if ([propertyValue isKindOfClass:[NSDictionary class]]) {
                    char *propertyType  = NULL;
                    propertyType = property_copyAttributeValue(property, "T");
                    id propertyObject = nil;
                    //此处是为了增强代码健壮性，增加判断，防止字符串截取挂掉
                    if ((propertyType != NULL) && (propertyType[0] == '@') && (strlen(propertyType) >= 3)) {
                        NSString *keyClassName = [NSString stringWithCString:strndup(propertyType+2, strlen(propertyType)-3) encoding:NSUTF8StringEncoding];
                        propertyObject = [self objectPropertyWithDictionary:propertyValue className:keyClassName];
                    }
                    else {
                        propertyObject = [self objectPropertyWithDictionary:propertyValue className:propertyName];
                    }
                    if (propertyObject) {
                        [object setValue:propertyObject forKey:propertyName];
                    }
                }
                else if ([propertyValue isKindOfClass:[NSArray class]]) {
                    id propertyObject = [self objectWithArray:propertyValue className:propertyName];
                    if (propertyObject) {
                        [object setValue:propertyObject forKey:propertyName];
                    }
                }
                else if ([propertyValue isKindOfClass:[NSString class]]) {
                    ChangedKeyword(propertyName);
                    [object setValue:propertyValue forKey:propertyName];
                }
                else if ([propertyValue isKindOfClass:[NSNumber class]]) {
                    [object setValue:[NSString stringWithFormat:@"%@", ((NSNumber*)propertyValue).description] forKey:propertyName];
                }
            }else{//增加类型判断，如果属性是int类型的，且propertyValue为0，则跳到如下操作。
                [object setValue:[NSString stringWithFormat:@"%d", (int)propertyValue] forKey:propertyName];
            }
        }
        free(properties);
        //子类重写父类的情况暂不考虑
        [self copyProperty2Object:object withClass:class_getSuperclass(objectClass) withDictionary:dictionary];
    }
}

- (id)objectWithArray:(NSArray *)array className:(NSString *)className
{
    NSString *className_ = ChangedSingularInfo(CapitalizedFirstCharacter(className).mutableCopy);
    
    NSMutableArray *propertyArray = [@[] mutableCopy];
    if ([array isKindOfClass:[NSArray class]]) {
        for (id obj in array) {
            id propertyValue = nil;
            if ([obj isKindOfClass:[NSDictionary class]]) {
                propertyValue = [self objectPropertyWithDictionary:obj className:className_];
            }
            else if ([obj isKindOfClass:[NSArray class]]) {
                propertyValue = [self objectWithArray:obj className:className_];
            }
            else {
                propertyValue = obj;
            }
            if (propertyValue) {
                [propertyArray addObject:propertyValue];
            }
        }
    }
    return propertyArray;
}

/** 获取当前对象的属性集合 */
- (NSDictionary *)propertyDictionary
{
    NSMutableDictionary *dictionary = [@{} mutableCopy];
    unsigned int propertyCount;
    objc_property_t *properties = class_copyPropertyList(object_getClass(self), &propertyCount);
    for(int i = 0 ; i < propertyCount ; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        id propertyValue = [self valueForKey:propertyName];
        if(propertyValue) {
            if ([propertyValue isKindOfClass:[NSObject class]]) {
                if ([propertyValue isKindOfClass:[NSArray class]]) {
                    propertyValue = [propertyValue propertyArray];
                }
                else if ([propertyValue isKindOfClass:[NSNumber class]] ||
                         [propertyValue isKindOfClass:[NSString class]]) {}
                else {
                    propertyValue = [propertyValue propertyDictionary];
                }
            }
            if (propertyValue) {
                [dictionary setValue:propertyValue forKey:propertyName];
            }
        }
    }
    free(properties);
    return dictionary;
}


- (NSArray *)propertyArray
{
    NSMutableArray *propertyArray = [@[] mutableCopy];
    if ([self isKindOfClass:[NSArray class]]) {
        id propertyValue = nil;
        for (id obj in (NSArray *)self) {
            if ([obj isKindOfClass:[NSArray class]]) {
                propertyValue = [obj propertyArray];
            }
            else if ([obj isKindOfClass:[NSString class]]) {
                propertyValue = obj;
            }
            else {
                propertyValue = [obj propertyDictionary];
            }
            if (propertyValue) {
                [propertyArray addObject:propertyValue];
            }
        }
    }
    return propertyArray;
}

//将字符串的首字母大写，其他字符不变
static inline NSString* CapitalizedFirstCharacter (NSString *string) {
    NSMutableString *capitalizedFirstCharacterString = string.mutableCopy;
    [capitalizedFirstCharacterString replaceCharactersInRange:NSMakeRange(0,1) withString:[capitalizedFirstCharacterString substringToIndex:1].uppercaseString];
    
    return capitalizedFirstCharacterString;
}

//将复数转换成单数，如：orders ——> order
static inline NSString* ChangedSingularInfo (NSString *string) {
    NSMutableString *singularInfo = string.mutableCopy;
    if ([singularInfo hasSuffix:@"s"]) {
        [singularInfo replaceCharactersInRange:NSMakeRange(singularInfo.length-1,1) withString:@""];
    }
    
    return singularInfo;
}

//将 [关键字] 类型的属性转换为 [非关键字] 如将 id——>ID, return——>RETURN , 其他的可以任意加 (已经兼容C语言的32个关键字)
static inline NSString* ChangedKeyword (NSString *string) {
    if ([string isEqualToString:@"do"] ||
        [string isEqualToString:@"if"] ||
        [string isEqualToString:@"int"] ||
        [string isEqualToString:@"for"] ||
        [string isEqualToString:@"auto"] ||
        [string isEqualToString:@"code"] ||
        [string isEqualToString:@"else"] ||
        [string isEqualToString:@"long"] ||
        [string isEqualToString:@"case"] ||
        [string isEqualToString:@"enum"] ||
        [string isEqualToString:@"char"] ||
        [string isEqualToString:@"goto"] ||
        [string isEqualToString:@"void"] ||
        [string isEqualToString:@"union"] ||
        [string isEqualToString:@"const"] ||
        [string isEqualToString:@"break"] ||
        [string isEqualToString:@"float"] ||
        [string isEqualToString:@"short"] ||
        [string isEqualToString:@"while"] ||
        [string isEqualToString:@"static"] ||
        [string isEqualToString:@"sizeof"] ||
        [string isEqualToString:@"extern"] ||
        [string isEqualToString:@"return"] ||
        [string isEqualToString:@"switch"] ||
        [string isEqualToString:@"struct"] ||
        [string isEqualToString:@"double"] ||
        [string isEqualToString:@"signed"] ||
        [string isEqualToString:@"typedef"] ||
        [string isEqualToString:@"default"] ||
        [string isEqualToString:@"unsigned"] ||
        [string isEqualToString:@"continue"] ||
        [string isEqualToString:@"register"] ||
        [string isEqualToString:@"volatile"])
    {
        //转换成大写
        string = [string uppercaseString];
    }
    
    return string;
}

@end
