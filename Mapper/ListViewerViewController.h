//
//  ListViewerViewController.h
//  Mapper
//
//  Created by JAMES HARRIS on 12/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GenericAnnotation.h"
#import "DetailedFoutainViewController.h"

@class ListViewerViewController;

@protocol ListViewerViewControllerDelegate <NSObject>

@optional
- (void)listViewerViewController:(ListViewerViewController *)sender choseFountain:(id)fountain;

@end

@interface ListViewerViewController : UITableViewController

@property (nonatomic, strong)NSArray *fountainList;
@property (nonatomic, weak) id  delegate;


@end
