//
//  GetData.m
//  OnLineHappy
//
//  Created by Lc、 on 15/10/21.
//  Copyright © 2015年 Lc、. All rights reserved.
//

#import "GetData.h"

@implementation GetData

+(void)getWithURLString:(NSString *)urlStr andCallBack:(CallBack)callBack
{
    AFHTTPRequestOperationManager * mgr = [AFHTTPRequestOperationManager manager];
    [mgr GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        callBack(responseObject,nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        callBack(nil,error);
    }];
}

@end
