//
//  DownLoad.h
//  OnLineHappy
//
//  Created by Lc、 on 15/10/21.
//  Copyright © 2015年 Lc、. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GetData.h"

typedef void(^CallBack)(id,NSError *);
@interface DownLoad : NSObject



+(void)downWithRoomId:(NSString *)roomId andCallBack:(CallBack)callback;

@end
