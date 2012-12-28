//
//  DetailViewController.m
//  Mapper
//
//  Created by JAMES HARRIS on 12/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DetailViewController.h"

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
    self.comments.text = self.testCommentsString;
    self.location.text = self.testLocationString;
    self.fountainTitle.text = self.testFountainTitleString;
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
