//
//  ReelView.m
//  SlotMachine-Refined
//
//  Created by Vincent on 23/06/2017.
//  Copyright © 2017 zssr. All rights reserved.
//

#import "ReelView.h"

@interface ReelView () <CAAnimationDelegate>
@property (nonatomic, strong) UILabel *label;
@property (nonatomic) NSUInteger index;
@property (nonatomic, strong) NSArray<NSString *> *symbols;
@property (nonatomic) NSUInteger initialIndex;
/// initial value is invalid(-1). changed in `stopAt:` when scheduled to stop.
@property (nonatomic) NSInteger finalIndex;
@property (nonatomic) BOOL shouldStop;
@end

@implementation ReelView

- (instancetype)initWithFrame:(CGRect)frame symbols:(NSArray<NSString *> *)symbols initialIndex:(NSUInteger)index {
    NSAssert(index < symbols.count, @"initWithFrame: `index` beyond `symbols`");
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        self.index = index;
        self.initialIndex = index;
        self.symbols = symbols;
        self.animationDuration = 0.15;
        self.finalIndex = -1;
        [self addLabel];
    }
    return self;
}

- (void)spin {
    [self setIndex:self.initialIndex + 1 animated:YES];
}

- (void)stop {
    self.shouldStop = YES;
}

- (void)setFinal:(NSInteger)index {
    NSAssert(index < self.symbols.count, @"`index` beyond `symbols`");
    self.finalIndex = index;
}

- (void)reset {
    self.finalIndex = -1;
    self.shouldStop = NO;
    [self setIndex:self.initialIndex animated:NO];
}

#pragma mark - Setters
- (void)setAnimationDuration:(CFTimeInterval)animationDuration {
    if (animationDuration > 0) {
        _animationDuration = animationDuration;
    }
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self setNeedsLayout];
}

#pragma mark - Helpers
- (void)addLabel {
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont boldSystemFontOfSize:40.f];
    label.textAlignment = NSTextAlignmentCenter;
    label.adjustsFontSizeToFitWidth = YES;
    label.text = self.symbols[self.index];
    [self addSubview:label];
    self.label = label;
    [self setNeedsLayout];
}

- (void)setIndex:(NSUInteger)index animated:(BOOL)animated {
    if (animated) {
        CATransition *trans = [[CATransition alloc] init];
        trans.type = kCATransitionPush;
        trans.subtype = kCATransitionFromTop;
        trans.duration = self.animationDuration;
        trans.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        trans.delegate = self;
        [self.label.layer addAnimation:trans forKey:kCATransitionPush];
    }
    self.index = index % self.symbols.count;
    self.label.text = self.symbols[self.index];
}

- (void)layoutSubviews {
    self.label.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
}

#pragma mark - Delegate Methods
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (self.shouldStop && self.index == self.finalIndex) {
        if (self.reelStopped) {
            self.reelStopped();
        }
    } else {
        [self setIndex:self.index + 1 animated:YES];
    }
}

@end
