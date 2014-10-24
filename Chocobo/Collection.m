#import "Collection.h"
#import <objc/runtime.h>

@implementation Collection

@synthesize models = _models;

-(id) initWithJson:(NSDictionary *)json
{
    self = [super init];
    if (self) {
        [self updateWithJson:json];
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
    return [self endPoint];
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

-(void)updateCollectionWithJson:(NSDictionary *)jsonCollection __attribute__((deprecated))
{
    [self updateWithJson:jsonCollection];
}

-(void)updateWithJson:(NSDictionary *)jsonCollection
{
    // Maintain backward compatibility with subclasses of Collection that
    // implemented a updateCollectionWithJson instead of updateWithJson
    if (class_getMethodImplementation(self.class, @selector(updateCollectionWithJson:)) != class_getMethodImplementation(Collection.class, @selector(updateCollectionWithJson:))) {
        NSLog(@"!!! ChocoboSubclassingWarning: %@ should override `updateWithJson` method instead of deprecated `updateCollectionWithJson` method", NSStringFromClass(self.class));
        
        [self performSelector:@selector(updateCollectionWithJson:) withObject:jsonCollection];
        return;
    }
    
    NSDictionary *parsedModelsJson = [self parse:jsonCollection];
    [self updateCollectionWithModels:parsedModelsJson];
}

-(void) fetchWithParams:(NSDictionary *)params onSuccess:(void (^)(id responseObject))success onFailure:(void (^)(NSError* error))failure
{
    [self clearModels];
    [super fetchWithParams:params onSuccess:success onFailure:failure];
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
