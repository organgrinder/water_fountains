//
//  ListViewController.m
//  Mapper
//
//  Created by JAMES HARRIS on 12/21/12.
//

#import "ListViewController.h"
#import "GenericAnnotation.h"
#import "DetailViewController.h"

@interface ListViewController () <DetailViewControllerDelegate>

@property (nonatomic) id annotationToDisplay;

@end

@implementation ListViewController

@synthesize annotationToDisplay = _annotationToDisplay;

@synthesize fountainList = _fountainList;
@synthesize delegate = _delegate;

#pragma mark - DetailViewControllerDelegate

- (void)detailViewController:(DetailViewController *)sender
             updatedComments:(NSString *)newComments 
               forAnnotation:(id)annotation
{
    //just sends the message up the chain to the MapViewController
    [self.delegate detailViewController:sender updatedComments:newComments forAnnotation:annotation];
}

#pragma mark - Initial display stuff

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
    // create the cell
    static NSString *CellIdentifier = @"Fountain List Item";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:CellIdentifier];
    }

    // configure the cell
    GenericAnnotation *fountain = [self.fountainList objectAtIndex:indexPath.row];
    cell.textLabel.text = fountain.title;

    NSString *detailTextLabel = [NSString stringWithFormat:@"lat/lng: %f/%f",
                                 fountain.coordinate.latitude,
                                 fountain.coordinate.longitude];
    cell.detailTextLabel.text = detailTextLabel;

    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"List to Detail"]) {
        [segue.destinationViewController setAnnotation:self.annotationToDisplay];
        [segue.destinationViewController setDelegate:self];
    }
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GenericAnnotation *chosenFountain = [self.fountainList objectAtIndex:indexPath.row];
    [self.delegate listViewController:self choseFountain:chosenFountain];
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    self.annotationToDisplay = [self.fountainList objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"List to Detail" sender:self];
}

@end

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

