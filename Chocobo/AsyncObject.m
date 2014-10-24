#import "AsyncObject.h"
#import "Collection.h"
#import "Model.h"

#import <objc/runtime.h>

@implementation AsyncObject

#pragma mark -
#pragma mark Async Helpers

-(void) updateWithJson:(NSDictionary *)json
{
    // Maintain backward compatibility with subclasses of Model that
    // implemented a updateModelWithJson instead of updateWithJson
    if ([self.class isSubclassOfClass:Model.class]) {
        if (class_getMethodImplementation(self.class, @selector(updateModelWithJson:)) != class_getMethodImplementation(Model.class, @selector(updateModelWithJson:))) {
            NSLog(@"!!! ChocoboSubclassingWarning: %@ should override `updateWithJson` method instead of deprecated `updateModelWithJson` method", NSStringFromClass(self.class));
            
            [self performSelector:@selector(updateModelWithJson:) withObject:json];
            return;
        }
    }
    
    [NSException raise:@"ChocoboSubclassingError" format:@"AsyncObject subclass %@ must override `updateWithJson` method", NSStringFromClass(self.class)];
}

-(NSString *) endPoint
{
    // Maintain backward compatibility with subclasses of Collection that
    // implemented a collectionEndpoint instead of endPoint
    if ([self.class isSubclassOfClass:Collection.class]) {
        
        // Make sure we aren't simply calling our own deprecated method
        if (class_getMethodImplementation(self.class, @selector(collectionEndpoint)) != class_getMethodImplementation(Collection.class, @selector(collectionEndpoint)))
        {
            NSLog(@"!!! ChocoboSubclassingWarning: %@ should override `endPoint` method instead of deprecated `collectionEndpoint` method", NSStringFromClass(self.class));
            return [self performSelector:@selector(collectionEndpoint)];
        }
    }
    
    [NSException raise:@"AsyncObject subclass must override `endPoint` method" format:nil];
    return nil;
}

-(void) postToEndpoint:(NSString *)endPoint withParams: (NSDictionary *)parameters onSuccess:(void (^)(id responseObject))success onFailure:(void (^)(NSError* error))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

    [manager POST:[[self appEndPoint] stringByAppendingString:endPoint] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {

        success(responseObject);

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

        failure(error);

    }];
}

-(void) putToEndpoint:(NSString *)endPoint withParams:(NSDictionary *)parameters onSuccess:(void (^)(id responseObject))success onFailure:(void (^)(NSError* error))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager PUT:[[self appEndPoint] stringByAppendingString:endPoint] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        success(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        failure(error);
        
    }];
}

-(void) delToEndpoint:(NSString *)endPoint withParams:(NSDictionary *)parameters onSuccess:(void (^)(id responseObject))success onFailure:(void (^)(NSError* error))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager DELETE:[[self appEndPoint] stringByAppendingString:endPoint] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        success(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        failure(error);
        
    }];
}

-(void) multipartPostToEndpoint:(NSString *)endPoint withData:(NSData *)data withName:(NSString *)name withFileName:(NSString *)fileName withMimeType:(NSString *)mimeType withParams: (NSDictionary *)parameters onSuccess:(void (^)(id responseObject))success onFailure:(void (^)(NSError* error))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager POST:[[self appEndPoint] stringByAppendingString:endPoint] parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData){
        
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

    [manager GET:[[self appEndPoint] stringByAppendingString:endPoint] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {

        success(responseObject);

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

        failure(error);

    }];
}

-(void) fetchWithParams:(NSDictionary *)params onSuccess:(void (^)(id responseObject))success onFailure:(void (^)(NSError* error))failure
{
    [self getFromEndpoint:[self endPoint] withParams:params onSuccess:^(id responseObject) {
        
        [self updateWithJson:responseObject];
        success(responseObject);
        
    } onFailure:^(NSError *error) {
        if (failure) failure(error);
    }];
}

-(NSString *) appEndPoint
{
    Environment *myEnvironment = [Environment sharedInstance];
    return myEnvironment.URL;
}

@end
