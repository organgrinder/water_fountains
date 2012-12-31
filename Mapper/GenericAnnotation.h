//
//  GenericAnnotation.h
//  Mapper
//
//  Created by JAMES HARRIS on 12/26/12.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface GenericAnnotation : NSObject <MKAnnotation>

@property (nonatomic, copy) NSString *title;
@property (nonatomic, readonly, copy) NSString *subtitle;
@property (nonatomic) NSString *comments;
@property (nonatomic, readonly) int number;

- (id) initWithTitle:(NSString *)title
          coordinate:(CLLocationCoordinate2D)coordinate
            comments:(NSString *)comments
              number:(int)number;

@end
