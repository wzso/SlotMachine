//
//  SlotMachineView.h
//  SlotMachine
//
//  Created by Vincent on 5/24/17.
//  Copyright © 2017 zssr. All rights reserved.
//

#import <UIKit/UIKit.h>

/// the number of reels making up the machine depends on the number of symbols given
@interface SlotMachineView : UIView
@property (nonatomic, copy) void(^machineStopped)();
/// when calculating the `frame`, you should do the math job to proportion the the reels well.
- (instancetype)initWithFrame:(CGRect)frame initialSymbols:(NSArray<NSString *> *)initialSymbols finalSymbols:(NSArray<NSString *> *)finalSymbols;
- (void)fire;
@end
