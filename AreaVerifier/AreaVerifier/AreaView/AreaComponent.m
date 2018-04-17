//
//  AreaComponent.m
//  AreaVerifier
//
//  Created by 장웅 on 2018. 4. 16..
//  Copyright © 2018년 장웅. All rights reserved.
//

#import "AreaComponent.h"

@implementation AreaComponent
-(id)initWithCenterPos:(CGPoint)pos size:(CGSize)size
{
    self = [super init];
    
    if(self)
    {
        _center = pos;
        _size   = size;
        
        _rect = CGRectMake(
                           pos.x - size.width / 2,
                           pos.y - size.height / 2,
                           size.width,
                           size.height
                           );
        
        NSLog(@"Comp Created , %@", NSStringFromCGRect(_rect));
    }
    
    return self;
}

-(void)moveCenter:(CGPoint)center
{
    _center = center;
    _rect = CGRectMake(
                       center.x - _rect.size.width / 2,
                       center.y - _rect.size.height / 2,
                       _rect.size.width,
                       _rect.size.height
                       );
}

-(void)moveX:(CGFloat)xPos
{
    CGPoint newCenter = CGPointMake(xPos, _center.y);
    [self moveCenter:newCenter];
}

-(void)moveY:(CGFloat)yPos
{
    CGPoint newCenter = CGPointMake(_center.x, yPos);
    [self moveCenter:newCenter];
}

@end
