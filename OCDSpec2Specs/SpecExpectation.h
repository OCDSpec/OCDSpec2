#import <Foundation/Foundation.h>

#import "OCDSIntExpectation.h"
#import "OCDSStringExpectation.h"

@interface SpecExpectation : NSObject

@end

#define ExpectErrorCount(num) [[[OCDSIntExpectation expectationInFile:__FILE__ line:__LINE__ failureReporter:self] withInt](num) toBe:Reporter.numberOfFailures]
#define ExpectLastWarningMessage(msg) [[[OCDSStringExpectation expectationInFile:__FILE__ line:__LINE__ failureReporter:self] withString](msg) toBeEqualTo:[Reporter findLastWarningMessageInFile:@(__FILE__)]]
#define ExpectLastErrorMessage(msg) [[[OCDSStringExpectation expectationInFile:__FILE__ line:__LINE__ failureReporter:self] withString](msg) toBeEqualTo:[Reporter findLastFailureMessageInFile:@(__FILE__)]]
#define ExpectLastErrorMessages(msgs) [[[OCDSArrayExpectation expectationInFile:__FILE__ line:__LINE__ failureReporter:self] withArray](msgs) toBeEqualTo:[Reporter findLastFailureMessagesInFile:@(__FILE__) count:[msgs count]]]