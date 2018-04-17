//
//  AreaView.h
//  AreaVerifier
//
//  Created by 장웅 on 2018. 4. 16..
//  Copyright © 2018년 장웅. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol AreaViewDelegate
@optional
//기준 좌표
-(CGSize)AreaViewStandardCoordinate;
//변환된 좌표로 환산
-(void)AreaViewStandardCoordinate:(CGSize)coordi points:(NSArray*)points;
@end

@interface AreaView : UIView
@property(weak) id<AreaViewDelegate> delegate;
-(void)redraw:(CGRect)frame;
@end

@interface AreaPoint :NSObject
@property(nonatomic) CGFloat x;
@property(nonatomic) CGFloat y;
-(id)initWithPoint:(CGPoint)pt;
@end
