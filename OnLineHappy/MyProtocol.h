//
//  MyProtocol.h
//  OnLineHappy
//
//  Created by Lc、 on 15/10/23.
//  Copyright © 2015年 Lc、. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MyProtocol <NSObject>

@optional
-(void)presnetPlayViewControllerWithRoomId:(NSString *)roomID andNum:(NSString *)number;

-(void)pushOneStyleViewControlWithGame_Id:(NSString *)gameId andTypeStr:(NSString *)typeStr;

@end
