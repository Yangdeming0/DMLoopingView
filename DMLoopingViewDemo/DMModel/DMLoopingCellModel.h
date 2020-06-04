//
//  DMLoopingCellModel.h
//  DMLoopingViewDemo
//
//  Created by yangdeming on 2020/6/1.
//  Copyright © 2020 yangdeming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DMLoopingCellModel : NSObject

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *subTitle;

@property (nonatomic, copy) NSString *imageUrl;

@property (nonatomic, copy) NSString *iconName;

@property (nonatomic, copy) NSString *linkUrl;

// cell宽度/高度 可以放在这里计算
@property (nonatomic, assign) CGFloat cellWidth;
@property (nonatomic, assign) CGFloat cellHeight;

@property (nonatomic, strong) UIColor *backgroundColor;

@end

NS_ASSUME_NONNULL_END
