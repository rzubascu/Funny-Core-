//
//  ZRLeftBubbleCell.m
//  FunnySiri
//
//  Created by zubby on 2/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ZRLeftBubbleCell.h"

@implementation ZRLeftBubbleCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andHeight:(CGFloat)height {
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		// Initialization code
		CGRect labelFrame = super.frame;
		labelFrame.origin.x = 40.0f;
		labelFrame.origin.y = 10.0f;
		labelFrame.size.width -= 80.0f;
		labelFrame.size.height = height - 40.0f;
		_qaTextLabel = [[UILabel alloc] initWithFrame:labelFrame];
		_qaTextLabel.backgroundColor = [UIColor greenColor];
		_qaTextLabel.textAlignment = UITextAlignmentCenter;
	 
		[self addSubview:_qaTextLabel];
	}
	return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)drawRect:(CGRect)rect {
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	CGFloat radius = 20;
	
	CGFloat originBufferX = 0.0;
	CGFloat originBufferY = 0.0;
	CGFloat rightAngleTriangleWidth = 10.0;
	CGFloat rightAngleTriangleHeight = 10.0;
	CGFloat fullRectWidth = rect.size.width - 10;
	CGFloat fullRectHeight = rect.size.height;
	
	
	CGPoint pointZero = CGPointMake(originBufferX, fullRectHeight);
	CGPoint pointOne = CGPointMake(originBufferX + rightAngleTriangleWidth, fullRectHeight - rightAngleTriangleHeight);
	CGPoint pointTwo = CGPointMake(originBufferX + rightAngleTriangleWidth, radius + originBufferY);
	CGPoint pointThree = CGPointMake(originBufferX + fullRectWidth - radius, 0 + originBufferY);
	CGPoint pointFour = CGPointMake(fullRectWidth, originBufferY + fullRectHeight - radius);    
	
	CGContextSetRGBStrokeColor(context, 0.8, 0.8, 0.8, 0.3);
	
	CGMutablePathRef path = CGPathCreateMutable();
	CGPathMoveToPoint(path, NULL, pointZero.x, pointZero.y);
	
	CGPathAddLineToPoint(path, NULL, pointOne.x, pointOne.y);
	
	CGPathAddLineToPoint(path, NULL, pointTwo.x, pointTwo.y);
	
	CGPathAddArc(path, NULL, rightAngleTriangleWidth + radius, originBufferY + radius, radius, M_PI, -M_PI_2, 0);
	
	CGPathAddLineToPoint(path, NULL, pointThree.x, pointThree.y);
	
	CGPathAddArc(path, NULL, fullRectWidth - radius, originBufferY + radius, radius, -M_PI_2, 0.0f, 0);
	
	CGPathAddLineToPoint(path, NULL, pointFour.x, pointFour.y);
	
	CGPathAddArc(path, NULL, fullRectWidth - radius, originBufferY + fullRectHeight - radius, radius, 0.0f, M_PI_2, 0);
	
	CGPathAddLineToPoint(path, NULL, pointZero.x, pointZero.y);
	
	CGContextSaveGState(context);
	CGContextAddPath(context, path);
	
	CGContextSetLineWidth(context, 2.0f);
	CGContextSetRGBFillColor(context, 1.0f, 1.0f, 1.0f, 0.1f);
	CGContextFillPath(context);
	
	CGContextAddPath(context, path);
	CGContextStrokePath(context);
}

/*
 * Update the cell with question/answers
 */
- (void)updateCellWithText:(NSString *)text {
	_qaTextLabel.text = text;
}



@end
