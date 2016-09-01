//
//  ThirdCollectionViewCell.m
//  OnLineHappy
//
//  Created by Lc、 on 15/10/21.
//  Copyright © 2015年 Lc、. All rights reserved.
//

#import "ThirdCollectionViewCell.h"
#import "GetData.h"
#import "RecommendCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
@implementation ThirdCollectionViewCell
{
    NSMutableArray * _dataArr;
}
- (void)awakeFromNib {
    _dataArr = [[NSMutableArray alloc]init];
    [self setRefresh];
    [self setCollectionView];
    [self getDataWith:DOUYU_ZHIBO];
}
-(void)setRefresh{
    //下拉刷新
    [self.collectionView addHeaderWithTarget:self action:@selector(headerRefreshing) dateKey:@"table"];
    //设置头部提示
    self.collectionView.headerPullToRefreshText = @"下拉可以刷新";
    self.collectionView.headerReleaseToRefreshText = @"松开可以刷新";
    self.collectionView.headerRefreshingText = @"下载中";
    //上啦加载
    [self.collectionView addFooterWithTarget:self action:@selector(footerRefreshing)];
    //设置底部提示
    self.collectionView.footerPullToRefreshText = @"继续向上拉可以加载";
    self.collectionView.footerReleaseToRefreshText = @"放开我。我要刷新";
    self.collectionView.footerRefreshingText = @"加载中";
}

-(void)headerRefreshing
{
    //标记当前是下拉刷新
    _IS_UP_PULL = NO;
    
    [self getDataWith:DOUYU_ZHIBO];

}
-(void)footerRefreshing
{
    //标记当前是上拉加载。
    _IS_UP_PULL = YES;
    
    static int num = 40;
    [self loadWithnum:num];
    num = num + 20;

}

-(void)loadWithnum:(NSInteger)number{
    NSString * str = [NSString stringWithFormat:@"http://www.douyutv.com/api/v1/live?aid=ios&auth=e7c4dea108f43868b0e15ff320c69d7f&client_sys=ios&limit=%ld&offset=0&time=1445304060",number];
    [self getDataWith:str];
}

-(void)setCollectionView
{
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.minimumLineSpacing = 10;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.collectionView.collectionViewLayout = flowLayout;
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 10, 44, 10);
    
    //注册
    [self.collectionView registerNib:[UINib nibWithNibName:@"RecommendCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"RecommendCollectionViewCell"];
}




-(void)getDataWith:(NSString *)str
{
    if(_IS_LOADING){
        NSLog(@"正在加载内容，无法执行新的加载操作");
        return;
    }
    _IS_LOADING = YES;
    
    [GetData getWithURLString:str andCallBack:^(id data, NSError * error) {
        //不管是上拉/下拉 还是加载成功，失败 都要把加载中得标记设置为no，同时结束刷新状态
        _IS_LOADING = NO;
        
        if(_IS_UP_PULL){
            [self.collectionView footerEndRefreshing];
        }else{
            [self.collectionView headerEndRefreshing];
        }
        
        _dataArr = data[@"data"];
        NSLog(@"%@",_dataArr);
        [self.collectionView reloadData];
    }];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSLog(@"%ld",_dataArr.count);
    return _dataArr.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString * cellID = @"RecommendCollectionViewCell";
    RecommendCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
    [cell.backImgV sd_setImageWithURL:[NSURL URLWithString:_dataArr[indexPath.row][@"room_src"]] placeholderImage:[UIImage imageNamed:@"HDAddPhoto.png"]];
    
    cell.nameLab.text = _dataArr[indexPath.row][@"nickname"];
    cell.numPeopleLab.text = [NSString stringWithFormat:@"%@",_dataArr[indexPath.row][@"online"]];
    cell.titleLab.text = _dataArr[indexPath.row][@"room_name"];
    
    return cell;
}

//设置cell宽高、
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.frame.size.width/2-20, self.frame.size.width/3-20);
}


//点击事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(_dataArr.count != 0){
        NSString * roomId = _dataArr[indexPath.row][@"room_id"];
        NSString * number = [NSString stringWithFormat:@"%@",_dataArr[indexPath.row][@"online"]];
        [self.threeDelegate presnetPlayViewControllerWithRoomId:roomId andNum:number];
    }
}


@end
