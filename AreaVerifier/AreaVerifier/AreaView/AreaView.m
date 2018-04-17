//
//  AreaView.m
//  AreaVerifier
//
//  Created by 장웅 on 2018. 4. 16..
//  Copyright © 2018년 장웅. All rights reserved.
//

#import "AreaView.h"
#import "AreaComponent.h"

@implementation AreaView
{
    NSArray       * _ptList;
    
    AreaComponent * _tl;
    AreaComponent * _tc;
    AreaComponent * _tr;
    AreaComponent * _bl;
    AreaComponent * _bc;
    AreaComponent * _br;
}


-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if(self)
    {
        [self batchFrame:frame];
    }
    
    return self;
}

-(void)batchFrame:(CGRect)frame
{
    CGFloat topW = frame.size.width  * 0.7;
    CGFloat topY = frame.size.height * 0.5;
    
    CGFloat botW = frame.size.width * 0.9;
    CGFloat botY = frame.size.height - frame.size.height * 0.1;
    
    //pt1 - TL
    _tl = [[AreaComponent alloc] initWithCenterPos:
                          CGPointMake(frame.size.width - topW, topY)
                                                             size:CGSizeMake(25, 25)];
    _tl.tInner = INNERTYPE_LEFT;
    _tl.tLine  = LINETYPE_CENTER;
    
    //pt2 - TC
    _tc = [[AreaComponent alloc] initWithCenterPos:
                          CGPointMake((frame.size.width)/2, topY)
                                                             size:CGSizeMake(30, 20)];
    _tc.tInner = INNERTYPE_CENTER;
    _tc.tLine  = LINETYPE_CENTER;
    
    //pt3 - TR
    _tr = [[AreaComponent alloc] initWithCenterPos:
                          CGPointMake(topW, topY)
                                                             size:CGSizeMake(25, 25)];
    _tr.tInner = INNERTYPE_RIGHT;
    _tr.tLine  = LINETYPE_CENTER;
    
    //pt4 - BL
    _bl = [[AreaComponent alloc] initWithCenterPos:
                          CGPointMake(frame.size.width - botW, botY)
                                                             size:CGSizeMake(25, 25)];
    _bl.tInner = INNERTYPE_LEFT;
    _bl.tLine  = LINETYPE_BOTTOM;
    
    //pt5 - BC
    _bc = [[AreaComponent alloc] initWithCenterPos:
                          CGPointMake(frame.size.width /2 , botY)
                                                             size:CGSizeMake(30, 20)];
    _bc.tInner = INNERTYPE_CENTER;
    _bc.tLine  = LINETYPE_BOTTOM;
    
    //pt6 - BR
    _br = [[AreaComponent alloc] initWithCenterPos:
                          CGPointMake(botW, botY)
                                                             size:CGSizeMake(25, 25)];
    _br.tInner = INNERTYPE_RIGHT;
    _br.tLine  = LINETYPE_BOTTOM;
    
    _ptList = [NSArray arrayWithObjects:_tl,_tc,_tr,_bl,_bc,_br, nil];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    UIColor * normalStateColor = [UIColor colorWithRed:1.0 green:0 blue:0 alpha:0.3];
    UIColor * selStateColor    = [UIColor colorWithRed:0 green:0 blue:1.0 alpha:0.3];
    UIColor * lineColor        = [UIColor blackColor];
    CGFloat lineWidth          = 0.5f;
    
    
    CGContextSetLineWidth(ctx, lineWidth);
    
    for (AreaComponent * comp in _ptList)
    {
        CGContextSetStrokeColorWithColor(ctx, lineColor.CGColor);
        CGContextSetFillColorWithColor  (ctx, comp.select ? selStateColor.CGColor : normalStateColor.CGColor);
        
        if(comp.tInner == INNERTYPE_CENTER)
        {
            CGContextAddRect(ctx, comp.rect);
            CGContextFillRect(ctx, comp.rect);
            CGContextStrokeRect(ctx, comp.rect);
        }else
        {
            CGContextAddEllipseInRect(ctx, comp.rect);
            CGContextFillEllipseInRect(ctx, comp.rect);
            CGContextStrokeEllipseInRect(ctx, comp.rect);
        }
    }
    
    [self addLineContext:ctx
                    from:_tl
                      to:_tc
                   color:lineColor.CGColor
     ];
    
    [self addLineContext:ctx
                    from:_tr
                      to:_tc
                   color:lineColor.CGColor
     ];
    
    [self addLineContext:ctx
                    from:_bc
                      to:_tc
                   color:lineColor.CGColor
     ];
    
    [self addLineContext:ctx
                    from:_bl
                      to:_bc
                   color:lineColor.CGColor
     ];
    
    [self addLineContext:ctx
                    from:_br
                      to:_bc
                   color:lineColor.CGColor
     ];
    
    [self addLineContext:ctx
                    from:_bl
                      to:_tl
                   color:lineColor.CGColor
     ];
    
    [self addLineContext:ctx
                    from:_br
                      to:_tr
                   color:lineColor.CGColor
     ];
    
}

