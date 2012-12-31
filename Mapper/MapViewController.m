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

#pragma mark DetailViewControllerDelegate

- (void)detailViewController:(DetailViewController *)sender
             updatedComments:(NSString *)newComments 
               forAnnotation:(id)annotation
{
    for (GenericAnnotation *currentAnnotation in self.mapView.annotations) {
        if ([currentAnnotation isEqual:annotation]) {
            currentAnnotation.comments = newComments;
            NSString *key = [NSString stringWithFormat:@"fountain%i",
                             currentAnnotation.number];
            [[NSUserDefaults standardUserDefaults] setObject:newComments forKey:key];
//            NSLog(@"new comments for");
//            NSLog(key);
//            NSLog([[NSUserDefaults standardUserDefaults] stringForKey:key]);
        }
    }
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

// when returning form list view, center map on selected fountain and show callout
- (void)listViewController:(ListViewController *)listView choseFountain:(id)fountain
{
    GenericAnnotation *chosenAnnotation = fountain;

    CLLocationCoordinate2D newCenter;
    newCenter.latitude = chosenAnnotation.coordinate.latitude;
    newCenter.longitude = chosenAnnotation.coordinate.longitude;
    [self.mapView setCenterCoordinate:newCenter];
    
    for (id<MKAnnotation> currentAnnotation in self.mapView.annotations) {       
        if ([currentAnnotation isEqual:chosenAnnotation]) {
            [self.mapView selectAnnotation:currentAnnotation animated:FALSE];
        }
    }

    [self.navigationController popViewControllerAnimated:YES];
}

- (MKAnnotationView *)mapView:(MKMapView *)sender
            viewForAnnotation:(id <MKAnnotation>)annotation
{
    MKAnnotationView *aView = [sender dequeueReusableAnnotationViewWithIdentifier:@"IDENT"]; 
    if (!aView) {
        aView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation
                                                reuseIdentifier:@"IDENT"];
    }
    
    aView.canShowCallout = YES;
    aView.annotation = annotation; // yes, this happens twice if no dequeue
    aView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure]; 
    
    return aView;
}

- (void)mapView:(MKMapView *)sender 
 annotationView:(MKAnnotationView *)aView
calloutAccessoryControlTapped:(UIControl *)control
{
    self.annotationForDetailView = aView.annotation;
    [self performSegueWithIdentifier:@"Map to Detail" sender:self];
}

- (void)setMapView:(MKMapView *)mapView
{
    _mapView = mapView;
    [self initialzeViewPort];
    
    // add a static list of annotations to the map
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

// returns a list of sample fountains at predefined locations
- (NSArray *)staticFountainList
{
    NSMutableArray *fountains = [[NSMutableArray alloc] init];
    
    for (int i = 0; i <= 7; i++) {
        GenericAnnotation *myNewAnnotation = [self oneStaticFountain:i];
        [fountains addObject:myNewAnnotation];
    }
    
    return fountains;
}

// helper method to add list of fountains to the map
- (GenericAnnotation *)oneStaticFountain:(int)number
{
    CLLocationCoordinate2D myCoords;
    NSString *myTitle = @"Water Fountain"; // default title
    NSString *myComments = @"No comments yet"; // default comments

    // simulate user-entered data
    if (number == 0) {
        myCoords.latitude = 37.79;
        myCoords.longitude = -122.39;
        // fountain 0 has no comments
        myTitle = @"Fountain of Youth";
    } else if (number ==1) {
        myCoords.latitude = 37.78;
        myCoords.longitude = -122.39;
        myComments = @"This one is hard to find - it's behind the bathroom.";
        // fountain 1 has no custom title;
    } else if (number ==2) {
        myCoords.latitude = 37.79;
        myCoords.longitude = -122.40;
        myComments = @"They turn the fountain off in winter - why?? It never freezes in SF!";
        myTitle = @"Favorite Drinking Spot";        
    } else if (number ==3) {
        myCoords.latitude = 37.75;
        myCoords.longitude = -122.41;
        myComments = @"This fountain smells funny.";
        myTitle = @"First Fountain";
    } else if (number ==4) {
        myCoords.latitude = 37.78;
        myCoords.longitude = -122.44;
        myComments = @"The water at this fountain is nice and cold.";
        myTitle = @"Lifesaver";
    } else if (number == 5) {
        myCoords.latitude = 37.77203773200978;
        myCoords.longitude = -122.44771242141724;
        myComments = @"By the bathrooms.  May be closed for construction.  Approximate location.";
        myTitle = @"Panhandle Fountain";
    } else if (number == 6) {
        myCoords.latitude = 37.77591116824674;
        myCoords.longitude = -122.42442816495895;
        myComments = @"In the little park in the middle of the road.";
        myTitle = @"Hayes Valley Sipper";
    } else if (number == 7) {
        myCoords.latitude = 37.79368566585406;
        myCoords.longitude = -122.39194393157959;
        myComments = @"It's a TRICK - the fountain is DRY!  Do not be fooled!";
        myTitle = @"Rocket Fountain";
    }

    NSString *key = [NSString stringWithFormat:@"fountain%i", number];
    NSString *savedComments;
    savedComments = [[NSUserDefaults standardUserDefaults] stringForKey:key];

    if (savedComments) myComments = savedComments;

//    NSLog(key);
//    if (savedComments) NSLog(savedComments);
//    else NSLog(@"no saved comments");
        
    GenericAnnotation *myAnnotation = [[GenericAnnotation alloc] initWithTitle:myTitle
                                                                    coordinate:myCoords 
                                                                      comments:myComments
                                                                        number:number];
    return myAnnotation;
}

@end
