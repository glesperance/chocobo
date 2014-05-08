#import "Collection.h"

@implementation Collection

@synthesize models = _models;

-(id) initWithJson:(NSDictionary *)json
{
    self = [super init];
    if (self) {
        [self updateCollectionWithJson:json];
    }
    return self;
}

-(id)model
{
    NSLog(@"[Collectionb] model: method not overriden.");
    return nil;
}

-(NSMutableArray *)models
{
    if (!_models)
        _models = [[NSMutableArray alloc] init];
    return _models;
}

-(NSString *) collectionEndpoint
{
    NSLog(@"[Collection] collectionEndpoint: method not overriden");
    return nil;
}

-(void)clearModels
{
    [self.models removeAllObjects];
}

-(NSInteger)modelCount
{
    return [self.models count];
}

-(void)addModel:(id)model
{
    [self.models addObject:model];
}

-(NSDictionary *)parse:(NSDictionary *)responseObject
{
    return responseObject;
}

-(void)updateCollectionWithJson:(NSDictionary *)jsonCollection
{
    for (NSDictionary* model in jsonCollection) {
        Class modelClass = NSClassFromString([self model]);
        id modelObject = [(Model *)[modelClass alloc] initWithJson:modelObject];
        // add the object to the model group
        [self.models addObject:modelObject];
    }
}

-(void) fetchWithParams:(NSDictionary *)params onSuccess:(void (^)(id responseObject))success onFailure:(void (^)(NSError* error))failure
{
    [self clearModels];
    [self getFromEndpoint:[self collectionEndpoint] withParams:params onSuccess:^(id responseObject) {
        NSDictionary *attributes = [self parse:responseObject];
        
        [self updateCollectionWithJson:attributes];
        
        success(responseObject);

    } onFailure:^(NSError *error) {

        failure(error);

    }];
}

@end
