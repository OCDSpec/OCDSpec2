#import <Foundation/Foundation.h>

#import "OCDSLogger.h"

@interface OCDSDescription : NSObject

@property (strong, retain) NSArray *subDescriptions;
@property (strong, retain) NSString *name;
@property (strong, retain) NSArray *examples;
@property (strong, retain) NSObject<OCDSLogger> *logger;

@property (copy) void (^beforeEachBlock)(void);
@property (copy) void (^afterEachBlock)(void);

-(id) initWithLogger:(NSObject<OCDSLogger> *) logger;
-(void) runAll;
-(void) runAllExamplesWithBeforeBlocks:(NSArray *) beforeBlocks afterBlocks:(NSArray *) afterBlocks;

-(NSString *) logMessage:(NSString *)exampleName;

@end
