//
//  DMLoopingView.h
//  DMLoopingView
//
//  Created by yangdeming on 2020/6/1.
//  Copyright © 2020 yangdeming. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DMLoopingView, DMLoopingViewCell;
NS_ASSUME_NONNULL_BEGIN
@protocol DMLoopingViewDataSource <NSObject>

@required
/**
 返回 cell 数量

 @param  loopingView   self
 @return Integer                cell 数量
*/
- (NSInteger)numberOfItemsInLoopingView:(DMLoopingView *)loopingView;

/**
 返回 loopingViewCell

 @param  loopingView   self
 @param  index                cell的序列
 @return loopingViewcell  cell
*/
- (DMLoopingViewCell *)loopingView:(DMLoopingView *)loopingView itemForRowAtIndex:(NSInteger)index;

@optional
/**
 返回 loopingView 刷新间隔，如果不实现此方法 默认刷新间隔 4s

 @param  loopingView   self
 @return timeInterval         时间间隔
*/
- (NSTimeInterval)timeIntervalForloopingView:(DMLoopingView *)loopingView;

/**
 返回 loopingView 动画执行时间，如果不实现此方法 默认执行时间0.5s

 @param  loopingView   self
 @return timeInterval         执行时间
*/
- (NSTimeInterval)timeAnimationExecuteForloopingView:(DMLoopingView *)loopingView;

@end

@protocol DMLoopingViewDelegate <NSObject>

@optional
- (void)loopingView:(DMLoopingView *)loopingView didSelectRowAtIndexPath:(NSInteger)index;

@end

typedef void(^LoopingViewTimerBlock)(NSTimeInterval interval, CGFloat nextWidth);
@interface DMLoopingView : UIView

- (instancetype)init;
- (instancetype)initWithCoder:(NSCoder *)coder __attribute__((unavailable("Must use -init instead.")));
- (instancetype)initWithFrame:(CGRect)frame __attribute__((unavailable("Must use -init instead.")));

/**
 注册cell
 
 @param  cellClass      cell类
 @param  identifier    重用标识符
 */
- (void)registerClass:(nullable Class)cellClass forCellReuseIdentifier:(NSString *)identifier;

/**
 获取重用cell

 @param  identifier    重用标识符
 @return loopingViewCell
*/
- (__kindof DMLoopingViewCell *)dequeueReusableCellWithReuseIdentifier:(NSString *)identifier;
                                
/**
 刷新数据
*/
- (void)reloadDataAndLooping;

/**
 销毁loopingView 释放timer
*/
- (void)stop;

@property (nonatomic, weak) id<DMLoopingViewDataSource> dataSource;
@property (nonatomic, weak) id<DMLoopingViewDelegate> delegate;

/// 只有loopingView需要跟随每次刷新变化，或者外部需要捕捉定时器刷新时机时才需要实现这个block（可以扩展参数把当前index抛出来）
@property (nonatomic, copy) LoopingViewTimerBlock timerBlock;


@end

NS_ASSUME_NONNULL_END
