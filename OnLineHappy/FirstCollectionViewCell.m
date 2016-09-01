//
//  FirstCollectionViewCell.m
//  OnLineHappy
//
//  Created by Lc、 on 15/10/21.
//  Copyright © 2015年 Lc、. All rights reserved.
//

#import "FirstCollectionViewCell.h"
#import "RecommendCollectionViewCell.h"
#import "GetData.h"
#import "UIImageView+WebCache.h"
#import "HeaderCollectionReusableView.h"
#import "ScrollerUICollectionViewCell.h"
#import "NewPeopleCollectionViewCell.h"



@implementation FirstCollectionViewCell
{
    NSMutableArray * _dataArr;
    NSMutableArray * _oneDataArr;
    NSMutableArray * _scrollerImgVArr;
    NSMutableArray * _newPeopleArr;
}
- (void)awakeFromNib {
    mgr = [AFHTTPRequestOperationManager manager];
    _dataArr = [[NSMutableArray alloc]init];
    _scrollerImgVArr = [[NSMutableArray alloc]init];
    _newPeopleArr = [[NSMutableArray alloc]init];
    [self setRefresh];
    [self setCollectionView];
    [self getData];
    
}

-(void)setRefresh{
    //下拉刷新
    [self.collectionView addHeaderWithTarget:self action:@selector(headerRefreshing) dateKey:@"table"];
    //设置头部提示
    self.collectionView.headerPullToRefreshText = @"下拉可以刷新";
    self.collectionView.headerReleaseToRefreshText = @"松开可以刷新";
    self.collectionView.headerRefreshingText = @"下载中";
}

-(void)headerRefreshing
{
    [self getData];
}


-(void)getData{
    
    if(_IS_LOADING){
        NSLog(@"正在加载内容，无法执行新的加载操作");
        return;
    }
    _IS_LOADING = YES;
    
    
    
    
    
    
    [GetData getWithURLString:DOUYU_COLLECTION andCallBack:^(id data, NSError * error) {
//        _IS_LOADING = NO;
        [_dataArr removeAllObjects];
        [_dataArr addObjectsFromArray:data[@"data"]];
        [self dataEnd];
//        [self.collectionView reloadData];
    }];
    
    [GetData getWithURLString:DOUYU_HEADSCO andCallBack:^(id data, NSError * error) {
//        _IS_LOADING = NO;
        [_scrollerImgVArr removeAllObjects];
        [_scrollerImgVArr addObjectsFromArray:data[@"data"]];
        [self dataEnd];
//        [self.collectionView reloadData];
    }];
    
    [GetData getWithURLString:DOUYU_NEWPEO andCallBack:^(id data, NSError * error) {
//        _IS_LOADING = NO;
        [_newPeopleArr removeAllObjects];
        [_newPeopleArr addObjectsFromArray:data[@"data"]];
        [self dataEnd];
//        [self.collectionView reloadData];
    }];
    
}
//判断数据是否刷新完
-(void)dataEnd
{
    
    if(_dataArr.count !=0 && _scrollerImgVArr.count !=0 && _newPeopleArr.count !=0 ){
        //停止刷新
        _IS_LOADING = NO;
        [self.collectionView reloadData];
        [self.collectionView headerEndRefreshing];
    }
}


