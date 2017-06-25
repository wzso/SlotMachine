//
//  SlotMachine.m
//  SlotMachine-Refined
//
//  Created by Vincent on 23/06/2017.
//  Copyright © 2017 zssr. All rights reserved.
//

#import "SlotMachine.h"
#import "ReelView.h"

@interface SlotMachine ()
@property (nonatomic, strong) NSArray<ReelView *> *reels;
@property (nonatomic, getter=isAnimating) BOOL animating;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation SlotMachine

- (instancetype)initWithFrame:(CGRect)frame numberOfReels:(NSUInteger)count initialValue:(NSUInteger)value {
    NSString *v = [NSString stringWithFormat:@"%zd", value];
    NSAssert(v.length <= count, @"invalid parameters: `value` can't be presented with `count` number of reels");
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = NO;
        [self addReelsCount:count initialValue:value];
    }
    return self;
}

- (void)fire {
    if (self.isAnimating) return;
    
    self.animating = YES;
    [self chainReelsUp];
    for (ReelView *reel in self.reels) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * arc4random_uniform(5) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [reel spin];
        });
    }
}

- (void)setFinalResult:(NSUInteger)result {
    NSArray<NSString *> *finalSymbols = [self symbolsForNumber:result withNumberOfDigits:self.reels.count];
    for (NSUInteger i = 0; i < finalSymbols.count; i ++) {
        [self.reels[i] setFinal:finalSymbols[i].integerValue];
    }
}

- (void)beginAnnouncing {
    [self.reels.lastObject stop];
}

/// stop reels if reels spinning then reset reels to inital state.
- (void)reset {
    for (ReelView *reel in self.reels) {
        reel.reelStopped = nil;
        [reel reset];
    }
    [self chainReelsUp];
}

#pragma mark - Helpers
- (void)addReelsCount:(NSUInteger)count initialValue:(NSUInteger)value {
    NSMutableArray<ReelView *> *reels = [NSMutableArray array];
    CGFloat space = 5.f;
    CGFloat w = (CGRectGetWidth(self.frame) - space * (count - 1)) / count;
    CGFloat h = CGRectGetHeight(self.frame);
    NSArray<NSString *> *initialSymbols = [self symbolsForNumber:value withNumberOfDigits:count];
    NSArray<NSString *> *symbols = [@"0 1 2 3 4 5 6 7 8 9" componentsSeparatedByString:@" "];
    for (NSUInteger i = 0; i < count; i ++) {
        ReelView *reel = [[ReelView alloc] initWithFrame:CGRectMake(i * (w  + space), 0, w, h) symbols:symbols initialIndex:initialSymbols[i].integerValue];
        reel.backgroundColor = [UIColor greenColor];
        reel.layer.cornerRadius = 5.f;
        reel.layer.masksToBounds = YES;
        [self addSubview:reel];
        [reels addObject:reel];
    }
    self.reels = reels;
}

// `idx` is 0 for the most left digit.
- (NSArray<NSString *> *)symbolsForNumber:(NSUInteger)num withNumberOfDigits:(NSUInteger)count {
    NSString *numString = [NSString stringWithFormat:@"%zd", num];
    NSMutableArray *symbols = [NSMutableArray array];
    for (NSUInteger i = 0; i < numString.length; i ++) {
        NSString *symbol = [numString substringWithRange:NSMakeRange(i, 1)];
        [symbols addObject:symbol];
    }
    NSUInteger numberOfZero = count - symbols.count;
    for (NSUInteger i = 0; i < numberOfZero; i ++) {
        [symbols insertObject:@"0" atIndex:0];
    }
    return symbols;
}

- (void)chainReelsUp {
    if (self.machineStopped) {
        __weak typeof(self) weakSelf = self;
        self.reels.firstObject.reelStopped = ^{
            weakSelf.animating = NO;
            weakSelf.machineStopped();
        };
    }
    
    NSUInteger count = self.reels.count;
    for (NSInteger i = count - 1; i > 0; i --) {
        ReelView *reel = self.reels[i];
        __weak typeof(self) weakSelf = self;
        reel.reelStopped = ^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf.reels[i - 1] stop];
            });
        };
    }
}

@end
