#import "AsyncObject.h"

@implementation AsyncObject

#pragma mark -
#pragma mark Async Helpers

-(void) fetchFromEndpoint:(NSString *)endPoint withParams: (NSDictionary *)parameters onSuccess:(void (^)(id responseObject))success onFailure:(void (^)(NSError* error))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

    [manager POST:[[self endPoint] stringByAppendingString:endPoint] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {

        success(responseObject);

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

        failure(error);

    }];
}

-(void) getFromEndpoint:(NSString *)endPoint withParams:(NSDictionary *)parameters onSuccess:(void (^)(id responseObject))success onFailure:(void (^)(NSError* error))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

    [manager GET:[[self endPoint] stringByAppendingString:endPoint] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {

        success(responseObject);

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

        failure(error);

    }];
}

-(NSString*) endPoint
{
    return @"http://localhost:3000/";
}

@end
