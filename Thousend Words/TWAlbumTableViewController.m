//
//  TWAlbumTableViewController.m
//  Thousend Words
//
//  Created by Michał Kozak on 22.03.2014.
//  Copyright (c) 2014 Raz Labs. All rights reserved.
//

#import "TWAlbumTableViewController.h"
#import "Album.h"
#import "TWCoreDataHelper.h"
#import "TWPhotosCollectionViewController.h"

@interface TWAlbumTableViewController () <UIAlertViewDelegate>

@end

@implementation TWAlbumTableViewController



-(NSMutableArray *)albums{
    if(!_albums){
        _albums = [[NSMutableArray alloc]init];
    }
    return _albums;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Album"];
    fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES]];
    
    
    NSError *error = nil;
    NSArray *fetchedAlbums = [[TWCoreDataHelper managedObjectContext] executeFetchRequest:fetchRequest error:&error];
    self.albums = [fetchedAlbums mutableCopy];
    [self.tableView reloadData];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addAlbumBarButtonItemPressed:(UIBarButtonItem *)sender {
    UIAlertView *newAlbumAlertView = [[UIAlertView alloc]initWithTitle:@"Enter new album name" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Add", nil];
    
    [newAlbumAlertView setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [newAlbumAlertView show];
}

#pragma mark - helper methods

-(Album *)albumWithName:(NSString *)name{
    
    NSManagedObjectContext *context = [TWCoreDataHelper managedObjectContext];
    
    Album *album = [NSEntityDescription insertNewObjectForEntityForName:@"Album" inManagedObjectContext:context];
    album.name = name;
    album.date = [NSDate date];
    
    NSError *error = nil;
    if(![context save:&error]){
        //we have an error!
        NSLog(@"%@",error);
        
    }
    return album;
}

#pragma mark - UIAlerViewDelegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 1){
        NSString *alertText = [alertView textFieldAtIndex:0].text;
        [self.albums addObject:[self albumWithName:alertText]];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[self.albums count] -1 inSection:0];
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.albums count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    Album *selectedAlbum = self.albums[indexPath.row];
    cell.textLabel.text = selectedAlbum.name;
    
    return cell;
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Album Chosen"]) {
        
        if([segue.destinationViewController isKindOfClass:[TWPhotosCollectionViewController class]]){
            NSIndexPath *path = [self.tableView indexPathForSelectedRow];
            TWPhotosCollectionViewController *targetViewController = segue.destinationViewController;
            targetViewController.album = self.albums[path.row];
        }
    }
    
}


@end
