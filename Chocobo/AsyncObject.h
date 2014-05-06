#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "Environment.h"

@interface AsyncObject : NSObject

-(void) postToEndpoint:(NSString *)endPoint withParams: (NSDictionary *)parameters onSuccess:(void (^)(id responseObject))success onFailure:(void (^)(NSError* error))failure;
-(void) putToEndpoint:(NSString *)endPoint withParams:(NSDictionary *)parameters onSuccess:(void (^)(id responseObject))success onFailure:(void (^)(NSError* error))failure;
-(void) multipartPostToEndpoint:(NSString *)endPoint withData:(NSData *)data withName:(NSString *)name withFileName:(NSString *)fileName withMimeType:(NSString *)mimeType withParams: (NSDictionary *)parameters onSuccess:(void (^)(id responseObject))success onFailure:(void (^)(NSError* error))failure;
-(void) getFromEndpoint:(NSString *)endPoint withParams:(NSDictionary *)parameters onSuccess:(void (^)(id responseObject))success onFailure:(void (^)(NSError* error))failure;
-(NSString *) endPoint;

@end