-(void)setCollectionView{
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumInteritemSpacing = 5;
    flowLayout.minimumLineSpacing = 5;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.collectionView.collectionViewLayout = flowLayout;
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 44, 0);
    
    
    
    
    //注册
    [self.collectionView registerNib:[UINib nibWithNibName:@"RecommendCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"RecommendCollectionViewCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"ScrollerUICollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ScrollerUICollectionViewCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"NewPeopleCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"NewPeopleCollectionViewCell"];

    //注册头视图
    [_collectionView registerNib:[UINib nibWithNibName:@"HeaderCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderCollectionReusableView"];
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return _dataArr.count+2;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(section == 0){
        if(_dataArr.count != 0 ){
            return 1;
        }else{
            return 0;
        }
    }else if(section == 1){
        if(_newPeopleArr.count != 0 ){
            return 1;
        }else{
            return 0;
        }
    }else{
        return ((NSArray *)_dataArr[section-2][@"roomlist"]).count;
    }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0){
        
        NSString * cellID = @"ScrollerUICollectionViewCell";
        ScrollerUICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
        cell.scrollerView.contentSize = CGSizeMake(self.collectionView.frame.size.width*_scrollerImgVArr.count, self.collectionView.frame.size.width/2);
        
        cell.delegate = self;
        cell.dataArr = _scrollerImgVArr;
        
       //删除重复创建
        while(cell.scrollerView.subviews.firstObject){
               [cell.scrollerView.subviews.firstObject removeFromSuperview];
        }
        
        cell.scrollerImgVArr = _scrollerImgVArr;
        
        
        
        
        for(int i = 0 ; i < _scrollerImgVArr.count;i++){
            UIImageView * imgV = [[UIImageView alloc]initWithFrame:M_RECT(self.collectionView.frame.size.width*i, 0, self.collectionView.frame.size.width, self.collectionView.frame.size.width/2)];
            [cell.scrollerView addSubview:imgV];
            [imgV sd_setImageWithURL:[NSURL URLWithString:_scrollerImgVArr[i][@"pic_url"]] placeholderImage:[UIImage imageNamed:@"HDAddPhoto.png"]];
            UIView * view = [[UIView alloc]initWithFrame:M_RECT(0, imgV.frame.size.height-30, cell.scrollerView.frame.size.width, 30)];
            [imgV addSubview:view];
            view.backgroundColor = [UIColor blackColor];
            view.alpha = 0.4;
            UILabel * label = [[UILabel alloc]initWithFrame:M_RECT(10, imgV.frame.size.height-30, cell.scrollerView.frame.size.width/3*2, 30)];
            [imgV addSubview:label];
            label.textColor = [UIColor whiteColor];
            label.font = [UIFont systemFontOfSize:14];
            label.text = _scrollerImgVArr[i][@"title"];
            
        }
        
        
        
        return cell;
    }else if(indexPath.section == 1){
        //新秀主播
        NSString * cellID = @"NewPeopleCollectionViewCell";
        NewPeopleCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
        cell.scrollerView.contentSize = CGSizeMake(cell.scrollerView.frame.size.width/3*_newPeopleArr.count+20, cell.scrollerView.frame.size.width/2-40);
        cell.scrollerView.showsHorizontalScrollIndicator = NO;
        
        cell.delegate = self;
        cell.dataArr = _newPeopleArr;
        
        while(cell.scrollerView.subviews.firstObject){
            [cell.scrollerView.subviews.firstObject removeFromSuperview];
        }
        
        
        for (int i = 0; i < _newPeopleArr.count; i++) {
            UIView * view = [[UIView alloc]initWithFrame:M_RECT(cell.scrollerView.frame.size.width/3*i, 0, cell.scrollerView.frame.size.width/3, cell.scrollerView.frame.size.width/2-40)];
            [cell.scrollerView addSubview:view];
            
            //添加点击手势
            view.tag = 100+i;
            UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGR:)];
            [view addGestureRecognizer:tapGR];
            
            
            //设置头像
            UIImageView * ImgV = [[UIImageView alloc]initWithFrame:M_RECT(0, 5, cell.scrollerView.frame.size.width/3-40, cell.scrollerView.frame.size.width/3-40)];
            ImgV.layer.cornerRadius = (cell.scrollerView.frame.size.width/3-40)/2;
            ImgV.layer.masksToBounds = YES;
            [view addSubview:ImgV];
            //设置label
            
            UILabel * nameLab = [[UILabel alloc]initWithFrame:M_RECT(0, self.collectionView.frame.size.width/3-30, self.collectionView.frame.size.width/3-25, 15)];
            [nameLab setCenter:CGPointMake(ImgV.center.x, nameLab.center.y)];
            nameLab.font = [UIFont systemFontOfSize:14];
            nameLab.textAlignment = NSTextAlignmentCenter;
            [view addSubview:nameLab];
            
            UILabel * styleLab = [[UILabel alloc]initWithFrame:M_RECT(0, self.collectionView.frame.size.width/3-10, self.collectionView.frame.size.width/3-25, 15)];
            [styleLab setCenter:CGPointMake(ImgV.center.x, styleLab.center.y)];
            styleLab.textAlignment = NSTextAlignmentCenter;
            styleLab.textColor = [UIColor grayColor];
            styleLab.font = [UIFont systemFontOfSize:12];
            [view addSubview:styleLab];
            
            [ImgV sd_setImageWithURL:[NSURL URLWithString:_newPeopleArr[i][@"room_src"]] placeholderImage:[UIImage imageNamed:@"HDAddPhoto.png"]];
            nameLab.text = _newPeopleArr[i][@"nickname"];
            styleLab.text = _newPeopleArr[i][@"game_name"];
            
        }
        return cell;
        
    }else{
    
    NSString * cellID = @"RecommendCollectionViewCell";
    RecommendCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
    [cell.backImgV sd_setImageWithURL:[NSURL URLWithString:_dataArr[indexPath.section-2][@"roomlist"][indexPath.row][@"room_src"]] placeholderImage:[UIImage imageNamed:@"HDAddPhoto.png"]];
    cell.nameLab.text = _dataArr[indexPath.section-2][@"roomlist"][indexPath.row][@"nickname"];
    cell.numPeopleLab.text = [NSString stringWithFormat:@"%@",_dataArr[indexPath.section-2][@"roomlist"][indexPath.row][@"online"]];
    cell.titleLab.text = _dataArr[indexPath.section-2][@"roomlist"][indexPath.row][@"room_name"];
    
    return cell;
    }
}

