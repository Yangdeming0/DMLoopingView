//
//  DMLoopingViewCell.m
//  DMLoopingView
//
//  Created by yangdeming on 2020/6/1.
//  Copyright © 2020 yangdeming. All rights reserved.
//

#import "DMLoopingViewCell.h"
#import "Masonry.h"

@implementation DMLoopingViewCell

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super init]) {
        _reuseIdentifier = reuseIdentifier;
        [self setUpSubviewsSuper];
    }
    return self;
}

- (void)setUpSubviewsSuper {
    [self addSubview:({
        _contenView = [[UIView alloc] init];
        _contenView.backgroundColor = [UIColor whiteColor];
        _contenView;
    })];
    
    [self.contenView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
}

- (CGFloat)getCellWidth {
    return 0;
}

@end
