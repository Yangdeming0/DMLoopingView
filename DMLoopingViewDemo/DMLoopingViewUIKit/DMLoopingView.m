//
//  DMLoopingView.m
//  DMLoopingView
//
//  Created by yangdeming on 2020/6/1.
//  Copyright © 2020 yangdeming. All rights reserved.
//

#import "DMLoopingView.h"
#import "DMLoopingViewCell.h"
#import "Masonry.h"

@interface DMLoopingView () <UIGestureRecognizerDelegate>

@property (nonatomic, strong) NSTimer             *timer;         /// 定时器
@property (nonatomic, strong) DMLoopingViewCell   *currentCell;   /// 当前cell
@property (nonatomic, strong) DMLoopingViewCell   *nextCell;      /// 即将展示cell
@property (nonatomic, strong) NSMutableArray      *reuseCellPool; /// 重用池
@property (nonatomic, strong) NSMutableDictionary *cellClassDict; /// cell类名容器
@property (nonatomic, assign) NSInteger            currentIndex;  /// 当前展示cellIndex
@property (nonatomic, assign) NSTimeInterval       animationTime; /// 动画执行时间
@property (nonatomic, assign) BOOL                 isAnimating;   /// 是否正处于动画执行中

@end

#define selfHeight self.bounds.size.height
@implementation DMLoopingView

- (instancetype)init {
    
    if (self = [super init]) {
        self.clipsToBounds = YES;
        self.currentIndex = 0;
        [self addLoopingViewGesture];
    }
    return self;
}

#pragma mark -- Public Method --
// 注册cell
- (void)registerClass:(nullable Class)cellClass forCellReuseIdentifier:(NSString *)identifier {
    
    if ([identifier isKindOfClass:[NSString class]] && identifier.length) {
        [self.cellClassDict setObject:NSStringFromClass(cellClass) forKey:identifier];
    } else {
#if DEBUG
        NSAssert(NO, @"cell register fail");
#endif
    }
}

// 获取重用cell
- (__kindof DMLoopingViewCell *)dequeueReusableCellWithReuseIdentifier:(NSString *)identifier {
    
    if ([identifier isKindOfClass:[NSString class]] && identifier.length) {
        
        for (DMLoopingViewCell *cell in self.reuseCellPool) {
            if ([cell.reuseIdentifier isEqualToString:identifier]) {
                return cell;
            }
        }
            
        Class cellClass = NSClassFromString([self.cellClassDict valueForKey:identifier]);
#if DEBUG
        if (!cellClass) {
            NSAssert(NO, @"未实现注册cell方法");
        }
#endif
        DMLoopingViewCell *cell = [[cellClass alloc] initWithReuseIdentifier:identifier];
        return cell;
        
    } else { return nil;}
}

// 刷新 reloadData
- (void)reloadDataAndLooping {
    
    [self stop];
    
    if ([self.dataSource respondsToSelector:@selector(numberOfItemsInLoopingView:)]) {
        
        // 初始化动画执行时间
        self.animationTime = 0.5;
        if ([self.dataSource respondsToSelector:@selector(timeAnimationExecuteForloopingView:)]) {
            self.animationTime = [self.dataSource timeAnimationExecuteForloopingView:self];
        }
        
        // 初始化CellCount
        NSInteger itemCount = [self.dataSource numberOfItemsInLoopingView:self];
        if (itemCount <= 0) {
            // reloadLoopingView 至少要有一个cell
            return;
        } else if (itemCount > 1) {
            
            // 只有cell数>1时 才需要初始化轮播timer
            NSTimeInterval interval = 4;
            if ([self.dataSource respondsToSelector:@selector(timeIntervalForloopingView:)]) {
                interval = [self.dataSource timeIntervalForloopingView:self];
            }
            self.timer = [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
            NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
            [runLoop addTimer:self.timer forMode:NSRunLoopCommonModes];
        }
        
        // 只要cell数 >= 1 都需要刷新loopingView布局
        [self layoutLoopingView];
    }
}

#pragma mark -- Privite Method --

- (void)timerAction:(id)sender {

    if (self.isAnimating) return;

    [self layoutLoopingView];
    self.currentIndex ++;
    self.isAnimating = YES;
    [self layoutIfNeeded];
    
    [UIView animateWithDuration:self.animationTime delay:0
                        options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionCurveEaseInOut
                     animations:^{
        
        self.currentCell.alpha = 0.1;
        self.nextCell.alpha = 1.0;
        [self.currentCell mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self).offset(-selfHeight);
        }];
        [self.nextCell mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self);
        }];
        [self layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        
        if (self.currentCell && self.nextCell) {
            [self.reuseCellPool addObject:self.currentCell];
            [self.currentCell removeFromSuperview];
            self.currentCell = self.nextCell;
        }
        self.currentCell.alpha = 1.0;
        self.nextCell.alpha = 1.0;
        self.isAnimating = NO;
    }];
    
    !self.timerBlock ?: self.timerBlock(self.animationTime, [self.nextCell getCellWidth]);
}

