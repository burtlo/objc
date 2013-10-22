# Objc

This gem is a test suite runner for Objective-C files to allow for the easy
execution of a test suite without the hassle of managing an Xcode Project File

## Installation

Install the gem

    $ gem install objc

Install [xctool](https://github.com/facebook/xctool)

    $ brew install xctool

## Usage

    $ objc Anagram

The `objc` binary will find and run the tests for the following files: `Anagram.h`,
`Anagram.m` and `AnagramTest.m`.

More specifically the following occurs:

* Finds the files matching the specified prefix (e.g. `Anagram.h`,
  `Anagram.m` and `AnagramTest.m`)
* An Xcode Project, managed by the gem, is copied to to a tmp location on the
  system.
* Using the [xcoder](https://github.com/rayh/xcoder) the project file is
  manipulated and the found files are added.
* Using [xctool](https://github.com/facebook/xctool) the tests from the
  project file are executed.

## XCTest

The test suite used is **XCTest**. This is an example of the header, source
and test file.

### Anagram.h

```
#import <Foundation/Foundation.h>

@interface Anagram : NSObject

- (id)initWithString:(NSString *)string;
- (NSArray *)match:(NSArray *)possibleMatches;

@end
```

### Anagram.m

```
#import "Anagram.h"

@implementation Anagram

- (id)initWithString:(NSString *)string {
    return [super init];
}

- (NSArray *)match:(NSArray *)possibleMatches {
    return @[];
}

@end
```

### AnagramTest.m

```
#import <XCTest/XCTest.h>
#import "Anagram.h"

@interface test_suite : XCTestCase

@end

@implementation test_suite

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testNoMatches {
    Anagram *detector = [[Anagram alloc] initWithString:@"diaper"];
    NSArray *matches = [detector match:@[@"hello",@"world",@"zombies",@"patns"]];

    XCTAssertEqual(@[], matches, @"Format");
}

@end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
