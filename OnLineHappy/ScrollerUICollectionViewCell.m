//
//  ScrollerUICollectionViewCell.m
//  OnLineHappy
//
//  Created by Lc、 on 15/10/22.
//  Copyright © 2015年 Lc、. All rights reserved.
//

#import "ScrollerUICollectionViewCell.h"
#import "UIImageView+WebCache.h"
@implementation ScrollerUICollectionViewCell

- (void)awakeFromNib {
    
//    for(int i = 0 ; i < _scrollerImgVArr.count;i++){
//        UIImageView * imgV = [[UIImageView alloc]initWithFrame:M_RECT(self.frame.size.width*i, 0, self.frame.size.width, self.frame.size.width/2)];
//        [_scrollerView addSubview:imgV];
//        [imgV sd_setImageWithURL:[NSURL URLWithString:_scrollerImgVArr[i][@"pic_url"]] placeholderImage:[UIImage imageNamed:@"HDAddPhoto.png"]];
//        
//        UIView * view = [[UIView alloc]initWithFrame:M_RECT(0, imgV.frame.size.height-30, self.scrollerView.frame.size.width, 30)];
//        [imgV addSubview:view];
//        view.backgroundColor = [UIColor blackColor];
//        view.alpha = 0.4;
//        UILabel * label = [[UILabel alloc]initWithFrame:M_RECT(10, imgV.frame.size.height-30, self.scrollerView.frame.size.width/3*2, 30)];
//        [imgV addSubview:label];
//        label.textColor = [UIColor whiteColor];
//        label.font = [UIFont systemFontOfSize:14];
//        label.text = _scrollerImgVArr[i][@"title"];
//    }
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGR:)];
    [self.scrollerView addGestureRecognizer:tapGR];
    
    
}


-(void)tapGR:(UITapGestureRecognizer *)tapGR
{
    if(self.scrollerView.contentOffset.x == 0){
        NSLog(@"1");
        [((FirstCollectionViewCell *)self.delegate).oneDelegate presnetPlayViewControllerWithRoomId:self.dataArr[0][@"room"][@"room_id"] andNum:self.dataArr[0][@"room"][@"online"]];
    }else if (self.scrollerView.contentOffset.x == self.scrollerView.frame.size.width){
        NSLog(@"2");
        [((FirstCollectionViewCell *)self.delegate).oneDelegate presnetPlayViewControllerWithRoomId:self.dataArr[1][@"room"][@"room_id"] andNum:self.dataArr[0][@"room"][@"online"]];
    }else if(self.scrollerView.contentOffset.x == self.scrollerView.frame.size.width*2){
        [((FirstCollectionViewCell *)self.delegate).oneDelegate presnetPlayViewControllerWithRoomId:self.dataArr[2][@"room"][@"room_id"] andNum:self.dataArr[0][@"room"][@"online"]];
    }else if (self.scrollerView.contentOffset.x == self.scrollerView.frame.size.width*3){
        [((FirstCollectionViewCell *)self.delegate).oneDelegate presnetPlayViewControllerWithRoomId:self.dataArr[3][@"room"][@"room_id"] andNum:self.dataArr[0][@"room"][@"online"]];
    }else if (self.scrollerView.contentOffset.x == self.scrollerView.frame.size.width*4){
        [((FirstCollectionViewCell *)self.delegate).oneDelegate presnetPlayViewControllerWithRoomId:self.dataArr[4][@"room"][@"room_id"] andNum:self.dataArr[0][@"room"][@"online"]];
    }else if (self.scrollerView.contentOffset.x == self.scrollerView.frame.size.width*5){
        [((FirstCollectionViewCell *)self.delegate).oneDelegate presnetPlayViewControllerWithRoomId:self.dataArr[5][@"room"][@"room_id"] andNum:self.dataArr[0][@"room"][@"online"]];
    }
 
}


@end
