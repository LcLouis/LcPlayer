//
//  FirstCollectionViewCell.h
//  OnLineHappy
//
//  Created by Lc、 on 15/10/21.
//  Copyright © 2015年 Lc、. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"
#import "MyProtocol.h"

@protocol FirstCollectionViewCellDelegate <NSObject>

@end

@interface FirstCollectionViewCell : UICollectionViewCell
<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,FirstCollectionViewCellDelegate>
{
    //记录当前是否在加载中。yes 表示当前正在加载，no表示当前没有加载内容
    BOOL _IS_LOADING;
    
    AFHTTPRequestOperationManager * mgr;
}



@property (assign, nonatomic) id<MyProtocol>oneDelegate;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;



@end
