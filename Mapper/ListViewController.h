//
//  ListViewController.h
//  Mapper
//
//  Created by JAMES HARRIS on 12/21/12.
//

#import <UIKit/UIKit.h>

@class ListViewController;

@protocol ListViewControllerDelegate <NSObject>

- (void)listViewController:(ListViewController *)sender 
                   choseFountain:(id)fountain;

@end

@interface ListViewController : UITableViewController

@property (nonatomic) NSArray *fountainList;
@property (nonatomic, weak) id  delegate;

@end
