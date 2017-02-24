//
//  RBGuessController.m
//  Rainbow
//
//  Created by Shelin on 16/7/18.
//  Copyright © 2016年 GreatGate. All rights reserved.
//

#import "RBGuessController.h"

#import "RBGuessCell.h"

#import "RBShoppingCartAnimaition.h"

#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width

@interface RBGuessController()<UITableViewDelegate, UITableViewDataSource, RBGuessCellDelegate>


@property (nonatomic, strong) UITableView *guessTableView;

@property (nonatomic, strong) UIImageView *betslipsView;



@end
@implementation RBGuessController

#pragma mark - life cyle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.view addSubview:self.betslipsView];
    [self.view bringSubviewToFront:self.betslipsView];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.guessTableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RBGuessCell *cell = [RBGuessCell cellWithTableView:tableView];
    cell.delegate = self;
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 158;
}
- (UITableView *)guessTableView {
    if (!_guessTableView) {
        _guessTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth, kScreenHeight)];
        _guessTableView.rowHeight = 156;
        _guessTableView.delegate = self;
        _guessTableView.dataSource = self;
    }
    return _guessTableView;
}
- (UIImageView *)betslipsView {
    if (!_betslipsView) {
        _betslipsView = [[UIImageView alloc] init];
        _betslipsView.frame = CGRectMake(kScreenWidth - 20 - 62, kScreenHeight - 62 - 5, 62, 62);
        _betslipsView.image = [UIImage imageNamed:@"button_touzhu"];
    }
    return _betslipsView;
}
#pragma mark - RBGuessCellDelegate
- (void)guessCellWithMatchItem:(RBGuessMatchItem *)matchItem button:(UIButton *)button buttonTag:(NSInteger)tag {
    
    switch (tag) {
        case 1:
        case 2:
        case 3:
        {
            
            
                [[RBShoppingCartAnimaition shareTool] startAnimationandView:button endView:self.betslipsView finishBlock:^(BOOL isFinished) {
                    if (isFinished) {
                        //do something finished
                    }
                }];
            break;
        }        default:
            break;
    }
}
@end
