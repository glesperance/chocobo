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

#pragma mark -
#pragma mark Initializers

-(void) addDetailsWithJson:(NSDictionary*)json
{
    [self updateWithJson:json];
}

@end
