//
//  SymbolCell.m
//  SlotMachine
//
//  Created by Vincent on 5/24/17.
//  Copyright © 2017 zssr. All rights reserved.
//

#import "SymbolCell.h"


@interface SymbolCell ()

@end

@implementation SymbolCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.f green:arc4random_uniform(255)/255.f blue:arc4random_uniform(255)/255.f alpha:1.f];
}

@end
