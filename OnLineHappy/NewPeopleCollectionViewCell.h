//
//  NewPeopleCollectionViewCell.h
//  OnLineHappy
//
//  Created by Lc、 on 15/10/22.
//  Copyright © 2015年 Lc、. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstCollectionViewCell.h"
@interface NewPeopleCollectionViewCell : UICollectionViewCell

@property (assign,nonatomic) id<FirstCollectionViewCellDelegate>delegate;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollerView;

@property (assign, nonatomic) NSArray * dataArr;

@end
