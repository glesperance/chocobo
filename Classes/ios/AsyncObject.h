#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

@interface AsyncObject : NSObject

-(void) fetchFromEndpoint:(NSString *)endPoint withParams: (NSDictionary *)parameters onSuccess:(void (^)(id responseObject))success onFailure:(void (^)(NSError* error))failure;
-(void) getFromEndpoint:(NSString *)endPoint withParams:(NSDictionary *)parameters onSuccess:(void (^)(id responseObject))success onFailure:(void (^)(NSError* error))failure;
-(NSString*) endPoint;

@end
