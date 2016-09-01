//
//  ScrollerUICollectionViewCell.h
//  OnLineHappy
//
//  Created by Lc、 on 15/10/22.
//  Copyright © 2015年 Lc、. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstCollectionViewCell.h"
@interface ScrollerUICollectionViewCell : UICollectionViewCell

@property (assign,nonatomic) id<FirstCollectionViewCellDelegate>delegate;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollerView;
@property (copy, nonatomic) NSArray * scrollerImgVArr;
@property (assign, nonatomic) NSArray * dataArr;
@end
