//
//  DMLoopingViewModel.m
//  DMLoopingViewDemo
//
//  Created by yangdeming on 2020/6/1.
//  Copyright © 2020 yangdeming. All rights reserved.
//

#import "DMLoopingViewModel.h"
#import "DMLoopingCellModel.h"

#define RGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define RandomColor       RGBColor(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255))

@implementation DMLoopingViewModel

- (void)requestNetDataWithParam:(NSDictionary *)params finishBlock:(void(^)(NSArray<DMLoopingCellModel *> * dataList))finishBlock {
    
    //request service with params
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        DMLoopingCellModel *cellModel = [[DMLoopingCellModel alloc] init];
        cellModel.title = @"轮播文案1、轮播文案1、轮播文案1、轮播文案1";
        cellModel.backgroundColor = [RandomColor colorWithAlphaComponent:0.1];
        cellModel.cellWidth = textWidth(cellModel.title);
        cellModel.linkUrl = @"https://www.baidu.com";
        cellModel.iconName = @"dm_loop_icon";
        
        DMLoopingCellModel *cellModel2 = [[DMLoopingCellModel alloc] init];
        cellModel2.title = @"轮播文案2、轮播文案2、轮播文案2";
        cellModel2.backgroundColor = [RandomColor colorWithAlphaComponent:0.1];
        cellModel2.cellWidth = textWidth(cellModel2.title);
        cellModel2.iconName = @"dm_loop_icon";
        cellModel2.linkUrl = @"https://www.zhihu.com";
        
        DMLoopingCellModel *cellModel3 = [[DMLoopingCellModel alloc] init];
        cellModel3.title = @"轮播文案3、轮播文案3、轮播文案3、轮播文案3、轮播文案3";
        cellModel3.backgroundColor = [RandomColor colorWithAlphaComponent:0.1];
        cellModel3.cellWidth = textWidth(cellModel3.title);
        cellModel3.linkUrl = @"https://www.taobao.com";
        
        DMLoopingCellModel *cellModel4 = [[DMLoopingCellModel alloc] init];
        cellModel4.title = @"轮播文案4";
        cellModel4.backgroundColor = [RandomColor colorWithAlphaComponent:0.1];
        cellModel4.cellWidth = textWidth(cellModel4.title);
        cellModel4.linkUrl = @"https://www.baidu.com";
        
        DMLoopingCellModel *cellModel5 = [[DMLoopingCellModel alloc] init];
        cellModel5.title = @"轮播文案5、轮播文案5";
        cellModel5.backgroundColor = [RandomColor colorWithAlphaComponent:0.1];
        cellModel5.cellWidth = textWidth(cellModel5.title);
        cellModel5.iconName = @"dm_loop_icon";
        cellModel5.linkUrl = @"https://www.jd.com/";
        
        DMLoopingCellModel *cellModel6 = [[DMLoopingCellModel alloc] init];
        cellModel6.title = @"轮播文案6、轮播文案6、轮播文案6、轮播文案6";
        cellModel6.backgroundColor = [RandomColor colorWithAlphaComponent:0.1];
        cellModel6.cellWidth = textWidth(cellModel6.title);
        cellModel6.linkUrl = @"https://www.qq.com";
        
        DMLoopingCellModel *cellModel7 = [[DMLoopingCellModel alloc] init];
        cellModel7.title = @"轮播文案7、轮播文案7、轮播文案7、轮播文案7、轮播文案7、轮播文案7";
        cellModel7.backgroundColor = [RandomColor colorWithAlphaComponent:0.1];
        cellModel7.cellWidth = textWidth(cellModel7.title);
        cellModel7.iconName = @"dm_loop_icon";
        cellModel7.linkUrl = @"https://weixin.qq.com";
        
        NSMutableArray *tempArray = [NSMutableArray arrayWithObjects:cellModel, cellModel2, cellModel3, cellModel4, cellModel5, cellModel6, cellModel7, nil];
        !finishBlock ?: finishBlock(tempArray.copy);
    });
}

static inline CGFloat textWidth(NSString *title){
    return [title boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 80.f, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15.f weight:UIFontWeightRegular]} context:nil].size.width + 10;
}



@end
