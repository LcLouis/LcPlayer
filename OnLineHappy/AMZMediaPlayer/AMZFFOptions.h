//
//  AMZFFOptions.h
//  AMZMediaPlayer
//
//  Created by  on 13-10-17.
//  Copyright (c) 2013年 bilibili. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum AMZAVDiscard{
    /* We leave some space between them for extensions (drop some
     * keyframes for intra-only or drop just some bidir frames). */
    AMZ_AVDISCARD_NONE    =-16, ///< discard nothing
    AMZ_AVDISCARD_DEFAULT =  0, ///< discard useless packets like 0 size packets in avi
    AMZ_AVDISCARD_NONREF  =  8, ///< discard all non reference
    AMZ_AVDISCARD_BIDIR   = 16, ///< discard all bidirectional frames
    AMZ_AVDISCARD_NONKEY  = 32, ///< discard all frames except keyframes
    AMZ_AVDISCARD_ALL     = 48, ///< discard all
} AMZAVDiscard;

typedef struct KSYMediaPlayer KSYMediaPlayer;

@interface AMZFFOptions : NSObject

+ (AMZFFOptions *)optionsByDefault;

- (void)applyTo:(KSYMediaPlayer *)mediaPlayer;

@property(nonatomic) AMZAVDiscard skipLoopFilter;

@property(nonatomic) AMZAVDiscard skipFrame;

@property(nonatomic) int frameBufferCount;

@property(nonatomic) int maxFps;

@property(nonatomic) int frameDrop;

@property(nonatomic) BOOL pauseInBackground;

@property(nonatomic, strong) NSString* userAgent;

@property(nonatomic) int64_t timeout; ///< read/write timeout, -1 for infinite, in microseconds

@end
