#import "Model.h"

@implementation Model

-(id) initWithJson:(NSDictionary *)json
{
    self = [super init];
    if (self) {
        [self updateModelWithJson:json];
    }
    return self;
}

#pragma mark -
#pragma mark Initializers

-(void)updateModelWithJson:(NSDictionary *)json
{
    NSLog(@"[Model] updateModelWithJson: method not overriden. JSON data not being saved: %@", json);
}

-(void) addDetailsWithJson:(NSDictionary*)json
{
    [self updateModelWithJson:json];
}

@end