-(void)addLineContext:(CGContextRef)ctx from:(AreaComponent*)from to:(AreaComponent*)to color:(CGColorRef)color
{
    CGContextMoveToPoint(ctx, from.center.x, from.center.y);
    CGContextAddLineToPoint(ctx, to.center.x, to.center.y);
    
    if(from.tInner == to.tInner)
    {
        CGFloat lineDash[] = {2.0f,3.0f};
        CGContextSetLineDash(ctx, 4, lineDash, 2);
        
    }else
    {
        CGFloat lineDash[] = {1.0f};
        CGContextSetLineDash(ctx, 1, lineDash, 0);
    }
    
    CGContextSetStrokeColorWithColor(ctx, color);
    CGContextStrokePath(ctx);
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    for (UITouch* t in touches)
    {
        CGPoint tPos = [t locationInView:self];
        NSLog(@"touch Loc %@",NSStringFromCGPoint(tPos));
        
        
        for (AreaComponent * eachComp in _ptList)
        {
            if(CGRectContainsPoint(eachComp.rect, tPos))
            {
                eachComp.select = YES;
                
            }else
            {
                eachComp.select = NO;
            }
        }
        
    }
    
    [self setNeedsDisplay];
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    for (UITouch* t in touches)
    {
        CGPoint tPos = [t locationInView:self];
        NSLog(@"touch Loc %@",NSStringFromCGPoint(tPos));
        
        for (AreaComponent * eachComp in _ptList)
        {
            if(eachComp.select)
            {
                if(eachComp.tInner != INNERTYPE_CENTER)
                {
                    //Left Right일때
                    [eachComp moveX:tPos.x];
                    //같은 열에 있는 Center를 중간 값으로 움직인다.
                    [self AlignCenterLineType:eachComp.tLine];
                    
                }else
                {
                    //중간 녀석일때..
                    [eachComp moveCenter:tPos];
                    //같은 열에 있는 모든 녀석의 Y를 변경해준다.
                    [self moveY:tPos.y lineType:eachComp.tLine];
                }
            }
        }
    }
    
   [self setNeedsDisplay];
    
}
//Left OR Right의 같은 열에 있는 Center의 X값을 움직인다.
-(void)AlignCenterLineType:(LINETYPE)type
{
    __weak AreaComponent * pLeft = NULL;
    __weak AreaComponent * pRight = NULL;
    __weak AreaComponent * pTarget = NULL;
    
    //배열에 담은 좌표를 검사하여 좌측 좌표와 우측좌표를 담는다.
    for (AreaComponent * eachComp in _ptList)
    {
        if(eachComp.tLine == type && eachComp.tInner == INNERTYPE_LEFT)
        {
            pLeft = eachComp;
        }else
        if(eachComp.tLine == type && eachComp.tInner == INNERTYPE_RIGHT)
        {
            pRight = eachComp;
        }else
        if(eachComp.tLine == type && eachComp.tInner == INNERTYPE_CENTER)
        {
            pTarget = eachComp;
        }
    }
    
    //X의 가운데 값을 도출한다.
    
    if(pLeft && pRight && pTarget)
    {
        CGFloat posX = pLeft.center.x + (pRight.center.x - pLeft.center.x)/2;
        [pTarget moveX:posX];
    }
    
}

//Center와 같은 축에 있는 좌표의 Y값을 움직인다.
-(void)moveY:(CGFloat)yPos lineType:(LINETYPE)type
{
    for (AreaComponent * eachComp in _ptList)
    {
        if(eachComp.tInner != INNERTYPE_CENTER && eachComp.tLine == type)
        {
            [eachComp moveY:yPos];
        }
    }
}


-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    for (UITouch* t in touches)
    {
        CGPoint tPos = [t locationInView:self];
        NSLog(@"touch Loc %@",NSStringFromCGPoint(tPos));
        
        for (AreaComponent * eachComp in _ptList)
        {
            eachComp.select = NO;
        }
        
    }
    
   [self setNeedsDisplay];
}



@end
