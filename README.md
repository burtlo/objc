# Objc

This gem is a test suite runner for Objective-C files to allow for the easy
execution of a test suite without the hassle of managing an Xcode Project File

## Installation

Install the gem

    $ gem install objc

Install [xctool](https://github.com/facebook/xctool)

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

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
