//
//  DMLoopingViewCell4.m
//  DMLoopingViewDemo
//
//  Created by yangdeming on 2020/6/2.
//  Copyright © 2020 yangdeming. All rights reserved.
//

#import "DMLoopingViewCell4.h"
#import "Masonry.h"
#import "DMLoopingCellModel.h"

@interface DMLoopingViewCell4 ()

@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) DMLoopingCellModel *model;

@end

@implementation DMLoopingViewCell4

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self setUpSubviews];
        [self addLayout];
    }
    return self;
}

- (void)setUpSubviews {
    [self.contenView addSubview:({
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.numberOfLines = 0;
        _contentLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightRegular];
        _contentLabel.textColor = [UIColor blackColor];
        _contentLabel.backgroundColor = [UIColor clearColor];
        _contentLabel;
    })];
}

- (void)addLayout {
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self.contenView);
        make.left.mas_equalTo(70.f);
        make.right.mas_equalTo(-20.f);
    }];
}

- (void)refreshWithModel:(DMLoopingCellModel *)model {
    self.model = model;
    self.contentLabel.text = model.title;
    self.contenView.backgroundColor = model.backgroundColor;
}


- (CGFloat)getCellWidth {
    return self.model.cellWidth;
}

@end
