//
//  AMZPlayer.h
//  AMZMediaPlayer
//
//  Created by JackWong on 15/3/23.
//  Copyright (c) 2015年 kingsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AMZMediaPlayback.h"
#import "AMZFFOptions.h"
#import "DrmRelativeModel.h"
#import "DrmRelativeAllModel.h"

#define kk_AMZM_VAL_TYPE__UNKNOWN  @"unknown"

#define kk_AMZM_KEY_STREAMS       @"streams"

typedef NS_ENUM(NSInteger, AMZPlayerState)
{
    AMZPlayerStateError,          //< Player has generated an error
    AMZPlayerStateIdle,
    AMZPlayerStateInitialized,
    AMZPlayerStatePreparing,
    AMZPlayerStatePrepared,
    AMZPlayerStatePlaying,        //< Stream is playing
    AMZPlayerStatePaused,         //< Stream is paused
    AMZPlayerStateCompleted,
    AMZPlayerStateStopped,        //< Player has stopped
    AMZPlayerStateSeekingForward
};

typedef NS_ENUM(NSInteger, AMZBufferingState)
{
    AMZPlayerBufferingStart,
    AMZPlayerBufferingEnd
};

@protocol AMZMediaPlayerDelegate;

extern NSString *const AMZMediaPlayerStateChanged;

extern NSString *const AMZMediaPlayerWithError;

@interface AMZPlayer : NSObject <AMZMediaPlayback>

@property (NS_NONATOMIC_IOSONLY, readonly)  UIView *videoView;

@property (NS_NONATOMIC_IOSONLY, weak) id<AMZMediaPlayerDelegate> delegate;

@property (NS_NONATOMIC_IOSONLY) NSTimeInterval currentPlaybackTime;

@property (NS_NONATOMIC_IOSONLY, readonly) NSTimeInterval duration;

@property (NS_NONATOMIC_IOSONLY, readonly) NSTimeInterval playableDuration;

@property (NS_NONATOMIC_IOSONLY, readonly) NSInteger bufferingProgress;

@property (NS_NONATOMIC_IOSONLY, readonly) BOOL isPreparedToPlay;

@property (NS_NONATOMIC_IOSONLY, readonly) AMZPlayerState state;

@property (NS_NONATOMIC_IOSONLY, readonly) NSDictionary *mediaMeta;

@property (NS_NONATOMIC_IOSONLY, readonly) MPMovieLoadState loadState;

@property (NS_NONATOMIC_IOSONLY, readonly) int64_t numberOfBytesTransferred;

@property (NS_NONATOMIC_IOSONLY, readonly) NSInteger videoWidth;

@property (NS_NONATOMIC_IOSONLY, readonly) NSInteger videoHeight;

@property (NS_NONATOMIC_IOSONLY) MPMovieControlStyle controlStyle;

@property (NS_NONATOMIC_IOSONLY) MPMovieScalingMode scalingMode;

@property (NS_NONATOMIC_IOSONLY) BOOL shouldAutoplay;

@property (NS_NONATOMIC_IOSONLY, readonly) CGFloat fpsInMeta;

@property (NS_NONATOMIC_IOSONLY, readonly) CGFloat fpsAtOutput;

/**
 *  统计性能频率，默认是1s
 */
@property (NS_NONATOMIC_IOSONLY) NSTimeInterval timeInterval;


/**
 *  初始化播放器
 *
 *  @param mUrl          视屏url
 *  @param options       
 *  @param isAllow       是否允许日志上传
 *  @param appIdentifier 应用唯一标识，由用户自定义(isAllow = NO，可为空，否则不可空)
 *  @param logType       日志类型，由用户自定义(isAllow = NO，可为空，否则不可空)
 *
 *  @return 播放器对象
 */
- (instancetype)initWithMURL:(NSURL *)mUrl
       withOptions:(AMZFFOptions *)options
          allowLog:(BOOL)isAllow
     appIdentifier:(NSString *)appIdentifier;

#pragma mark- 用户自定义打点数据

- (void)insertOneRecordWithBegainParam:(NSDictionary *)paramDic field:(NSString *)field;
- (void)insertOneRecordWithEndParam:(NSDictionary *)paramDic field:(NSString *)field;
- (void)insertOneRecordWithStatusParam:(NSDictionary *)paramDic field:(NSString *)field;

#pragma mark ---mark PlayerControl

- (void)play;

- (void)pause;

- (void)stop;

- (BOOL)isPlaying;

- (void)reset;

- (void)shutdown;

- (void)prepareToPlay;

- (void)seekTo:(long)msec;

- (void)setAMZPlayerVolume:(float)volume;

- (void)setAMZPlayerBrightness:(float)brightness;
/**
 *  The interception of the current video frame
 *
 *  @return a image
 */
- (UIImage *)thumbnailImageAtCurrentTime;
/**
 *  设置音频放大
 *
 *  @param amplify 音频放大比率
 */
- (void)setAudioAmplify:(float)amplify;
/**
 *  设置速率快放倍数
 *
 *  @param value 
 */
- (void)setRate:(float)value;

- (void)setAnalyzeduration:(int)duration;
/**
 *  <#Description#>
 *
 *  @param size <#size description#>
 */
- (void)setPlayerBuffersize:(int)size;
/**
 *  <#Description#>
 *
 *  @param localpath <#localpath description#>
 */
- (void)saveVideoLocalPath:(NSString *)localpath;

- (void)setDrmKey:(NSString *)drmVersion cek:(NSString *)cek;

- (void)setRelativeFullURL:(DrmRelativeAllModel *)drmRelativeAllModel;

- (void)setRelativeFullURLWithSecretKey:(NSString *)secretKey
                       drmRelativeModel:(DrmRelativeModel *)drmRelativeModel;



@end
/**
 *  AMZMediaPlayerDelegate
 */
@protocol AMZMediaPlayerDelegate <NSObject>

@optional

- (void)mediaPlayerStateChanged:(AMZPlayerState)PlayerState;

- (void)mediaPlayerTimeChanged:(NSNotification *)aNotification;

- (void)mediaPlayerWithError:(NSError *)error;

- (void)mediaPlayerCompleted:(AMZPlayer *)player;

- (void)mediaPlayerBuffing:(AMZBufferingState)bufferingState;

- (void)mediaPlayerSeekCompleted:(AMZPlayer *)player;

- (void)retiveDrmKey:(NSString *)drmVersion player:(AMZPlayer *)player;

@end

