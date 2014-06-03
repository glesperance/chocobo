#import <Foundation/Foundation.h>
#import "AsyncObject.h"

@class Collection;

@interface Model : AsyncObject

@property (nonatomic, strong) Collection * collection;

-(id) initWithJson:(NSDictionary*)json;
-(void)updateModelWithJson:(NSDictionary *)json;
-(void) addDetailsWithJson:(NSDictionary*)json;

@end
