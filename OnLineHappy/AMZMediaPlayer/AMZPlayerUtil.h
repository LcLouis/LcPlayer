//
//  AMZPlayerUtil.h
//  AMZMediaPlayer
//
//  Created by JackWong on 15/5/8.
//  Copyright (c) 2015年 kingsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AMZPlayerUtil : NSObject
+ (NSString *)URLEncodedString:(NSString *)str;
+ (NSString *)amzPlaySignatureWithsecretKey:(NSString *)secretKey
                                  httpVerb:(NSString *)httpVerb
                                    expire:(NSString *)expire
                                     nonce:(NSString *)nonce;

+ (NSUInteger)getTimeIntervalSinceNow:(NSTimeInterval)timeInterval;
@end
