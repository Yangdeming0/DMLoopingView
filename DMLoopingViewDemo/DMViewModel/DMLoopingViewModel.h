//
//  DMLoopingViewModel.h
//  DMLoopingViewDemo
//
//  Created by yangdeming on 2020/6/1.
//  Copyright © 2020 yangdeming. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DMLoopingCellModel;
NS_ASSUME_NONNULL_BEGIN

@interface DMLoopingViewModel : NSObject

/**
 获取数据

 @param  params              参数
 @param  finishBlock   成功回调
*/
- (void)requestNetDataWithParam:(NSDictionary *)params finishBlock:(void(^)(NSArray<DMLoopingCellModel *> * dataList))finishBlock;

@end

NS_ASSUME_NONNULL_END
