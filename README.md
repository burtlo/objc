# Objc

This gem is a test suite runner for Objective-C files to allow for the easy
execution of a test suite without the hassle of managing an Xcode Project File

## Installation

Install the gem

    $ gem install objc

Install [xctool](https://github.com/facebook/xctool)

    $ brew install xctool

## Usage

    $ objc Bob

The `objc` binary will find and run the tests for the following files: `Bob.h`,
`Bob.m` and `BobTest.m`.

More specifically the following occurs:

* Finds the files matching the specified prefix (e.g. `Bob.h`,
  `Bob.m` and `BobTest.m`)
* An Xcode Project, managed by the gem, is copied to to a tmp location on the
  system.
* Using the [xcoder](https://github.com/rayh/xcoder) the project file is
  manipulated and the found files are added.
* Using [xctool](https://github.com/facebook/xctool) the tests from the
  project file are executed.

## XCTest

The test suite used is **XCTest**. This is an example of the header, source
and test file.

### Bob.h

```
#import <Foundation/Foundation.h>

@interface Bob : NSObject

- (NSString *)hey:(NSString *)statement;

@end
```

### Bob.m

```
#import "Bob.h"

@implementation Bob

-(NSString *)hey:(NSString *)statement {

  if ([statement isEqualToString:@""]) {
    return @"Fine, be that way.";
  } else if ([statement hasSuffix:@"?"]) {
    return @"Sure.";
  } else if ([statement isEqualToString:[statement uppercaseString]]) {
    return @"Woah, chill out!";
  } else {
    return @"Whatever.";
  }

}

@end
```

### BobTest.m

```
#import <XCTest/XCTest.h>
#import "Bob.h"

@interface test_suite : XCTestCase

@end

@implementation test_suite

- (Bob *)bob {
  return [[Bob alloc] init];
}

- (void)testStatingSomething {
  NSString *input = @"Tom-ay-to, tom-aaaah-to.";
  NSString *expected = @"Whatever.";
  NSString *result = [[self bob] hey:input];
  XCTAssertEqual(expected,result);
}

- (void)testShouting {
  NSString *input = @"WATCH OUT!";
  NSString *expected = @"Woah, chill out!";
  NSString *result = [[self bob] hey:input];
  XCTAssertEqual(expected,result);
}

- (void)testAskingAQuestion {
  NSString *input = @"Does this cryogenic chamber make me look fat?";
  NSString *expected = @"Sure.";
  NSString *result = [[self bob] hey:input];
  XCTAssertEqual(expected,result);
}

- (void)testTalkingForcefully {
  NSString *input = @"Let's go make out behind the gym!";
  NSString *expected = @"Whatever.";
  NSString *result = [[self bob] hey:input];
  XCTAssertEqual(expected,result);
}

- (void)testShoutingNumbers {
  NSString *input = @"1, 2, 3 GO!";
  NSString *expected = @"Woah, chill out!";
  NSString *result = [[self bob] hey:input];
  XCTAssertEqual(expected,result);
}

- (void)testShoutingWithSpecialCharacters {
  NSString *input = @"ZOMG THE %^*@#$(*^ ZOMBIES ARE COMING!!11!!1!";
  NSString *expected = @"Woah, chill out!";
  NSString *result = [[self bob] hey:input];
  XCTAssertEqual(expected,result);
}

- (void)testSilence {
  NSString *input = @"";
  NSString *expected = @"Fine, be that way.";
  NSString *result = [[self bob] hey:input];
  XCTAssertEqual(expected,result);
}

@end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
