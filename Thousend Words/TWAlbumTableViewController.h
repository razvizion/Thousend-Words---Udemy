//
//  TWAlbumTableViewController.h
//  Thousend Words
//
//  Created by Michał Kozak on 22.03.2014.
//  Copyright (c) 2014 Raz Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TWAlbumTableViewController : UITableViewController 
- (IBAction)addAlbumBarButtonItemPressed:(UIBarButtonItem *)sender;

@property (strong, nonatomic) NSMutableArray *albums;

@end
