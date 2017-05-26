//
//  ReelView.h
//  SlotMachine
//
//  Created by Vincent on 5/24/17.
//  Copyright © 2017 zssr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReelView : UIView

/// @[S0, S1, ... , Sn-2, Sn-1]. Among these `n` symbols, `S0` is the initial visible one on the reel, `Sn-1` is the final result.
@property (nonatomic, strong) NSArray<NSString *> *symbols;
/// how many circles a reel spins before it stops. default is 30.
@property (nonatomic) NSUInteger circlesLimit;
@property (nonatomic, copy) void (^reelStopped)();
/// asign `symbols` before you can play.
- (void)spin;

- (void)stop;

@end
