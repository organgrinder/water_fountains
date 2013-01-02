//
//  MapViewController.m
//  Mapper
//
//  Created by JAMES HARRIS on 12/21/12.
//

#import "MapViewController.h"
#import "GenericAnnotation.h"
#import "ListViewController.h"
#import "DetailViewController.h"

@interface MapViewController () <MKMapViewDelegate, ListViewControllerDelegate, DetailViewControllerDelegate>

@property (nonatomic) GenericAnnotation *annotationForDetailView;

@end

@implementation MapViewController

@synthesize mapView = _mapView;
@synthesize annotationForDetailView = _annotationForDetailView;

#pragma mark Detail view controller delegate

// save changes to comments when detail view controller says they have changed
- (void)detailViewController:(DetailViewController *)sender
             updatedComments:(NSString *)newComments 
               forAnnotation:(GenericAnnotation *)annotation
{
    annotation.comments = newComments;
    NSString *key = [NSString stringWithFormat:@"fountain%i", annotation.number];
    [[NSUserDefaults standardUserDefaults] setObject:newComments forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark List view controller delegate

// when returning form list view, center map on selected fountain and show callout
- (void)listViewController:(ListViewController *)listView choseFountain:(id)fountain
{
    GenericAnnotation *chosenAnnotation = fountain;
    
    CLLocationCoordinate2D newCenter;
    newCenter.latitude = chosenAnnotation.coordinate.latitude;
    newCenter.longitude = chosenAnnotation.coordinate.longitude;
    [self.mapView setCenterCoordinate:newCenter];
    
    [self.mapView selectAnnotation:chosenAnnotation animated:TRUE];
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark Navigation

// segue to detail view when user taps callout accessory on map
- (void)mapView:(MKMapView *)sender annotationView:(MKAnnotationView *)aView calloutAccessoryControlTapped:(UIControl *)control
{
    self.annotationForDetailView = aView.annotation;
    [self performSegueWithIdentifier:@"Map to Detail" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Map to List"]) {
        [segue.destinationViewController setFountainList:self.mapView.annotations];
        [segue.destinationViewController setDelegate:self];
    } else if ([segue.identifier isEqualToString:@"Map to Detail"]) {
        [segue.destinationViewController setAnnotation:self.annotationForDetailView];
        [segue.destinationViewController setDelegate:self];
    }
}

#pragma mark Setting the initial map

- (MKAnnotationView *)mapView:(MKMapView *)sender
            viewForAnnotation:(id <MKAnnotation>)annotation
{
    MKAnnotationView *aView = [sender dequeueReusableAnnotationViewWithIdentifier:@"IDENT"]; 
    if (!aView) {
        aView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation
                                                reuseIdentifier:@"IDENT"];
    }
    
    aView.canShowCallout = YES;
    aView.annotation = annotation; // happens twice if no dequeue
    aView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure]; 
    
    return aView;
}

- (void)setMapView:(MKMapView *)mapView
{
    _mapView = mapView;
    [self initialzeViewPort];
    
    [self.mapView addAnnotations:[self staticFountainList]];
}

#define SF_CENTER_LAT 37.79550844953692;
#define SF_CENTER_LNG -122.39370346069336;
#define DEFAULT_SPAN .1;

- (void)initialzeViewPort
{
    CLLocationCoordinate2D startCenter;
    startCenter.latitude = SF_CENTER_LAT;
    startCenter.longitude = SF_CENTER_LNG;

    MKCoordinateRegion startRegion;
    startRegion.span.latitudeDelta = DEFAULT_SPAN;
    startRegion.center = startCenter;

    [self.mapView setRegion:startRegion];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.mapView.delegate = self;
}

- (void)viewDidUnload
{
    [self setMapView:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark Helper methods for initializing annotations array

// returns a static list of sample fountains at predefined locations
- (NSArray *)staticFountainList
{
    NSMutableArray *fountains = [[NSMutableArray alloc] init];
    
    for (int i = 0; i <= 7; i++) {
        [fountains addObject:[self oneStaticFountain:i]];
    }
    
    return fountains;
}

// helper method to create one of several predefined fountain annotations
// in a larger app, this would be in a database or at least some kind of array
- (GenericAnnotation *)oneStaticFountain:(int)fountainNum
{
    CLLocationCoordinate2D myCoords;
    NSString *myTitle = @"Water Fountain"; // default title
    NSString *myComments = @"No comments yet"; // default comments

    // simulate user-entered data
    if (fountainNum == 0) {
        myCoords.latitude = 37.778703223837695;
        myCoords.longitude = -122.38756656646729;
        // fountain 0 has no comments
        myTitle = @"Fountain of Youth";
    } else if (fountainNum == 1) {
        myCoords.latitude =  37.80669003118687;
        myCoords.longitude = -122.43433356285095;
        myComments = @"This one is hard to find - it's behind the bathroom.";
        // fountain 1 has no custom title;
    } else if (fountainNum == 2) {
        myCoords.latitude = 37.807478357821374;
        myCoords.longitude = -122.42207050323486;
        myComments = @"They turn the fountain off in winter - why?? It never freezes in SF!";
        myTitle = @"Favorite Drinking Spot";        
    } else if (fountainNum == 3) {
        myCoords.latitude = 37.775938728915946;
        myCoords.longitude = -122.43464469909668;
        myComments = @"This fountain smells funny.";
        myTitle = @"First Fountain";
    } else if (fountainNum == 4) {
        myCoords.latitude = 37.79555931727373;
        myCoords.longitude = -122.39357471466064;
        myComments = @"This one is inside the ferry building.";
        myTitle = @"Lifesaver";
    } else if (fountainNum == 5) {
        myCoords.latitude = 37.77203773200978;
        myCoords.longitude = -122.44771242141724;
        myComments = @"By the bathrooms.  May be closed for construction.  Approximate location.";
        myTitle = @"Panhandle Fountain";
    } else if (fountainNum == 6) {
        myCoords.latitude = 37.77591116824674;
        myCoords.longitude = -122.42442816495895;
        myComments = @"In the little park in the middle of the road.";
        myTitle = @"Hayes Valley Sipper";
    } else if (fountainNum == 7) {
        myCoords.latitude = 37.79368566585406;
        myCoords.longitude = -122.39194393157959;
        myComments = @"It's a TRICK - the fountain is DRY!  Do not be fooled!";
        myTitle = @"Rocket Fountain";
    }

    NSString *key = [NSString stringWithFormat:@"fountain%i", fountainNum];
    
    // when user makes changes to comments, edited comments are saved to NSUserDefaults
    NSString *savedComments = [[NSUserDefaults standardUserDefaults] stringForKey:key];

    if (savedComments) myComments = savedComments;

    GenericAnnotation *myAnnotation = [[GenericAnnotation alloc] initWithTitle:myTitle
                                                                    coordinate:myCoords 
                                                                      comments:myComments
                                                                        number:fountainNum];
    return myAnnotation;
}

@end