- (void)addLoopingViewGesture {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleViewTapAction)];
    tap.delegate = self;
    [self addGestureRecognizer:tap];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isDescendantOfView:self]) {
        return YES;
    }
    return NO;
}

- (void)handleViewTapAction {
    if ([self.dataSource respondsToSelector:@selector(numberOfItemsInLoopingView:)]) {
        NSInteger index = (NSInteger)[self.dataSource numberOfItemsInLoopingView:self];
        if (self.currentIndex > index - 1) {
            self.currentIndex = 0;
        }
        if ([self.delegate respondsToSelector:@selector(loopingView:didSelectRowAtIndexPath:)]) {
            [self.delegate loopingView:self didSelectRowAtIndexPath:self.currentIndex];
        }
    }
}

- (void)layoutLoopingView {
    
    NSInteger itemCount = 0;
    if ([self.dataSource respondsToSelector:@selector(numberOfItemsInLoopingView:)]) {
        
         itemCount = [self.dataSource numberOfItemsInLoopingView:self];
        if (itemCount <= 0) return;
    }
    
    // 循环归0
    if (self.currentIndex > itemCount - 1) {
        self.currentIndex = 0;
    }
    
    NSInteger nextIndex = self.currentIndex + 1;
    if (nextIndex > itemCount - 1) {
        nextIndex = 0;
    }

    // 创建cell
    if ([self.dataSource respondsToSelector:@selector(loopingView:itemForRowAtIndex:)]) {
        
        // 只有第一次 创建currentCell 后续都是next赋值给currentCell
        if (!self.currentCell) {
            
            self.currentCell = [self.dataSource loopingView:self itemForRowAtIndex:self.currentIndex];
            [self addSubview:self.currentCell];
            [self.currentCell mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.left.right.height.mas_equalTo(self);
            }];
            !self.timerBlock ?: self.timerBlock(self.animationTime, [self.currentCell getCellWidth]);
            return;
        }
        
        if (itemCount > 1) {
            
            // 即将展示nextCell
            self.nextCell = [self.dataSource loopingView:self itemForRowAtIndex:nextIndex];
            self.nextCell.alpha = 0.1;
            [self addSubview:self.nextCell];
            [self.nextCell mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self).offset(selfHeight);
                make.left.right.height.mas_equalTo(self);
            }];
        }
        
        // itemForRowAtIndex 已经从缓存池中取出cell 将取出cell从缓存池中移除
        [self.reuseCellPool removeObject:self.nextCell];
        
    } else {
#if DEBUG
        NSAssert(NO, @"未实现创建cell数据源方法");
#endif
    }
}

- (void)stop {
   
    if (self.timer) {
        if ([self.timer isValid]) {
            [self.timer invalidate];
        }
        self.timer = nil;
    }
    self.isAnimating = NO;
    self.currentIndex = 0;
    [self.currentCell removeFromSuperview];
    [self.nextCell removeFromSuperview];
    self.currentCell = nil;
    self.nextCell = nil;
    [self.reuseCellPool removeAllObjects];
}

- (NSMutableArray *)reuseCellPool {
    if (!_reuseCellPool) {
        _reuseCellPool = [NSMutableArray array];
    }
    return _reuseCellPool;
}

- (NSMutableDictionary *)cellClassDict {
    if (!_cellClassDict) {
        _cellClassDict = [NSMutableDictionary dictionary];
    }
    return _cellClassDict;
}

@end
