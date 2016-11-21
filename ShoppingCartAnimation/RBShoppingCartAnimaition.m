//
//  RBShoppingCartAnimaition.m
//  Rainbow
//
//  Created by PC-LiuChunhui on 2016/10/19.
//  Copyright © 2016年 GreatGate. All rights reserved.
//

#import "RBShoppingCartAnimaition.h"

#define kShoppingCartDuration 1.0

@interface RBShoppingCartAnimaition()<CAAnimationDelegate> {
    CATextLayer *_animationLayer;
    AnimationFinisnedBlock _animationFinishedHolder;
}
@end
@implementation RBShoppingCartAnimaition

+(instancetype)shareTool
{
    return [[RBShoppingCartAnimaition alloc] init];
}


- (void)startAnimationandView:(UIView *)animationView endView:(UIView *)endView finishBlock:(AnimationFinisnedBlock)completion {
    
    _animationFinishedHolder = completion;
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;//获得keyWindow

    //找到开始位置
    CGPoint fromCenter =  [animationView convertPoint:CGPointMake(animationView.frame.size.width * 0.5f, animationView.frame.size.height * 0.5f) toView:keyWindow];
    //找到结束位置
    CGPoint endCenter = [endView convertPoint:CGPointMake(endView.frame.size.width * 0.5f, endView.frame.size.height * 0.5f) toView:keyWindow];
    
    //计算抛物线---贝赛尔曲线的两个控制点
    CGFloat controlPointEY = 100;
    CGFloat controlPointEX = (endCenter.x - fromCenter.x) * 0.25f;
    CGFloat controlPointX = (fromCenter.x + endCenter.x) * 0.5f;
    CGFloat controlPointY = fromCenter.y < endCenter.y ? fromCenter.y : endCenter.y;
    CGPoint controlPoint1 = CGPointMake(controlPointX - controlPointEX, controlPointY - controlPointEY);
    CGPoint controlPoint2 = CGPointMake(controlPointX + controlPointEX, controlPointY - controlPointEY);
    
    
    NSString *str = ((UIButton *)animationView).titleLabel.text;
    _animationLayer = [CATextLayer layer];
    _animationLayer.bounds = animationView.bounds;
    _animationLayer.position = fromCenter;
    _animationLayer.alignmentMode = kCAAlignmentCenter;//文字对齐方式
    _animationLayer.wrapped = YES;
    _animationLayer.contentsScale = [UIScreen mainScreen].scale;
    _animationLayer.string = str;
    _animationLayer.backgroundColor = [UIColor redColor].CGColor;
    [keyWindow.layer addSublayer:_animationLayer];
    
    // 路径
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:fromCenter];
    [path addCurveToPoint:endCenter controlPoint1:controlPoint1 controlPoint2:controlPoint2];
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.path = path.CGPath;
    //旋转
    CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotateAnimation.removedOnCompletion = YES;
    rotateAnimation.fromValue = [NSNumber numberWithFloat:0];
    rotateAnimation.toValue = [NSNumber numberWithFloat:10 * M_PI];
    rotateAnimation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    //缩放
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.removedOnCompletion = NO;
    scaleAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    scaleAnimation.toValue = [NSNumber numberWithFloat:0.2];
    
    //透明度
    CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    alphaAnimation.removedOnCompletion = NO;
    alphaAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    alphaAnimation.toValue = [NSNumber numberWithFloat:0.1];
    
    //动画组
    CAAnimationGroup *groups = [CAAnimationGroup animation];
    groups.animations = @[pathAnimation,rotateAnimation, scaleAnimation, alphaAnimation];
    groups.duration = kShoppingCartDuration;
    groups.removedOnCompletion=NO;
    groups.fillMode=kCAFillModeForwards;
    groups.delegate = self;
    [_animationLayer addAnimation:groups forKey:@"group"];
}
- (void)animationDidStart:(CAAnimation *)anim {
    
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
    if (flag) {//结束动画，移除layer
        [_animationLayer removeFromSuperlayer];
        _animationFinishedHolder(YES);
    }
}
@end
