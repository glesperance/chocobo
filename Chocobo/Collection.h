#import <Foundation/Foundation.h>
#import "AsyncObject.h"
#import "Model.h"

@interface Collection : AsyncObject <NSCopying>

@property (nonatomic, retain) NSMutableArray *models;

-(id) initWithJson:(NSDictionary*)json;
-(id) initWithModels:(NSDictionary *)models;
-(id)model;
-(NSString *) collectionEndpoint __attribute__((deprecated));
-(void)clearModels;
-(NSInteger)modelCount;
-(void)addModel:(id)model;
-(NSDictionary *)parse:(NSDictionary *) responseObject;
-(void)updateWithJson:(NSDictionary *)jsonCollection;
-(void)updateCollectionWithJson:(NSDictionary *)jsonCollection __attribute__((deprecated));
-(void)updateCollectionWithModels:(NSDictionary *)modelsJson;
@end
