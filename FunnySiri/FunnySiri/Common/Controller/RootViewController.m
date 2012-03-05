//
//  RootViewController.m
//  FunnySiri
//
//  Created by zubby on 2/10/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"
#import "ZRLeftBubbleCell.h"
#import "ZRRightBubbleCell.h"
#import "ZRAppDelegate.h"
#import "ZRButtonStandView.h"

#pragma mark - Private

@interface RootViewController() 
/*
 * Private method to update cell with information
 */
- (void)updateCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
/*
 * Return the array of the managed objects from the Core Data DB
 */
- (NSArray *)getTheCurrentDBForContext:(NSManagedObjectContext *)context;
/*
 * Return the array of the QA objects from the Core Data DB for the current selected managed object
 */
- (NSArray *)getCurrentQAArrayFromManagedObject:(NSManagedObject *)managedObject;


@end

#pragma mark - Public

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
//		 self.view.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
		 
		 ZRAppDelegate *appDelegate = (ZRAppDelegate *)[[UIApplication sharedApplication] delegate];
		 NSManagedObjectContext *context = [appDelegate managedObjectContext];
		 _allDBArray = [self getTheCurrentDBForContext:context];
		 
		 // Set current object
		 _currentManagedObject = [_allDBArray objectAtIndex:0];
		 // Process current object
		 _qaArray = [self getCurrentQAArrayFromManagedObject:_currentManagedObject];
		 
		 UIButton *siriButton = [UIButton buttonWithType:UIButtonTypeCustom];
		 siriButton.frame = CGRectMake(0.0f, 0.0f, 70.0f, 70.0f);
		 siriButton.center = CGPointMake(160.0f, 50.0f);
		 [siriButton setImage:[UIImage imageNamed:@"siri_normal.png"] forState:UIControlStateNormal];
		 [siriButton setImage:[UIImage imageNamed:@"siri_pressed.png"] forState:UIControlStateHighlighted];

		 		 
		 // Table view initialization
		 _bubbleTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
		 _bubbleTableView.delegate = self;
		 _bubbleTableView.dataSource = self;
		 _bubbleTableView.backgroundColor = [UIColor clearColor];
		 _bubbleTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
		 _bubbleTableView.rowHeight = 100.0f;
		 
		 UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
		 backgroundImageView.image = [UIImage imageNamed:@"siri_background.png"];
		 
		 ZRButtonStandView *standView = [[ZRButtonStandView alloc] initWithFrame:CGRectMake(0.0f, 380.0f, 320.0f, 100.0f)];
		 
		 [self.view addSubview:backgroundImageView];
		 [self.view addSubview:_bubbleTableView];
		 [standView addSubview:siriButton];

		 [self.view addSubview:standView];

    }
    return self;
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#pragma mark - Table View delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return [_qaArray count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 100.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 20.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
	return 0.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, tableView.frame.size.width, 20.0f)];
	headerView.backgroundColor = [UIColor clearColor];
	return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *cellIdentifier = @"BubbleViewCell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	Class cellClass = (indexPath.section%2 == 0) ? [ZRLeftBubbleCell class] : [ZRRightBubbleCell class];
	if (cell == nil) {
		cell = [[cellClass alloc] initWithStyle:UITableViewCellStyleDefault 
										reuseIdentifier:cellIdentifier
												andHeight:100.0f];
	}
	cell.backgroundColor = [UIColor clearColor];
	// Update cell
	[self updateCell:cell atIndexPath:indexPath];
	
	return cell;
}

#pragma mark - Private

- (void)updateCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
	
	
}

- (NSArray *)getTheCurrentDBForContext:(NSManagedObjectContext *)context {
	NSError *error;
	if (![context save:&error]) {
		NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
	}
	////
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription 
											 entityForName:@"QAInfo" inManagedObjectContext:context];
	[fetchRequest setEntity:entity];
	NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
	for (NSManagedObject *info in fetchedObjects) {
		NSLog(@"+++++: %@", [info valueForKey:@"question1"]);
		NSLog(@"-----: %@", [info valueForKey:@"answer1"]);
	}        

	return fetchedObjects;
}

- (NSArray *)getCurrentQAArrayFromManagedObject:(NSManagedObject *)managedObject {
	NSMutableArray *qaArray = [NSMutableArray array];
	NSEntityDescription * myEntity = [managedObject entity];
	NSDictionary * attributes = [myEntity attributesByName];
	NSArray *allAttributtesArray = [attributes allKeys];
	
	for (NSString *key in allAttributtesArray) {
		NSString *currentQAString = [managedObject valueForKey:key];
		if (nil != currentQAString && 0 < [currentQAString length]) {
			NSDictionary *dict = [NSDictionary dictionaryWithObject:currentQAString forKey:key];
			[qaArray addObject:dict];
		}
	}
	return qaArray;
}


@end
