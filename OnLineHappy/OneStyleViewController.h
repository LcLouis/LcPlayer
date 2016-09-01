//
//  OneStyleViewController.h
//  OnLineHappy
//
//  Created by Lc、 on 15/10/23.
//  Copyright © 2015年 Lc、. All rights reserved.
//

#import "ViewController.h"

@interface OneStyleViewController : ViewController
{
    //记录当前是否在加载中。yes 表示当前正在加载，no表示当前没有加载内容
    BOOL _IS_LOADING;
    //标记是上拉加载还是下拉刷新,YES表示加载，NO表示下拉刷新
    BOOL _IS_UP_PULL;
}
@property (copy, nonatomic) NSString * typeStr;

@property (copy, nonatomic) NSString * url;

@property (retain, nonatomic) UICollectionView * collectionView;

@end
