//
//  SecondCollectionViewCell.h
//  OnLineHappy
//
//  Created by Lc、 on 15/10/21.
//  Copyright © 2015年 Lc、. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"
#import "MyProtocol.h"
@interface SecondCollectionViewCell : UICollectionViewCell
<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,MyProtocol>
{
    
    AFHTTPRequestOperationManager * mgr;
}

@property (weak, nonatomic) IBOutlet UICollectionView *collerctionView;
@property (assign, nonatomic) id<MyProtocol> twoDelegate;

@end
