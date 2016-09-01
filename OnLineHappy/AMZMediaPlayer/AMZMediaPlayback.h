/*
 * AMZMediaPlayback.h
 *
 * Copyright (c) 2013 
 *
 * This file is part of AMZPlayer.
 *
 * AMZPlayer is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * AMZPlayer is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with AMZPlayer; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>


@protocol AMZMediaPlayback;


#pragma mark AMZMediaPlayback

@protocol AMZMediaPlayback <NSObject>


#pragma mark Notifications

#ifdef __cplusplus
#define AMZ_EXTERN extern "C" __attribute__((visibility ("default")))
#else
#define AMZ_EXTERN extern __attribute__((visibility ("default")))
#endif

//AMZ_EXTERN NSString *const AMZMediaPlaybackIsPreparedToPlayDidChangeNotification;
//AMZ_EXTERN NSString *const AMZMoviePlayerLoadStateDidChangeNotification;
//AMZ_EXTERN NSString *const AMZMoviePlayerPlaybackDidFinishNotification;
//AMZ_EXTERN NSString *const AMZMoviePlayerPlaybackStateDidChangeNotification;

@end

#pragma mark KSYMediaResource

@protocol AMZMediaSegmentResolver <NSObject>

- (NSString *)urlOfSegment:(int)segmentPosition;

@end
