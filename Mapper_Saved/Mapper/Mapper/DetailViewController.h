//
//  DetailViewController.h
//  Mapper
//
//  Created by JAMES HARRIS on 12/27/12.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *fountainTitle;
@property (weak, nonatomic) IBOutlet UILabel *location;
@property (weak, nonatomic) IBOutlet UITextView *comments;

@property (weak, nonatomic) id annotation;

@end
