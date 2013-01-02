//
//  GenericAnnotation.m
//  Mapper
//
//  Created by JAMES HARRIS on 12/26/12.
//

#import "GenericAnnotation.h"

@implementation GenericAnnotation

// class is called 'GenericAnnotation' so it could be used in the future for annotations besides water fountains

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

- (NSString *) subtitle
{
    // subtitle is just a readable version of the coordinate
    return [NSString stringWithFormat:@"lat, lng: %f, %f",
        self.coordinate.latitude,
        self.coordinate.longitude];    
}

- (void)setCoordinate:(CLLocationCoordinate2D)coordinate
{
    _coordinate = coordinate;
}

@end

