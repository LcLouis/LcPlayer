//
//  ThirdCollectionViewCell.h
//  OnLineHappy
//
//  Created by Lc、 on 15/10/21.
//  Copyright © 2015年 Lc、. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyProtocol.h"
@interface ThirdCollectionViewCell : UICollectionViewCell
<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    //记录当前是否在加载中。yes 表示当前正在加载，no表示当前没有加载内容
    BOOL _IS_LOADING;
    //标记是上拉加载还是下拉刷新,YES表示加载，NO表示下拉刷新
    BOOL _IS_UP_PULL;
    AFHTTPRequestOperationManager * mgr;
}


@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (assign, nonatomic) id<MyProtocol>threeDelegate;

@end
