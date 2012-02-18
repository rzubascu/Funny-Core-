//
//  ZRLeftBubbleCell.h
//  FunnySiri
//
//  Created by zubby on 2/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZRLeftBubbleCell : UITableViewCell {
	UILabel *_qaTextLabel;
}
/*
 * Update the cell with question/answers
 */
- (void)updateCellWithText:(NSString *)text;
/*
 * Custom initialization method
 */
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andHeight:(CGFloat)height;

@end