//设置cell宽高、
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0){
        return CGSizeMake(kScreenSize.width-20, self.collectionView.frame.size.width/2);
    }else if(indexPath.section == 1){
        return CGSizeMake(kScreenSize.width-20, self.collectionView.frame.size.width/2-40);
    }else{
        return CGSizeMake(self.frame.size.width/2-30, self.frame.size.width/3-20);
    }
}



-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    HeaderCollectionReusableView * view = nil;
    if(kind == UICollectionElementKindSectionHeader){
    view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderCollectionReusableView" forIndexPath:indexPath];
    NSLog(@"%p",view.titleLab);
     
        if(indexPath.section == 0){
            view.titleLab.text = @"";
            
        }else if(indexPath.section == 1){
            if(_newPeopleArr.count == 0){
                view.titleLab.text = @"";
            }else{
                view.titleLab.text = @"新秀主播";
            }
        }else{
            view.titleLab.text = _dataArr[indexPath.section-2][@"title"];
        }
    }
    return view;
}
//设置头部宽高、
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if(section == 0){
        return CGSizeMake(self.collectionView.frame.size.width, 0);
    }else if(section ==1){
        if(_newPeopleArr.count == 0){
            return CGSizeMake(self.collectionView.frame.size.width, 0);
        }else{
            return CGSizeMake(self.collectionView.frame.size.width, 40);
        }
    }else{
        return CGSizeMake(self.collectionView.frame.size.width, 40);
    }
}


//点击事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0 && _scrollerImgVArr.count != 0){
        
    }else if(indexPath.section == 1 && _newPeopleArr.count != 0){
        
        
        
    }else if(_dataArr.count != 0){
        NSString * roomId = _dataArr[indexPath.section-2][@"roomlist"][indexPath.row][@"room_id"];
        NSString * number = [NSString stringWithFormat:@"%@",_dataArr[indexPath.section-2][@"roomlist"][indexPath.row][@"online"]];
        
        [self.oneDelegate presnetPlayViewControllerWithRoomId:roomId andNum:number];
    
        
    }
}


