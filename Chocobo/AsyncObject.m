#import "AsyncObject.h"

@implementation AsyncObject

#pragma mark -
#pragma mark Async Helpers

-(void) postToEndpoint:(NSString *)endPoint withParams: (NSDictionary *)parameters onSuccess:(void (^)(id responseObject))success onFailure:(void (^)(NSError* error))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

    [manager POST:[[self endPoint] stringByAppendingString:endPoint] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {

        success(responseObject);

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

        failure(error);

    }];
}

-(void) putToEndpoint:(NSString *)endPoint withParams:(NSDictionary *)parameters onSuccess:(void (^)(id responseObject))success onFailure:(void (^)(NSError* error))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager PUT:[[self endPoint] stringByAppendingString:endPoint] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        success(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        failure(error);
        
    }];
}

-(void) delToEndpoint:(NSString *)endPoint withParams:(NSDictionary *)parameters onSuccess:(void (^)(id responseObject))success onFailure:(void (^)(NSError* error))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager DELETE:[[self endPoint] stringByAppendingString:endPoint] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        success(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        failure(error);
        
    }];
}

-(void) multipartPostToEndpoint:(NSString *)endPoint withData:(NSData *)data withName:(NSString *)name withFileName:(NSString *)fileName withMimeType:(NSString *)mimeType withParams: (NSDictionary *)parameters onSuccess:(void (^)(id responseObject))success onFailure:(void (^)(NSError* error))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager POST:[[self endPoint] stringByAppendingString:endPoint] parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData){
        
        [formData appendPartWithFileData:data name:name fileName:fileName mimeType:mimeType];
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
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

-(NSString *) endPoint
{
    Environment *myEnvironment = [Environment sharedInstance];
    return myEnvironment.URL;
}

@end
