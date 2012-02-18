//
//  RootViewController.h
//  FunnySiri
//
//  Created by zubby on 2/10/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
	UITableView			*_bubbleTableView;
	NSArray				*_qaArray;
	NSManagedObject	*_currentManagedObject;
	NSArray				*_allDBArray;
}	

@end
