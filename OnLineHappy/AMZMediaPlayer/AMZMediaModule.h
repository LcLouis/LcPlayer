//
//  AMZMediaModule.h
//  AMZMediaPlayer
//
//  Created by KingSoft on 14-3-14.
//  Copyright (c) 2014年 bilibili. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AMZMediaModule : NSObject

+ (AMZMediaModule *)sharedModule;

@property(atomic, getter=isAppIdleTimerDisabled)            BOOL appIdleTimerDisabled;
@property(atomic, getter=isMediaModuleIdleTimerDisabled)    BOOL mediaModuleIdleTimerDisabled;

@end
