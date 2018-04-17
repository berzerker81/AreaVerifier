//
//  AreaView.m
//  AreaVerifier
//
//  Created by 장웅 on 2018. 4. 16..
//  Copyright © 2018년 장웅. All rights reserved.
//

#import "AreaView.h"
#import "AreaComponent.h"

#define TYPE_1

@implementation AreaView
{
    NSArray       * _ptList;
    
    AreaComponent * _tl;
    AreaComponent * _tc;
    AreaComponent * _tr;
    AreaComponent * _bl;
    AreaComponent * _bc;
    AreaComponent * _br;
    
    CGSize          _coordi;
    
}

-(void)dealloc
{
    _ptList = nil;
    _tl     = nil;
    _tc     = nil;
    _tr     = nil;
    _bl     = nil;
    _bc     = nil;
    _br     = nil;
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
    

    
//    _lbM = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 10)];
//    [_lbM setText:@"1M"];
//    [_lbM setFont:[UIFont systemFontOfSize:10]];
//
//    [self addSubview:_lbM];
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
//            CGContextAddRect(ctx, comp.rect);
//            CGContextFillRect(ctx, comp.rect);
//            CGContextStrokeRect(ctx, comp.rect);
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
    
    
    //텍스트 표시
//    CGFloat txtY = _tc.center.y + (_bc.center.y - _tc.center.y) / 2;
//    CGFloat txtX = _tc.center.x + (_bc.center.x - _tc.center.x) / 2;
//    _lbM.center = CGPointMake(txtX, txtY);
    
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
#pragma mark - touch
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    for (UITouch* t in touches)
    {
        CGPoint tPos = [t locationInView:self];
        
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
        
        for (AreaComponent * eachComp in _ptList)
        {
            if(eachComp.select)
            {
                if(eachComp.tInner != INNERTYPE_CENTER)
                {
                    [eachComp moveCenter:tPos];
                    [self AlignCenterLineType:eachComp.tLine];
                }
            }
        }
    }
    
   [self setNeedsDisplay];
    
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    for (UITouch* t in touches)
    {
        
        for (AreaComponent * eachComp in _ptList)
        {
            eachComp.select = NO;
        }
        
    }
    
    [self setNeedsDisplay];
    
    if(self.delegate!=nil && [(id)self.delegate respondsToSelector:@selector(AreaViewStandardCoordinate)])
    {
        _coordi = [(id)self.delegate AreaViewStandardCoordinate];
    }
    
    //기준 좌표로 변환
    CGPoint (^transCoordi)(CGPoint) = ^(CGPoint pt)
    {
        CGSize sourSize = self.frame.size;
        
        CGFloat tX = pt.x / sourSize.width  * _coordi.width;
        CGFloat tY = pt.y / sourSize.height * _coordi.height;
        
        return CGPointMake(tX, tY);
    };
    
#define TR(x) transCoordi(x)
    
    
    
    
    if(self.delegate != nil && [(id)self.delegate respondsToSelector:@selector(AreaViewStandardCoordinate:points:)])
    {
//        AreaPoint * pt1 = [[AreaPoint alloc] initWithPoint:CGPointMake(_tl.center.x, _tl.center.y)];
//        AreaPoint * pt2 = [[AreaPoint alloc] initWithPoint:CGPointMake(_tr.center.x, _tr.center.y)];
//        AreaPoint * pt3 = [[AreaPoint alloc] initWithPoint:CGPointMake(_bl.center.x, _bl.center.y)];
//        AreaPoint * pt4 = [[AreaPoint alloc] initWithPoint:CGPointMake(_br.center.x, _br.center.y)];
        
        AreaPoint * pt1 = [[AreaPoint alloc] initWithPoint:TR(_tl.center)];
        AreaPoint * pt2 = [[AreaPoint alloc] initWithPoint:TR(_tr.center)];
        AreaPoint * pt3 = [[AreaPoint alloc] initWithPoint:TR(_bl.center)];
        AreaPoint * pt4 = [[AreaPoint alloc] initWithPoint:TR(_br.center)];
        
        [(id)self.delegate AreaViewStandardCoordinate:_coordi points:@[pt1,pt2,pt3,pt4]];
        
        pt1 = nil;
        pt2 = nil;
        pt3 = nil;
        pt4 = nil;
    }
    
#undef TR
}

#pragma mark - align
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
        CGFloat posY = pLeft.center.y + (pRight.center.y - pLeft.center.y)/2;
        [pTarget moveCenter:CGPointMake(posX, posY)];
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

#pragma mark - redraw

//화면이 바뀔때 좌표 변환을 거친 후 모두 다시 그려준다.
-(void)redraw:(CGRect)frame
{
    CGRect before = self.frame;
    
    self.frame = frame;
    
    //비율 구함
    CGFloat offsetX =  frame.size.width  / before.size.width;
    CGFloat offsetY =  frame.size.height / before.size.height;
    
    for (AreaComponent * eachComp in _ptList)
    {
        //해당 비율만큼 좌표 이동 후 다시 그려준다.
        CGPoint translatePt = CGPointMake(eachComp.center.x * offsetX,
                                          eachComp.center.y*offsetY);
        [eachComp moveCenter:translatePt];
    }
    
    [self setNeedsDisplay];
}

@end



@implementation AreaPoint
-(id)initWithPoint:(CGPoint)pt
{
    self = [super init];
    
    if(self)
    {
        _x = pt.x;
        _y = pt.y;
    }
    
    return self;
}
@end



