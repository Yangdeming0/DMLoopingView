//
//  DMMainController.m
//  DMLoopingView
//
//  Created by yangdeming on 2020/6/1.
//  Copyright © 2020 yangdeming. All rights reserved.
//

#import "DMMainController.h"
#import "Masonry.h"
#import "DMLoopingView.h"
#import "DMLoopingViewCell1.h"
#import "DMLoopingViewCell3.h"
#import "DMLoopingViewCell4.h"
#import "DMLoopingCellModel.h"
#import "DMLoopingViewModel.h"
#import "DMWebViewController.h"

@interface DMMainController () <DMLoopingViewDataSource, DMLoopingViewDelegate>

@property (nonatomic, strong) DMLoopingView *loopView1;
@property (nonatomic, strong) DMLoopingView *loopView2;
@property (nonatomic, strong) DMLoopingView *loopView3;
@property (nonatomic, strong) DMLoopingView *loopView4;

@property (nonatomic, strong) NSArray<DMLoopingCellModel *> *dataList;
@property (nonatomic, strong) DMLoopingViewModel *viewModel;
@end

@implementation DMMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpSubviews];
    [self addLayout];
    [self fetchData];
}

- (void)setUpSubviews {
    
    self.title = @"DMLoopingView";
    self.view.backgroundColor = [[UIColor colorWithRed:(217)/255.0 green:(214)/255.0 blue:(204)/255.0 alpha:1] colorWithAlphaComponent:0.2];
    
    [self.view addSubview:self.loopView1];
    [self.view addSubview:self.loopView2];
    [self.view addSubview:self.loopView3];
    [self.view addSubview:self.loopView4];
}

- (void)addLayout {
    
    [self.loopView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20.f);
        make.right.mas_equalTo(-20.f);
        make.top.mas_equalTo(140.f);
        make.height.mas_equalTo(50.f);
    }];
    
    [self.loopView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.mas_equalTo(self.loopView1);
        make.width.mas_equalTo(100.f);
        make.top.mas_equalTo(self.loopView1.mas_bottom).offset(50.f);
    }];
    
    [self.loopView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.mas_equalTo(self.loopView1);
        make.top.mas_equalTo(self.loopView2.mas_bottom).offset(50.f);
    }];
    
    [self.loopView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.mas_equalTo(self.loopView1);
        make.top.mas_equalTo(self.loopView3.mas_bottom).offset(50.f);
    }];
}

- (void)fetchData {
    /// 如果担心请求耗时，页面没有轮播数据，可以采用缓存更新的方式创建数据源，请求回来更新数据源
    /// 或者默认给dataList固定本地文案 例如：安全中心 只有一条数据源时，reloadData是不会创建轮播timer的
    __weak typeof(self) weakSelf = self;
    [self.viewModel requestNetDataWithParam:@{} finishBlock:^(NSArray<DMLoopingCellModel *> * _Nonnull dataList) {
        weakSelf.dataList = dataList;
        [weakSelf.loopView1 reloadDataAndLooping];
        [weakSelf.loopView2 reloadDataAndLooping];
        [weakSelf.loopView3 reloadDataAndLooping];
        [weakSelf.loopView4 reloadDataAndLooping];
    }];
}

#pragma mark -- DMLoopingViewDataSource/Delegate --

- (NSInteger)numberOfItemsInLoopingView:(DMLoopingView *)loopingView {
    return self.dataList.count;
}

- (NSTimeInterval)timeIntervalForloopingView:(DMLoopingView *)loopingView {
    return 2;
}

- (NSTimeInterval)timeAnimationExecuteForloopingView:(DMLoopingView *)loopingView {
    return 0.5;
}

