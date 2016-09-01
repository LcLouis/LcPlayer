//
//  HeaderCollectionReusableView.h
//  OnLineHappy
//
//  Created by Lc、 on 15/10/21.
//  Copyright © 2015年 Lc、. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeaderCollectionReusableView : UICollectionReusableView

@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@property (weak, nonatomic) IBOutlet UIButton *moreBtn;

//+(instancetype)headViewWithCollectionView:(UICollectionView *)collection indexPath:(NSIndexPath *)indexPath;

@end
