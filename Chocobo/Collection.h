#import <Foundation/Foundation.h>
#import "AsyncObject.h"
#import "Model.h"

@interface Collection : AsyncObject

@property (nonatomic, retain) NSMutableArray *models;
-(id) initWithJson:(NSDictionary*)json;
-(id) initWithModels:(NSDictionary *)models;
-(id)model;
-(NSString *) collectionEndpoint;
-(void) fetchWithParams:(NSDictionary *)params onSuccess:(void (^)(id responseObject))success onFailure:(void (^)(NSError* error))failure;
-(void)clearModels;
-(NSInteger)modelCount;
-(void)addModel:(id)model;
-(NSDictionary *)parse:(NSDictionary *) responseObject;
-(void)updateCollectionWithJson:(NSDictionary *)jsonCollection;
-(void)updateCollectionWithModels:(NSDictionary *)modelsJson;
@end
