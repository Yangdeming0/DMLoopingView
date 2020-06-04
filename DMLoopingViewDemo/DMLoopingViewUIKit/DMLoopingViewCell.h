//
//  DMLoopingViewCell.h
//  DMLoopingView
//
//  Created by yangdeming on 2020/6/1.
//  Copyright © 2020 yangdeming. All rights reserved.
//
//
//  ！！！！  ----  ！！！！
//  loopingCell 可以理解为抽象类，不建议直接实例化，可以继承并自定义cell 类似tableViewCell

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DMLoopingViewCell : UIView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier;

@property (nonatomic, readonly, strong) UIView *contenView;

@property (nonatomic, readonly, copy) NSString *reuseIdentifier;

- (CGFloat)getCellWidth;

@end

NS_ASSUME_NONNULL_END
