//
//  GenericAnnotation.m
//  Mapper
//
//  Created by JAMES HARRIS on 12/26/12.
//

#import "GenericAnnotation.h"

@implementation GenericAnnotation

@synthesize coordinate = _coordinate;
@synthesize title = _title;
@synthesize subtitle = _subtitle;
@synthesize comments = _comments;
@synthesize number = _number;

- (id) initWithTitle:(NSString *)title 
          coordinate:(CLLocationCoordinate2D)coordinate 
            comments:(NSString *)comments
              number:(int)number
{
    self = [super init];
    
    [self setTitle:title];
    [self setCoordinate:coordinate];
    [self setComments:comments];
    [self setNumber:number];
    
    return self;
}

// not really used but kept for debugging
- (NSString *) description
{
    return [NSString stringWithFormat:@"Title: %s is at %s", 
        self.title, 
        self.subtitle];
}

- (NSString *) subtitle
{
    return [NSString stringWithFormat:@"lat, lng: %f, %f",
        self.coordinate.latitude,
        self.coordinate.longitude];    
}

- (void)setCoordinate:(CLLocationCoordinate2D)coordinate
{
    _coordinate = coordinate;
}

- (void)setNumber:(int)number
{
    _number = number;
}

@end

