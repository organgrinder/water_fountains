//
//  DetailViewController.m
//  Mapper
//
//  Created by JAMES HARRIS on 12/27/12.
//

#import "DetailViewController.h"
#import "GenericAnnotation.h"
#import <QuartzCore/QuartzCore.h>

@interface DetailViewController ()

@end

@implementation DetailViewController

@synthesize fountainTitle = _fountainTitle;
@synthesize location = _location;
@synthesize comments = _comments;

@synthesize annotation = _annotation;
@synthesize delegate = _delegate;

#pragma mark - UITextViewDelegate Protocol

// move the view into visible range when keyboard appears
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [textView bringSubviewToFront:textView];
    [UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDuration:0.5];
	[UIView setAnimationBeginsFromCurrentState:YES];
	textView.frame = CGRectMake(textView.frame.origin.x, (textView.frame.origin.y - 100.0), textView.frame.size.width, textView.frame.size.height);
	[UIView commitAnimations];
}

// disappear keyboard when user hits "done"
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    // animate textView back into place
    [UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDuration:0.5];
	[UIView setAnimationBeginsFromCurrentState:YES];
	textView.frame = CGRectMake( textView.frame.origin.x, 
                                (textView.frame.origin.y + 100.0), 
                                textView.frame.size.width, 
                                textView.frame.size.height);
	[UIView commitAnimations];
    
    //update the new comments
    [self.delegate detailViewController:self updatedComments:textView.text forAnnotation:self.annotation];
}

#pragma mark - Setting the view

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([self.annotation isKindOfClass:[GenericAnnotation class]]) {
        GenericAnnotation *annotationToDisplay = self.annotation;
        
        self.fountainTitle.text = annotationToDisplay.title;
        self.location.text = annotationToDisplay.subtitle;
        self.location.layer.zPosition = -1;
        
        self.comments.text = annotationToDisplay.comments;
        self.comments.delegate = self;
        self.comments.layer.cornerRadius = 5;
        self.comments.clipsToBounds = YES;
    }
}

- (void)viewDidUnload
{
    [self setLocation:nil];
    [self setComments:nil];
    [self setTitle:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
