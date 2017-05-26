//
//  ReelView.m
//  SlotMachine
//
//  Created by Vincent on 5/24/17.
//  Copyright © 2017 zssr. All rights reserved.
//

#import "ReelView.h"
#import "SymbolCell.h"

@interface ReelView () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) BOOL shouldStop;
@property (nonatomic) NSUInteger circles;
@end

@implementation ReelView

static NSString *reuseID = @"SymbolCell";

- (void)spin {
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.symbols.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
}

- (void)stop {
    self.shouldStop = YES;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.circlesLimit = 20;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SymbolCell class]) bundle:nil] forCellReuseIdentifier:reuseID];
}

- (void)setFrame:(CGRect)frame {
    super.frame = frame;
    self.tableView.rowHeight = CGRectGetHeight(frame);
}

- (BOOL)shouldStop {
    return _shouldStop || self.circles >= self.circlesLimit;
}

- (void)setSymbols:(NSArray<NSString *> *)symbols {
    _symbols = symbols;
    [self.tableView reloadData];
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
}

#pragma mark - Delegate Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.symbols.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SymbolCell *cell = [self.tableView dequeueReusableCellWithIdentifier:reuseID forIndexPath:indexPath];
    cell.symbolLabel.text = self.symbols[indexPath.row];
    return cell;
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    self.circles ++;
    if (self.shouldStop) {
        if (self.reelStopped) {
            self.reelStopped();
        }
    } else {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
        [self spin];
    }
}

@end
