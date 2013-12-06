#import "Environment.h"

@implementation Environment

static Environment *sharedInstance = nil;

@synthesize URL;

- (id)init
{
    self = [super init];

    if (self) {
    }

    return self;
}

+ (Environment *)sharedInstance
{
    @synchronized(self) {
        if (sharedInstance == nil) {
            sharedInstance = [[self alloc] init];
            [sharedInstance initializeSharedInstance];
        }
        return sharedInstance;
    }
}

- (void)initializeSharedInstance
{
    NSString* configuration = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"Configuration"];
    NSBundle* bundle = [NSBundle mainBundle];
    NSString* envsPListPath = [bundle pathForResource:@
                               "Environments" ofType:@"plist"];
    NSDictionary* environments = [[NSDictionary alloc] initWithContentsOfFile:envsPListPath];
    NSDictionary* environment = [environments objectForKey:configuration];

    self.URL = [environment valueForKey:@"URL"];
}

@end
