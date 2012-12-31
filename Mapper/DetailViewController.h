//
//  DetailViewController.h
//  Mapper
//
//  Created by JAMES HARRIS on 12/27/12.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@protocol DetailViewControllerDelegate <NSObject>

- (void)detailViewController:(DetailViewController *)sender
             updatedComments:(NSString *)newComments 
               forAnnotation:(id)annotation;

@end

@interface DetailViewController : UIViewController <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *fountainTitle;
@property (weak, nonatomic) IBOutlet UILabel *location;
@property (weak, nonatomic) IBOutlet UITextView *comments;

@property (weak, nonatomic) id annotation;
@property (weak) id delegate;

@end
