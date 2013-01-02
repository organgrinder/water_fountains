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

#pragma mark - Detail view controller delegate

// sends the message straight up the chain to the MapViewController
- (void)detailViewController:(DetailViewController *)sender
             updatedComments:(NSString *)newComments 
               forAnnotation:(id)annotation
{
    [self.delegate detailViewController:sender updatedComments:newComments forAnnotation:annotation];
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

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"List to Detail"]) {
        [segue.destinationViewController setAnnotation:self.annotationToDisplay];
        [segue.destinationViewController setDelegate:self];
    }
}

#pragma mark - Table view delegate

// map view controller handles switch back to map view when list cell selected
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GenericAnnotation *chosenFountain = [self.fountainList objectAtIndex:indexPath.row];
    [self.delegate listViewController:self choseFountain:chosenFountain];
}

// switch to detail view when user taps accessory button in list view
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    self.annotationToDisplay = [self.fountainList objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"List to Detail" sender:self];
}

#pragma mark - Display properties

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end