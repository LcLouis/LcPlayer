//
//  VideoViewController.h
//  KS3PlayerDemo
//
//  Created by Blues on 15/3/18.
//  Copyright (c) 2015年 KSY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMZPlayer.h"
#import "MediaControlViewController.h"

@interface VideoViewController : UIViewController <KSYMediaPlayDelegate>{
    
    BOOL _pauseInBackground;
}

@property (nonatomic, strong) NSURL *videoUrl;
@property (nonatomic) BOOL isFullScreen;
@property (nonatomic, assign) BOOL isCycleplay;
@property (nonatomic,assign) NSUInteger motionInterfaceOrientation;
@property (readonly)            BOOL fullScreenModeToggled;
@property (nonatomic,assign)UIDeviceOrientation beforeOrientation;
@property (nonatomic,assign)UIDeviceOrientation deviceOrientation;


@property (copy, nonatomic) NSString * playStr;

@property (copy, nonatomic) NSString * number;


- (AMZPlayer *)player;
//- (void)setFullscreen:(BOOL)isFullscreen;
- (void)launchFullScreen;
- (void)minimizeVideo;
@end
