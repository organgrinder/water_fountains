//
//  ListViewController.h
//  Mapper
//
//  Created by JAMES HARRIS on 12/21/12.
//

#import <UIKit/UIKit.h>
#import "GenericAnnotation.h"
#import "DetailViewController.h"

@class ListViewController;

@protocol ListViewerViewControllerDelegate <NSObject>

- (void)listViewerViewController:(ListViewController *)sender 
                   choseFountain:(id)fountain;

@end

@interface ListViewController : UITableViewController

@property (nonatomic, strong)NSArray *fountainList;
@property (nonatomic, weak) id  delegate;

@end
