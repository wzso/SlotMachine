//
//  SlotMachineView.m
//  SlotMachine
//
//  Created by Vincent on 5/24/17.
//  Copyright © 2017 zssr. All rights reserved.
//

#import "SlotMachineView.h"
#import "ReelView.h"

@interface SlotMachineView ()
@property (nonatomic, strong) NSArray<ReelView *> *reels;
@end

@implementation SlotMachineView

- (instancetype)initWithFrame:(CGRect)frame initialSymbols:(NSArray<NSString *> *)initialSymbols finalSymbols:(NSArray<NSString *> *)finalSymbols {
    NSAssert(initialSymbols.count > 0 && finalSymbols.count > 0, @"Slot Machine: Invalid params!");
    self = [super initWithFrame:frame];
    if (self) {
        [self addReelsWithInitialSymbols:initialSymbols finalSymbols:finalSymbols];
    }
    return self;
}

- (void)fire {
    [self.reels.firstObject spin];
}

- (void)addReelsWithInitialSymbols:(NSArray<NSString *> *)initialSymbols finalSymbols:(NSArray<NSString *> *)finalSymbols {
    NSMutableArray<ReelView *> *reels = [NSMutableArray array];
    NSUInteger count = MIN(initialSymbols.count, finalSymbols.count);
    CGFloat w = CGRectGetWidth(self.frame) / count;
    CGFloat h = CGRectGetHeight(self.frame);
    NSArray *fillingSymbols = @[@"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2", @"1", @"0"];
    for (NSUInteger i = 0; i < count; i ++) {
        ReelView *reel = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ReelView class]) owner:nil options:nil].firstObject;
        reel.frame = CGRectMake(i * w, 0, w, h);
        reel.tag = 100 + i;
        reel.circlesLimit = 10;
        NSMutableArray *symbols = [NSMutableArray arrayWithArray:fillingSymbols];
        [symbols insertObject:initialSymbols[i] atIndex:0];
        [symbols addObject:finalSymbols[i]];
        reel.symbols = symbols;
        [self addSubview:reel];
        [reels addObject:reel];
    }
    self.reels = reels;
    [self chainReelsUp];
}

- (void)chainReelsUp {
    if (self.machineStopped) {
        __weak typeof(self) weakSelf = self;
        self.reels.lastObject.reelStopped = ^{
            weakSelf.machineStopped();
        };
    }
    
    for (int i = 0; i <= self.reels.count - 2; i ++) {
        ReelView *reel = self.reels[i];
        __weak typeof(self) weakSelf = self;
        reel.reelStopped = ^{
            [weakSelf.reels[i+1] spin];
        };
    }
}

@end
