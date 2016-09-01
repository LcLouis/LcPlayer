//
//  GetData.h
//  OnLineHappy
//
//  Created by Lc、 on 15/10/21.
//  Copyright © 2015年 Lc、. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^CallBack)(id , NSError *);
@interface GetData : NSObject

+(void)getWithURLString:(NSString *)urlStr andCallBack:(CallBack)callBack;

@end
