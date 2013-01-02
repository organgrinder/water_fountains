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

@property (nonatomic, weak) IBOutlet UILabel *fountainTitle;
@property (nonatomic, weak) IBOutlet UILabel *location;
@property (nonatomic, weak) IBOutlet UITextView *comments;

@property (nonatomic, weak) id annotation;
@property (nonatomic, weak) id delegate;

@end
