//
//  ListViewerViewController.m
//  Mapper
//
//  Created by JAMES HARRIS on 12/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ListViewController.h"

@interface ListViewController ()

@property (nonatomic)NSString *detailComments;
@property (nonatomic)NSString *detailLocation;
@property (nonatomic)NSString *detailTitle;

@end

@implementation ListViewController

@synthesize detailComments = _detailComments;
@synthesize detailLocation = _detailLocation;
@synthesize detailTitle = _detailTitle;

@synthesize fountainList = _fountainList;
@synthesize delegate = _delegate;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
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

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.fountainList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Fountain List Item";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }

    // Configure the cell...
    GenericAnnotation *fountain = [self.fountainList objectAtIndex:indexPath.row];
    NSString *textLabel = fountain.title;
    cell.textLabel.text = textLabel;
    NSString *detailTextLabel = [NSString stringWithFormat:@"lat/lng: %f/%f",fountain.coordinate.latitude,fountain.coordinate.longitude];
    cell.detailTextLabel.text = detailTextLabel;
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
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    GenericAnnotation *fountain = [self.fountainList objectAtIndex:indexPath.row];
    self.detailComments = fountain.comments;
    NSString *location = [NSString stringWithFormat:@"Lat/lng: %f/%f", 
                          fountain.coordinate.latitude, fountain.coordinate.longitude];
    self.detailLocation = location;
    self.detailTitle = fountain.title;

    [self performSegueWithIdentifier:@"List to Detail" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"List to Detail"]) {
        
        [segue.destinationViewController setTestLocationString:self.detailLocation];
        [segue.destinationViewController setTestCommentsString:self.detailComments];
        [segue.destinationViewController setTestFountainTitleString:self.detailTitle];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate listViewerViewController:self 
                              choseFountain:[self.fountainList objectAtIndex:indexPath.row]];
    
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
