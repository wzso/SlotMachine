//
//  ViewController.m
//  SlotMachine
//
//  Created by Vincent on 5/24/17.
//  Copyright © 2017 zssr. All rights reserved.
//

#import "ViewController.h"
#import "SlotMachineView.h"

@interface ViewController ()
@property (nonatomic, strong) SlotMachineView *slotMachine;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    SlotMachineView *slotMachine = [[SlotMachineView alloc] initWithFrame:CGRectMake(50, 200, 300, 80) initialSymbols:[@"8 8 8 8 8" componentsSeparatedByString:@" "] finalSymbols:[@"0 1 2 6 3" componentsSeparatedByString:@" "]];
    [self.view addSubview:slotMachine];
    slotMachine.machineStopped = ^{
        NSLog(@"Congrats!!");
    };
    self.slotMachine = slotMachine;
}

- (IBAction)play:(UIButton *)sender {
    [self.slotMachine fire];
}


@end
