//
//  SplineView.m
//  splines
//
//  Created by Oluwapelumi on 5/5/17.
//  Copyright © 2017 Oluwapelumi. All rights reserved.
//

#import "SplineView.h"
#import "bezier.h"


///////////////////////////////////////////////////
@interface CPoint:NSObject
@property CGPoint point;
-(id) initWithCGPoint:(CGPoint) point;
@end
@implementation CPoint

-(id) initWithCGPoint:(CGPoint) point{
    self = [super init];
    if (self){
        _point = point;
    }
    return self;
}
@end
/////////////////////////////////////////


int iter_no = 3;    //default of 3

@interface SplineView ()

@property (nonatomic, strong) NSMutableArray<CPoint*>* points;          //CV Points
@property (nonatomic, strong) NSMutableArray<CPoint*>* b_points;        //Bezier Points
- (void) didReceiveTap:(UITapGestureRecognizer*) tapRecognizer;

@end

@implementation SplineView


- (id) initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        _points = [[NSMutableArray alloc] initWithCapacity:0];
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didReceiveTap:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (int) getIterationNumber{
    return iter_no;
}

- (void) setIterationNumber:(int) iter{
    iter_no = iter;
    [_b_points removeAllObjects];
    [self runAlgorithm];
}

- (void) clearCanvas:(UIButton*) btn{
    [_points removeAllObjects];
    [_b_points removeAllObjects];
    [self setNeedsDisplay];
}

- (void) didReceiveTap:(UITapGestureRecognizer*) tapRecognizer{
    if (_points.count < 4) //We are only doing four points for now
        [_points addObject:[[CPoint alloc] initWithCGPoint:[tapRecognizer locationInView:self] ]];
    [self runAlgorithm];
}

- (void) runAlgorithm{
    if (_points.count == 4){
        CGPoint inputs[4] = {_points[0].point, _points[1].point, _points[2].point, _points[3].point};
        const int output_n = output_size_for_4_points(iter_no);
        printf("Space allocated = %d\n", output_n);
        if (!_b_points || _b_points.count!=output_n)    //order is important here to avoid calling count on a NULL object
        {
            CGPoint outputs[output_n];
            subdivide_n(inputs, outputs, iter_no, 0, 3);    //Entry point //4 points to start with for now, (0:0+3]
            
            if (!_b_points)
                _b_points = [[NSMutableArray alloc] initWithCapacity:0];
            for (int i = 0; i < output_n; i++)
                [_b_points addObject:[[CPoint alloc] initWithCGPoint:outputs[i]]];
        }
    }
    if (_points.count)
        [self setNeedsDisplay];
}

//*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, rect);

    
    CGMutablePathRef path = CGPathCreateMutable();
    int resW = [[UIScreen mainScreen] bounds].size.width;
    int resH = [[UIScreen mainScreen] bounds].size.height;
    for (int i = 0; i <= resW; i+=5){
        CGPathMoveToPoint(path, NULL, i, 0);
        CGPathAddLineToPoint(path, NULL, i, resH);
    }
    for (int i = 0; i <= resH; i+=5){
        CGPathMoveToPoint(path, NULL, 0, i);
        CGPathAddLineToPoint(path, NULL, resH, i);
    }
    CGContextAddPath(context, path);
    CGContextSetLineWidth(context, 1.0);
    [[UIColor darkGrayColor] setStroke];
    CGContextDrawPath(context, kCGPathStroke);
    
    CGContextSetLineCap(context, kCGLineCapSquare);
    CGContextSetLineWidth(context, 2.0);
    CGContextSetStrokeColorWithColor(context, [UIColor cyanColor].CGColor);
    if (_points.count > 1){
        for (int i = 1; i<_points.count; i++){
            CGContextMoveToPoint(context, _points[i-1].point.x, _points[i-1].point.y);
            CGContextAddLineToPoint(context, _points[i].point.x, _points[i].point.y);
        }
        CGContextStrokePath(context);
    }
    
    
    if (_b_points.count){
        CGContextSetStrokeColorWithColor(context, [UIColor greenColor].CGColor);
        CGContextMoveToPoint(context, _b_points[0].point.x, _b_points[0].point.y);
        for (int i = 1; i<_b_points.count; i++){
            CGContextAddLineToPoint(context, _b_points[i].point.x, _b_points[i].point.y);
        }
        CGContextStrokePath(context);
    }
    
    CGPathRelease(path);
}
//*/


@end
