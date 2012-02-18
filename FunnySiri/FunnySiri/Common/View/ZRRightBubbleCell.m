//
//  ZRRightBubbleCell.m
//  FunnySiri
//
//  Created by zubby on 2/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ZRRightBubbleCell.h"

@implementation ZRRightBubbleCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andHeight:(CGFloat)height {
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		 // Initialization code
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
	
	CGFloat originBufferX = rect.size.width;
	CGFloat originBufferY = 0.0;
	CGFloat rightAngleTriangleWidth = 10.0;
	CGFloat rightAngleTriangleHeight = 10.0;
	CGFloat fullRectWidth = rect.size.width;
	CGFloat fullRectHeight = rect.size.height;
	
	
	CGPoint pointZero = CGPointMake(originBufferX, fullRectHeight);
	CGPoint pointOne = CGPointMake(originBufferX - rightAngleTriangleWidth, fullRectHeight - rightAngleTriangleHeight);
	CGPoint pointTwo = CGPointMake(originBufferX - rightAngleTriangleWidth, radius + originBufferY);
	CGPoint pointThree = CGPointMake(originBufferX - fullRectWidth + radius + 10.0f, 0 + originBufferY);
	CGPoint pointFour = CGPointMake(10.0f, fullRectHeight - radius);    
	
	CGContextSetRGBStrokeColor(context, 0.8, 0.8, 0.8, 0.3);
	
	CGMutablePathRef path = CGPathCreateMutable();
	CGPathMoveToPoint(path, NULL, pointZero.x, pointZero.y);
	
	CGPathAddLineToPoint(path, NULL, pointOne.x, pointOne.y);
	
	CGPathAddLineToPoint(path, NULL, pointTwo.x, pointTwo.y);
	
	CGPathAddArcToPoint(path, NULL, pointTwo.x , pointTwo.y - radius, pointTwo.x - radius, 0, radius);
	
	//	
	CGPathAddLineToPoint(path, NULL, pointThree.x, pointThree.y);
	
	CGPathAddArcToPoint(path, NULL, pointThree.x - radius , pointThree.y, pointThree.x - radius, pointThree.y + radius, radius);
	//	
	CGPathAddLineToPoint(path, NULL, pointFour.x, pointFour.y);
	
	CGPathAddArcToPoint(path, NULL, pointFour.x, pointFour.y + radius, pointFour.x + radius, pointFour.y + radius, radius);
	
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
