//
//  MapViewController.m
//  Mapper
//
//  Created by JAMES HARRIS on 12/21/12.
//

#import "MapViewController.h"
#import "GenericAnnotation.h"
#import "ListViewController.h"

@interface MapViewController () <MKMapViewDelegate>

@property (nonatomic) GenericAnnotation *annotationForDetailView;

@end

@implementation MapViewController

@synthesize myMap = _myMap;
@synthesize annotationForDetailView = _annotationForDetailView;

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Map to List"]) {
        [segue.destinationViewController setFountainList:self.myMap.annotations];
        [segue.destinationViewController setDelegate:self];
    } else if ([segue.identifier isEqualToString:@"Map to Detail"]) {
        [segue.destinationViewController setAnnotation:self.annotationForDetailView];
    }
}

- (void)listViewerViewController:(ListViewController *)listView choseFountain:(id)fountain
{
    GenericAnnotation *chosenAnnotation = fountain;

    CLLocationCoordinate2D newCenter;
    newCenter.latitude = chosenAnnotation.coordinate.latitude;
    newCenter.longitude = chosenAnnotation.coordinate.longitude;
    [self.myMap setCenterCoordinate:newCenter];
    
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

- (void)setMyMap:(MKMapView *)myMap
{
    _myMap = myMap;
    [self initialzeViewPort];
        
    for (int i = 0; i < 5; i++) {
        GenericAnnotation *myNewAnnotation = [self oneStaticFountain:i];
        [self.myMap addAnnotation:myNewAnnotation];
    }
    NSLog(@"in setMyMap");
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
    [self.myMap setRegion:startRegion];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.myMap.delegate = self;
}

- (void)viewDidUnload
{
    [self setMyMap:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (GenericAnnotation *)oneStaticFountain:(int)number
{
    GenericAnnotation *myAnnotation = [[GenericAnnotation alloc] init];
    CLLocationCoordinate2D myCoords;
    NSString *myComments = @"No comments yet";
    NSString *myTitle = @"Water Fountain";
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
    }
    
    myAnnotation.coordinate = myCoords;
    myAnnotation.actualTitle = myTitle;
    myAnnotation.actualSubtitle = [NSString stringWithFormat:@"lat/lng: %f/%f", myCoords.latitude, myCoords.longitude];
    myAnnotation.comments = myComments;
    return myAnnotation;
}

@end
