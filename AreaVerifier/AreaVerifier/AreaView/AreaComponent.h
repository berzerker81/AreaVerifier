//
//  AreaComponent.h
//  AreaVerifier
//
//  Created by 장웅 on 2018. 4. 16..
//  Copyright © 2018년 장웅. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef enum{
    INNERTYPE_UNKNOWN = 0,
    INNERTYPE_LEFT,
    INNERTYPE_CENTER,
    INNERTYPE_RIGHT
    
}INNERTYPE;


typedef enum {
    
    LINETYPE_UNKNOWN = 0,
    LINETYPE_CENTER,
    LINETYPE_BOTTOM
}LINETYPE;


@interface AreaComponent : NSObject
@property(nonatomic) INNERTYPE tInner;
@property(nonatomic) LINETYPE  tLine;
@property(readonly)  CGRect  rect;
@property(nonatomic) CGPoint center;
@property(nonatomic) CGSize  size;
@property(nonatomic) bool    select;
-(id)initWithCenterPos:(CGPoint)pos size:(CGSize)size;
-(void)moveCenter:(CGPoint)center;
-(void)moveX:(CGFloat)xPos;
-(void)moveY:(CGFloat)yPos;
@end

