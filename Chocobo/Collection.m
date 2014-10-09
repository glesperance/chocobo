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
-(id) initWithModels:(NSDictionary *)models
{
    self = [super init];
    if (self) {
        [self updateCollectionWithModels:models];
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

-(void)addModel:(Model *)model
{
    model.collection = self;
    [self.models addObject:model];
}

-(NSDictionary *)parse:(NSDictionary *)responseObject
{
    return responseObject;
}

-(void)updateCollectionWithModels:(NSDictionary *)modelsJson
{
    for (NSDictionary* model in modelsJson) {
        Class modelClass = NSClassFromString([self model]);
        id modelObject = [(Model *)[modelClass alloc] initWithJson:model];
        // add the object to the model group
        [self addModel:modelObject];
    }
}

-(void)updateCollectionWithJson:(NSDictionary *)jsonCollection
{
    NSDictionary *parsedModelsJson = [self parse:jsonCollection];
    [self updateCollectionWithModels:parsedModelsJson];
}

-(void) fetchWithParams:(NSDictionary *)params onSuccess:(void (^)(id responseObject))success onFailure:(void (^)(NSError* error))failure
{
    [self clearModels];
    [self getFromEndpoint:[self collectionEndpoint] withParams:params onSuccess:^(id responseObject) {
        
        [self updateCollectionWithJson:responseObject];
        success(responseObject);
        
    } onFailure:^(NSError *error) {

        failure(error);

    }];
}

- (id)copyWithZone:(NSZone *)zone
{
    Collection * clone = [[self.class allocWithZone:zone] init];
    clone.models = [[NSMutableArray allocWithZone:zone] initWithArray:self.models
                                                            copyItems:YES];
    
    for (Model * model in clone.models) {
        model.collection = clone;
    }
    
    return clone;
}

@end
