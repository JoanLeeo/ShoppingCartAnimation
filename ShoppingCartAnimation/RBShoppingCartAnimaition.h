//
//  RBShoppingCartAnimaition.h
//  Rainbow
//
//  Created by PC-LiuChunhui on 2016/10/19.
//  Copyright © 2016年 GreatGate. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^AnimationFinisnedBlock)(BOOL isFinished);
@interface RBShoppingCartAnimaition : NSObject


+(instancetype)shareTool;

- (void)startAnimationandView:(UIView *)animationView endView:(UIView *)endView finishBlock:(AnimationFinisnedBlock)completion;

@end
