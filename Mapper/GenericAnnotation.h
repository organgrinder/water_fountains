//
//  GenericAnnotation.h
//  Mapper
//
//  Created by JAMES HARRIS on 12/26/12.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface GenericAnnotation : NSObject <MKAnnotation>

@property (nonatomic) NSString *actualTitle;
@property (nonatomic) NSString *actualSubtitle;
@property (nonatomic) NSString *comments;

@end
