//
//  GenericAnnotation.m
//  Mapper
//
//  Created by JAMES HARRIS on 12/26/12.
//

#import "GenericAnnotation.h"

@implementation GenericAnnotation

@synthesize coordinate = _coordinate;
@synthesize actualTitle = _actualTitle;
@synthesize actualSubtitle = _actualSubtitle;
@synthesize comments = _comments;

- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate
{
    _coordinate = newCoordinate;
}

- (NSString *)title
{
    return self.actualTitle;
}

- (NSString *)subtitle
{
    return self.actualSubtitle;
}

@end

