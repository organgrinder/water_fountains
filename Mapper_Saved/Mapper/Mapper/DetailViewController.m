//
//  DetailViewController.m
//  Mapper
//
//  Created by JAMES HARRIS on 12/27/12.
//

#import "DetailViewController.h"
#import "GenericAnnotation.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

@synthesize fountainTitle = _fountainTitle;
@synthesize location = _location;
@synthesize comments = _comments;
@synthesize delegate = _delegate;
@synthesize testLocationString = _testLocationString;
@synthesize testCommentsString = _testCommentsString;
@synthesize testFountainTitleString = _testFountainTitleString;

@synthesize annotation = _annotation;

// formatting
//     NSString *location = [NSString stringWithFormat:@"Lat/lng: %f/%f", 
// fountain.coordinate.latitude, fountain.coordinate.longitude];


- (void)awakeFromNib
{
    // when initialized from a storyboard
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
        GenericAnnotation *annotationToDisplay = self.annotation;
    self.comments.text = annotationToDisplay.comments;
    self.fountainTitle.text = annotationToDisplay.title;
    
    NSString *location = [NSString stringWithFormat:@"Lat/lng: %f/%f", 
                          annotationToDisplay.coordinate.latitude, annotationToDisplay.coordinate.longitude];
    self.location.text = location;
}

- (void)viewDidUnload
{
    [self setLocation:nil];
    [self setComments:nil];
    [self setTitle:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
