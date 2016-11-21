//
//  RBGuessCell.m
//  Rainbow
//
//  Created by PC-LiuChunhui on 16/8/3.
//  Copyright © 2016年 GreatGate. All rights reserved.
//

#import "RBGuessCell.h"
@interface RBGuessCell()

@property (weak, nonatomic) IBOutlet UILabel *leagueNameLb;

@property (weak, nonatomic) IBOutlet UILabel *homeTeamNameLb;
@property (weak, nonatomic) IBOutlet UIImageView *homeTeamLogoImg;

@property (weak, nonatomic) IBOutlet UILabel *matchTimeLb;

@property (weak, nonatomic) IBOutlet UIImageView *awayTeamLogoImg;
@property (weak, nonatomic) IBOutlet UILabel *awayTeamNameLb;


@property (weak, nonatomic) IBOutlet UIButton *homeTeamWinBtn;
@property (weak, nonatomic) IBOutlet UIButton *dogfallBtn;
@property (weak, nonatomic) IBOutlet UIButton *awayTeamBtn;

@property (weak, nonatomic) IBOutlet UIButton *morePlayBtn;

@property (weak, nonatomic) IBOutlet UIView *pkBgView;
@property (weak, nonatomic) IBOutlet UIImageView *pkImgView;
@property (weak, nonatomic) IBOutlet UILabel *pkLb;
@property (weak, nonatomic) IBOutlet UILabel *canPKLb;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pkBgViewCW;

@property (weak, nonatomic) UIButton *tmpBtn;

@end
@implementation RBGuessCell

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
//    [self.homeTeamWinBtn setTitle:@"主  胜\n1.88" forState:UIControlStateNormal];
//    [self.dogfallBtn setTitle:@"平  局\n1.88" forState:UIControlStateNormal];
//    [self.awayTeamBtn setTitle:@"客  胜\n1.88" forState:UIControlStateNormal];
//    [self.morePlayBtn setTitle:@"更多\n玩法" forState:UIControlStateNormal];
    
    
    UITapGestureRecognizer *pkTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pkTap:)];
    [self.pkBgView addGestureRecognizer:pkTap];
    
    //    [self.homeTeamWinBtn setTitleColor:kBlackColor forState:UIControlStateNormal];
    //    [self.homeTeamWinBtn setTitleColor:kWhiteColor forState:UIControlStateSelected];
    //    [self.dogfallBtn setTitleColor:kBlackColor forState:UIControlStateNormal];
    //    [self.dogfallBtn setTitleColor:kWhiteColor forState:UIControlStateSelected];
    //    [self.awayTeamBtn setTitleColor:kBlackColor forState:UIControlStateNormal];
    //    [self.awayTeamBtn setTitleColor:kWhiteColor forState:UIControlStateSelected];
    
    
}
+ (RBGuessCell *)cellWithTableView:(UITableView *)tableview {
    static NSString *identifier = @"RBGuessCell";
    RBGuessCell *cell = [tableview dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:identifier owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
- (IBAction)guessSelectionBtnAction:(UIButton *)sender {
    
    
    if ([_tmpBtn isEqual:sender]) {//同一个按钮
        if (sender.selected) {//选中 -> 取消
            sender.selected = NO;
        } else {//取消 -> 选中
            sender.selected = YES;
            
        }
    } else {//不同按钮
        _tmpBtn.selected = NO;
        sender.selected = YES;
    }
    _tmpBtn = sender;
    
    if ([self.delegate respondsToSelector:@selector(guessCellWithMatchItem:button:buttonTag:)]) {
        [self.delegate guessCellWithMatchItem:_guessMatchItem button:sender buttonTag:sender.tag];
    }
}


- (IBAction)analyzeBtnAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(guessCellWithMatchItem:button:buttonTag:)]) {
        [self.delegate guessCellWithMatchItem:_guessMatchItem button:sender buttonTag:sender.tag];
    }
    
}

- (IBAction)morePlayBtnAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(guessCellWithMatchItem:button:buttonTag:)]) {
        [self.delegate guessCellWithMatchItem:_guessMatchItem button:sender buttonTag:sender.tag];
    }
    
}
- (void)pkTap:(UITapGestureRecognizer *)pkTap {
    
    if ([self.delegate respondsToSelector:@selector(guessCellWithMatchItem:button:buttonTag:)]) {
        [self.delegate guessCellWithMatchItem:_guessMatchItem button:nil buttonTag:6];
    }
}

@end
