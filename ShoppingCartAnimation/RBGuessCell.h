//
//  RBGuessCell.h
//  Rainbow
//
//  Created by PC-LiuChunhui on 16/8/3.
//  Copyright © 2016年 GreatGate. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RBGuessMatchItem;

@protocol RBGuessCellDelegate <NSObject>

- (void)guessCellWithMatchItem:(RBGuessMatchItem *)matchItem button:(UIButton *)button buttonTag:(NSInteger)tag;

@end

@interface RBGuessCell : UITableViewCell

@property (nonatomic, strong)  RBGuessMatchItem *guessMatchItem;
@property (nonatomic, weak) id<RBGuessCellDelegate> delegate;
+ (RBGuessCell *)cellWithTableView:(UITableView *)tableview;

@end
