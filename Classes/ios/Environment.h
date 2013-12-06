#import <Foundation/Foundation.h>

@interface Environment : NSObject

@property (nonatomic, retain) NSString *URL;

+ (Environment *)sharedInstance;

@end
