//
//  DouYuTVViewController.m
//  OnLineHappy
//
//  Created by Lc、 on 15/10/20.
//  Copyright © 2015年 Lc、. All rights reserved.
//

#import "DouYuTVViewController.h"

#import "FirstCollectionViewCell.h"
#import "SecondCollectionViewCell.h"
#import "ThirdCollectionViewCell.h"
#import "GetData.h"
#import "MyProtocol.h"
#import "PlayViewController.h"
#import "VideoViewController.h"
#import "OneStyleViewController.h"

@interface DouYuTVViewController ()
<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,MyProtocol>
{
    UICollectionView * _baseCollectionView;
    UIView * lineView;
    UIButton * btn1;
    UIButton * btn2;
    UIButton * btn3;
}

@end

@implementation DouYuTVViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"斗鱼";

    [self setupCollectionView];
}





- (void)setupCollectionView{
    //初始化一个collection的布局
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
    //item之间的间距
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    //设置集合视图的滚动方向 (水平)
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _baseCollectionView = [[UICollectionView alloc]initWithFrame:M_RECT(0,94, kScreenSize.width, kScreenSize.height-108) collectionViewLayout:flowLayout];
    [self.view addSubview:_baseCollectionView];
    _baseCollectionView.delegate = self;
    _baseCollectionView.dataSource = self;
    _baseCollectionView.pagingEnabled = YES;
    _baseCollectionView.bounces = NO;
    _baseCollectionView.showsHorizontalScrollIndicator = NO;
    _baseCollectionView.backgroundColor = [UIColor whiteColor];
//    _baseCollectionView.contentInset=UIEdgeInsetsMake(-44, 0, 0, 0);
    //注册cell
    [_baseCollectionView registerNib:[UINib nibWithNibName:@"FirstCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"FirstCollectionViewCell"];
    [_baseCollectionView registerNib:[UINib nibWithNibName:@"SecondCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"SecondCollectionViewCell"];
    [_baseCollectionView registerNib:[UINib nibWithNibName:@"ThirdCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ThirdCollectionViewCell"];
    
    lineView = [[UIView alloc]initWithFrame:M_RECT(0, 92, kScreenSize.width/3, 2)];
    lineView.backgroundColor = oneColor;
    [self.view addSubview:lineView];
    
    btn1 = [[UIButton alloc]initWithFrame:M_RECT(0, 64, kScreenSize.width/3, 30)];
    [self.view addSubview:btn1];
    btn1.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn1 setTitleColor:oneColor forState:UIControlStateSelected];
    [btn1 setTitle:@"推荐" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(btn1Click) forControlEvents:UIControlEventTouchUpInside];
    btn1.selected = YES;
    
    btn2 = [[UIButton alloc]initWithFrame:M_RECT(kScreenSize.width/3, 64, kScreenSize.width/3, 30)];
    [self.view addSubview:btn2];
    btn2.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn2 setTitleColor:oneColor forState:UIControlStateSelected];
    [btn2 setTitle:@"分栏" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(btn2Click) forControlEvents:UIControlEventTouchUpInside];

    btn3 = [[UIButton alloc]initWithFrame:M_RECT(kScreenSize.width/3*2, 64, kScreenSize.width/3, 30)];
    [self.view addSubview:btn3];
    btn3.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn3 setTitleColor:oneColor forState:UIControlStateSelected];
    [btn3 setTitle:@"直播" forState:UIControlStateNormal];
    [btn3 addTarget:self action:@selector(btn3Click) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark - 代理方法-
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 3;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * cellID;
    if(indexPath.row == 0){
        cellID = @"FirstCollectionViewCell";
        FirstCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
        cell.oneDelegate = self;
        return cell;
    }else if (indexPath.row == 1){
        cellID = @"SecondCollectionViewCell";
        SecondCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
        cell.twoDelegate = self;
        return cell;
        
    }else{
        cellID = @"ThirdCollectionViewCell";
        ThirdCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
        cell.threeDelegate = self;
        return cell;
    }
}

//设置宽高、
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.view.frame.size.width, self.view.frame.size.height-108);
}


-(void)btn1Click{
    lineView.frame = M_RECT(0, 92, kScreenSize.width/3, 2);
    btn1.selected = YES;
    btn2.selected = NO;
    btn3.selected = NO;
    [self row:0];
}

-(void)btn2Click{
    lineView.frame = M_RECT(kScreenSize.width/3, 92, kScreenSize.width/3, 2);
    btn1.selected = NO;
    btn2.selected = YES;
    btn3.selected = NO;
    [self row:1];
    
}

-(void)btn3Click{
    lineView.frame = M_RECT(kScreenSize.width/3*2, 92, kScreenSize.width/3, 2);
    btn1.selected = NO;
    btn2.selected = NO;
    btn3.selected = YES;
    [self row:2];
}

#pragma mark - collection最外层cell 跟随btn 滚动 -

-(void)row:(NSInteger)integer
{
    [_baseCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:integer inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSLog(@"%@",NSStringFromCGPoint(scrollView.contentOffset));
    NSIndexPath * indexPath = [_baseCollectionView indexPathForItemAtPoint:CGPointMake(scrollView.contentOffset.x+0.5*kScreenSize.width, 0)];
    NSLog(@"%ld",indexPath.row);
    [self qew:indexPath.row];
}

-(void)qew:(NSInteger)integer
{
    switch (integer) {
        case 0:
            [self btn1Click];
            break;
        case 1:
            [self btn2Click];
            break;
        case 2:
            [self btn3Click];
            break;
            
        default:
            break;
    }
}


-(void)presnetPlayViewControllerWithRoomId:(NSString *)roomID andNum:(NSString *)number
{
    NSString * url = [NSString stringWithFormat:Roomurl,roomID];
    NSLog(@"%@",url);
    [GetData getWithURLString:url andCallBack:^(id data, NSError * error) {
        NSString * bofang = data[@"data"][@"hls_url"];
        VideoViewController * VC = [[VideoViewController alloc]init];
        VC.playStr = bofang;
        [self presentViewController:VC animated:NO completion:^{
        }];
    }];
}


-(void)pushOneStyleViewControlWithGame_Id:(NSString *)gameId andTypeStr:(NSString *)typeStr
{
    OneStyleViewController * vc = [[OneStyleViewController alloc]init];
    vc.url = gameId;
    vc.typeStr = typeStr;
    [self.navigationController pushViewController:vc animated:NO];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
