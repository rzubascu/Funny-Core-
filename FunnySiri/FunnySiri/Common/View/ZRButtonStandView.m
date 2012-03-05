//
//  ZRButtonStandView.m
//  FunnySiri
//
//  Created by zubby on 3/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ZRButtonStandView.h"
#import "QuartzCore/QuartzCore.h"

@implementation ZRButtonStandView

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		// Initialization code
		UIImageView *standImageView = [[UIImageView alloc ] initWithFrame:self.bounds];
		standImageView.image = [UIImage imageNamed:@"siri_button_stand.png"];
		standImageView.layer.shadowColor = [UIColor blackColor].CGColor;
		standImageView.layer.shadowOffset = CGSizeMake(0, -5);
		standImageView.layer.shadowOpacity = 1;
		standImageView.layer.shadowRadius = 3.0;
		
		[self addSubview:standImageView];
	}
	return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
	// Drawing code
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetRGBStrokeColor(context, 0.8, 0.8, 0.8, 0.3);
	
	CGMutablePathRef path = CGPathCreateMutable();
	CGPathMoveToPoint(path, NULL, 0.0f,	0.0f);
	
	CGPathAddLineToPoint(path, NULL, 100.0f, 100.0f);

	
	CGContextSaveGState(context);
	CGContextAddPath(context, path);
	
	CGContextSetLineWidth(context, 1.0f);
	CGContextSetRGBFillColor(context, 1.0f, 1.0f, 1.0f, 0.1f);
	CGContextFillPath(context);
	
	CGContextAddPath(context, path);
	CGContextStrokePath(context);	

}


@end