- (DMLoopingViewCell *)loopingView:(DMLoopingView *)loopingView itemForRowAtIndex:(NSInteger)index {
    if (loopingView == self.loopView1 || loopingView == self.loopView2) {
        DMLoopingViewCell1 *testCell1 = [loopingView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([DMLoopingViewCell1 class])];
        DMLoopingCellModel *cellModel = [self.dataList objectAtIndex:index];
        [testCell1 refreshWithModel:cellModel];
        return testCell1;
    } else if (loopingView == self.loopView3) {
        DMLoopingViewCell3 *testCell3 = [loopingView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([DMLoopingViewCell3 class])];
        DMLoopingCellModel *cellModel = [self.dataList objectAtIndex:index];
        [testCell3 refreshWithModel:cellModel];
        return testCell3;
    } else if (loopingView == self.loopView4) {
        DMLoopingViewCell4 *testCell4 = [loopingView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([DMLoopingViewCell4 class])];
        DMLoopingCellModel *cellModel = [self.dataList objectAtIndex:index];
        [testCell4 refreshWithModel:cellModel];
        return testCell4;
    }

    else {
        return [DMLoopingViewCell1 new];
    }
}

- (void)loopingView:(DMLoopingView *)loopingView didSelectRowAtIndexPath:(NSInteger)index {
    DMLoopingCellModel *cellModel = [self.dataList objectAtIndex:index];
    DMWebViewController *webVC = [[DMWebViewController alloc] init];
    webVC.urlStr = cellModel.linkUrl;
    [self.navigationController pushViewController:webVC animated:YES];
}

#pragma mark -- Getter --

- (DMLoopingViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[DMLoopingViewModel alloc] init];
    }
    return _viewModel;
}

- (NSArray<DMLoopingCellModel *> *)dataList {
    if (!_dataList) {
        _dataList = [NSArray array];
    }
    return _dataList;
}

- (DMLoopingView *)loopView1 {
    if (!_loopView1) {
        _loopView1 = [[DMLoopingView alloc] init];
        _loopView1.backgroundColor = [[UIColor cyanColor] colorWithAlphaComponent:0.2];
        _loopView1.dataSource = self;
        _loopView1.delegate = self;
        [_loopView1 registerClass:[DMLoopingViewCell1 class] forCellReuseIdentifier:NSStringFromClass([DMLoopingViewCell1 class])];
    }
    return _loopView1;
}

- (DMLoopingView *)loopView2 {
    if (!_loopView2) {
        _loopView2 = [[DMLoopingView alloc] init];
        _loopView2.backgroundColor = [[UIColor yellowColor] colorWithAlphaComponent:0.2];
        _loopView2.dataSource = self;
        _loopView2.delegate = self;
        _loopView2.layer.cornerRadius = 25.f;
        _loopView2.layer.masksToBounds = YES;
        __weak typeof(self) weakSelf = self;
        _loopView2.timerBlock = ^(NSTimeInterval interval, CGFloat nextWidth) {
            [weakSelf.view layoutIfNeeded];
            [UIView animateWithDuration:interval delay:0 options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionCurveEaseInOut animations:^{
                [weakSelf.loopView2 mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.width.mas_equalTo(nextWidth + 40.f);
                }];
                [weakSelf.view layoutIfNeeded];
            } completion:nil];
        };
        [_loopView2 registerClass:[DMLoopingViewCell1 class] forCellReuseIdentifier:NSStringFromClass([DMLoopingViewCell1 class])];
    }
    return _loopView2;
}

- (DMLoopingView *)loopView3 {
    if (!_loopView3) {
        _loopView3 = [[DMLoopingView alloc] init];
        _loopView3.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.2];
        _loopView3.dataSource = self;
        _loopView3.delegate = self;
        [_loopView3 registerClass:[DMLoopingViewCell3 class] forCellReuseIdentifier:NSStringFromClass([DMLoopingViewCell3 class])];
    }
    return _loopView3;
}

- (DMLoopingView *)loopView4 {
    if (!_loopView4) {
        _loopView4 = [[DMLoopingView alloc] init];
        _loopView4.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.2];
        _loopView4.dataSource = self;
        _loopView4.delegate = self;
        [_loopView4 registerClass:[DMLoopingViewCell4 class] forCellReuseIdentifier:NSStringFromClass([DMLoopingViewCell4 class])];
        
        UIImageView *iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 5, 40, 40)];
        iconImage.layer.cornerRadius = 20.f;
        iconImage.layer.masksToBounds = YES;
        iconImage.image = [UIImage imageNamed:@"dm_loop_icon"];
        [_loopView4 addSubview:iconImage];
    }
    return _loopView4;
}

@end
