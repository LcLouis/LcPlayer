//
//  SecondCollectionViewCell.m
//  OnLineHappy
//
//  Created by Lc、 on 15/10/21.
//  Copyright © 2015年 Lc、. All rights reserved.
//

#import "SecondCollectionViewCell.h"
#import "GetData.h"
#import "UIImageView+WebCache.h"
#import "StyleCollectionViewCell.h"
@implementation SecondCollectionViewCell
{
    NSMutableArray * _dataArr;
}

- (void)awakeFromNib {
    _dataArr = [[NSMutableArray alloc]init];
    [self setRefresh];
    [self setCollectionView];
    [self getData];
}

-(void)setRefresh{
    //下拉刷新
    [self.collerctionView addHeaderWithTarget:self action:@selector(headerRefreshing) dateKey:@"table"];
    //设置头部提示
    self.collerctionView.headerPullToRefreshText = @"下拉可以刷新";
    self.collerctionView.headerReleaseToRefreshText = @"松开可以刷新";
    self.collerctionView.headerRefreshingText = @"下载中";
}

-(void)headerRefreshing
{
    [self getData];
    [self.collerctionView headerEndRefreshing];
}

-(void)setCollectionView
{
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.minimumLineSpacing = 10;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.collerctionView.collectionViewLayout = flowLayout;
    
    self.collerctionView.contentInset = UIEdgeInsetsMake(0, 10, 44, 10);
    //注册
    [self.collerctionView registerNib:[UINib nibWithNibName:@"StyleCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"StyleCollectionViewCell"];
}

-(void)getData
{
    [GetData getWithURLString:DOUYU_LANMU andCallBack:^(id data, NSError * error) {
        NSLog(@"%@",data);
        _dataArr =[NSMutableArray arrayWithArray:data[@"data"]];
        NSMutableArray * testArr = [NSMutableArray arrayWithArray:data[@"data"]];
        
        for(NSDictionary * dic in testArr){
            if([dic[@"online_room_ios"] isEqualToString:@"0"]){
                [_dataArr removeObject:dic];
            }
        }
       
        
        [self.collerctionView reloadData];
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
    
    NSString * cellID = @"StyleCollectionViewCell";
    StyleCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
    [cell.backImagV sd_setImageWithURL:[NSURL URLWithString:_dataArr[indexPath.row][@"game_src"]] placeholderImage:[UIImage imageNamed:@"HDAddPhoto.png"]];
    cell.titleLab.text = _dataArr[indexPath.row][@"game_name"];
    
    return cell;
}

//设置cell宽高、
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.frame.size.width/3-20, self.frame.size.height/3);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(_dataArr.count != 0){
        
        NSString * str =@"http://www.douyutv.com/api/v1/live/%@?aid=ios&auth=0dcdbbe7460b1c1eddc0e9e93cfb2994&client_sys=ios&limit=20&offset=0&time=1445599140";
        NSString * url = [NSString stringWithFormat:str,_dataArr[indexPath.row][@"cate_id"]];
        
        [self.twoDelegate pushOneStyleViewControlWithGame_Id:url andTypeStr:_dataArr[indexPath.row][@"cate_id"]];
    }
}

@end
