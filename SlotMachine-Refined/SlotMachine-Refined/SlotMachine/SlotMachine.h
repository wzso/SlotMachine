//
//  SlotMachine.h
//  SlotMachine-Refined
//
//  Created by Vincent on 23/06/2017.
//  Copyright © 2017 zssr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SlotMachine : UIView
@property (nonatomic, copy) void(^machineStopped)();
@property (nonatomic, getter=isAnimating, readonly) BOOL animating;
- (instancetype)initWithFrame:(CGRect)frame numberOfReels:(NSUInteger)count initialValue:(NSUInteger)value;
- (void)fire;
- (void)setFinalResult:(NSUInteger)result;
- (void)beginAnnouncing;
/// stop reels if reels spinning then reset reels to inital state.
- (void)reset;
@end
