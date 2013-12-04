#import <Foundation/Foundation.h>
#import "AsyncObject.h"

@interface Model : AsyncObject

-(id) initWithJson:(NSDictionary*)json;
-(void)updateModelWithJson:(NSDictionary *)json;
-(void) addDetailsWithJson:(NSDictionary*)json;

@end
