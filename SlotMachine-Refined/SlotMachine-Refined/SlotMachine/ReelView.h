//
//  ReelView.h
//  SlotMachine-Refined
//
//  Created by Vincent on 23/06/2017.
//  Copyright © 2017 zssr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReelView : UIView
/// default is 0.2
@property (nonatomic) CFTimeInterval animationDuration;
@property (nonatomic, copy) void(^reelStopped)();
/// designated initializer
- (instancetype)initWithFrame:(CGRect)frame symbols:(NSArray<NSString *> *)symbols initialIndex:(NSUInteger)index;
- (void)spin;
- (void)setFinal:(NSInteger)index;
- (void)stop;
- (void)reset;
@end