//手势
-(void)tapGR:(UITapGestureRecognizer *)tapGR
{
    UIView * view = (UIView *)tapGR.view;
    NSLog(@"%ld",view.tag);
    switch (view.tag) {
        case 100:
            [self.oneDelegate presnetPlayViewControllerWithRoomId:_newPeopleArr[0][@"room_id"] andNum:_newPeopleArr[0][@"online"]];
            break;
        case 101:
            [self.oneDelegate presnetPlayViewControllerWithRoomId:_newPeopleArr[1][@"room_id"] andNum:_newPeopleArr[1][@"online"]];
            break;
        case 102:
            [self.oneDelegate presnetPlayViewControllerWithRoomId:_newPeopleArr[2][@"room_id"] andNum:_newPeopleArr[2][@"online"]];
            break;
        case 103:
            [self.oneDelegate presnetPlayViewControllerWithRoomId:_newPeopleArr[3][@"room_id"] andNum:_newPeopleArr[3][@"online"]];
            break;
        case 104:
            [self.oneDelegate presnetPlayViewControllerWithRoomId:_newPeopleArr[4][@"room_id"] andNum:_newPeopleArr[4][@"online"]];
            break;
        case 105:
            [self.oneDelegate presnetPlayViewControllerWithRoomId:_newPeopleArr[5][@"room_id"] andNum:_newPeopleArr[5][@"online"]];
            break;
        case 106:
            [self.oneDelegate presnetPlayViewControllerWithRoomId:_newPeopleArr[6][@"room_id"] andNum:_newPeopleArr[6][@"online"]];
            break;
        case 107:
           [self.oneDelegate presnetPlayViewControllerWithRoomId:_newPeopleArr[7][@"room_id"] andNum:_newPeopleArr[7][@"online"]];
            break;
        case 108:
           [self.oneDelegate presnetPlayViewControllerWithRoomId:_newPeopleArr[8][@"room_id"] andNum:_newPeopleArr[8][@"online"]];
            break;
        case 109:
           [self.oneDelegate presnetPlayViewControllerWithRoomId:_newPeopleArr[9][@"room_id"] andNum:_newPeopleArr[9][@"online"]];
            break;
            
            
        default:
            break;
    }
    
    //    if(view.tag == 100){
    //        NSLog(@"1");
    //        [((FirstCollectionViewCell *)self.delegate).oneDelegate presnetPlayViewControllerWithRoomId:self.dataArr[0][@"room"][@"room_id"] andNum:self.dataArr[0][@"room"][@"online"]];
    //    }else if (self.scrollerView.contentOffset.x == self.scrollerView.frame.size.width){
    //        NSLog(@"2");
    //        [((FirstCollectionViewCell *)self.delegate).oneDelegate presnetPlayViewControllerWithRoomId:self.dataArr[1][@"room"][@"room_id"] andNum:self.dataArr[0][@"room"][@"online"]];
    //    }else if(self.scrollerView.contentOffset.x == self.scrollerView.frame.size.width*2){
    //        [((FirstCollectionViewCell *)self.delegate).oneDelegate presnetPlayViewControllerWithRoomId:self.dataArr[2][@"room"][@"room_id"] andNum:self.dataArr[0][@"room"][@"online"]];
    //    }else if (self.scrollerView.contentOffset.x == self.scrollerView.frame.size.width*3){
    //        [((FirstCollectionViewCell *)self.delegate).oneDelegate presnetPlayViewControllerWithRoomId:self.dataArr[3][@"room"][@"room_id"] andNum:self.dataArr[0][@"room"][@"online"]];
    //    }else if (self.scrollerView.contentOffset.x == self.scrollerView.frame.size.width*4){
    //        [((FirstCollectionViewCell *)self.delegate).oneDelegate presnetPlayViewControllerWithRoomId:self.dataArr[4][@"room"][@"room_id"] andNum:self.dataArr[0][@"room"][@"online"]];
    //    }else if (self.scrollerView.contentOffset.x == self.scrollerView.frame.size.width*5){
    //        [((FirstCollectionViewCell *)self.delegate).oneDelegate presnetPlayViewControllerWithRoomId:self.dataArr[5][@"room"][@"room_id"] andNum:self.dataArr[0][@"room"][@"online"]];
    //    }
    
}

@end
