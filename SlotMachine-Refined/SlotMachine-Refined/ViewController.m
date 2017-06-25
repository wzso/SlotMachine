//
//  ViewController.m
//  SlotMachine-Refined
//
//  Created by Vincent on 23/06/2017.
//  Copyright © 2017 zssr. All rights reserved.
//

#import "ViewController.h"
#import "SlotMachine.h"

@interface ViewController ()
@property (nonatomic, strong) SlotMachine *slotMachine;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    SlotMachine *slot = [[SlotMachine alloc] initWithFrame:CGRectMake(50, 150, 200, 80) numberOfReels:3 initialValue:55];
    slot.machineStopped = ^{
        NSLog(@"Machine stopped");
    };
    [self.view addSubview:slot];
    self.slotMachine = slot;
}

- (IBAction)fire {
    [self.slotMachine fire];
}

- (IBAction)stop {
    [self.slotMachine setFinalResult:5 * arc4random_uniform(150)];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.slotMachine beginAnnouncing];
    });
}

- (IBAction)reset {
    [self.slotMachine reset];
}


@end
