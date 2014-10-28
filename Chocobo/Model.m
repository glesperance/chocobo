#import "Model.h"

@implementation Model

-(id) initWithJson:(NSDictionary *)json
{
    self = [super init];
    if (self) {
        [self updateWithJson:json];
    }
    return self;
}

-(void)updateModelWithJson:(NSDictionary *)json __attribute__((deprecated))
{
    [self updateWithJson:json];
}

-(void)save:(NSDictionary *)attributes
    success:(void(^)(id responseObject))success
    failure:(void (^)(NSError* error))failure
{
    // Save the old attributes
    NSMutableDictionary * oldAttributes = [[NSMutableDictionary alloc] init];
    for (id key in attributes) {
        [oldAttributes setObject:([self valueForKey:key] ? [self valueForKey:key] : [NSNull null])
                          forKey:key];
    }
    
    // set the new attributes
    [self setValuesForKeysWithDictionary:attributes];
    
    // Failure handler
    void (^failureHandler)(NSError* error) = ^(NSError *error) {
        // There was a failure saving the new attributes
        // ==> restore the old ones
        [self setValuesForKeysWithDictionary:oldAttributes];
        
        // Call the failure attribute if provided
        if (failure) failure(error);
    };
    
    // Issue a PUT request to update the model
    [self putToEndpoint:nil
             withParams:attributes
              onSuccess:success
              onFailure:failureHandler];
}

#pragma mark -
#pragma mark Initializers

-(void) addDetailsWithJson:(NSDictionary*)json
{
    [self updateWithJson:json];
}



@end
