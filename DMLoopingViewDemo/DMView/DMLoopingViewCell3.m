//
//  DMLoopingViewCell3.m
//  DMLoopingViewDemo
//
//  Created by yangdeming on 2020/6/2.
//  Copyright © 2020 yangdeming. All rights reserved.
//

#import "DMLoopingViewCell3.h"
#import "Masonry.h"
#import "DMLoopingCellModel.h"

@interface DMLoopingViewCell3 ()

@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIImageView *iconImage;
@property (nonatomic, strong) DMLoopingCellModel *model;

@end

@implementation DMLoopingViewCell3

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
    [self.contenView addSubview:({
        _iconImage = [[UIImageView alloc] init];
        _iconImage.userInteractionEnabled = YES;
        _iconImage.layer.cornerRadius = 20.f;
        _iconImage.layer.masksToBounds = YES;
        _iconImage;
    })];
}

- (void)addLayout {
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self.contenView);
        make.left.mas_equalTo(20.f);
        make.right.mas_equalTo(-20.f);
    }];
    
    [self.iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contenView);
        make.left.width.height.mas_equalTo(0.f);
    }];
}

- (void)refreshWithModel:(DMLoopingCellModel *)model {
    self.model = model;
    self.contentLabel.text = model.title;
    self.contenView.backgroundColor = model.backgroundColor;
    
    if ([model.iconName isKindOfClass:[NSString class]] && model.iconName.length) {
        
        self.iconImage.image = [UIImage imageNamed:model.iconName];
        [self.iconImage mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20.f);
            make.width.height.mas_equalTo(40.f);
        }];
        [self.contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(70.f);
        }];
        
    } else {
        
        [self.iconImage mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0.f);
            make.width.height.mas_equalTo(0.f);
        }];
        [self.contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20.f);
        }];
    }
}

- (CGFloat)getCellWidth {
    return self.model.cellWidth;
}

@end
