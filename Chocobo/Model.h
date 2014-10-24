#import <Foundation/Foundation.h>
#import "AsyncObject.h"

@class Collection;

@interface Model : AsyncObject

@property (nonatomic, strong) Collection * collection;

-(id) initWithJson:(NSDictionary*)json;
-(void)updateWithJson:(NSDictionary *)json;
-(void)updateModelWithJson:(NSDictionary *)json __attribute__((deprecated));
-(void)addDetailsWithJson:(NSDictionary*)json;
-(void)save:(NSDictionary *)attributes success:(void(^)(id responseObject))success failure:(void (^)(NSError* error))failure;

@end
