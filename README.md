
# README #

## Prerequisites ##

* iOS 8+
* Latest version of Xcode

## Instructions ##

* Open App.xcodeproj. When open press run using a simulator or device.

* Find OAuthAttributes and add the keys and secrets, remember to fix the tests

* Run the test using CMD + U

* The project has one view controller called TweetListViewController that shows a list of tweets being tracked. Wait until tweets are shown if nothing is shown in next 30 seconds you will have a chance to retry.

* Unit tests are done with XCTest. The test covearage is 97.4% However, there could be code "tested" but still missing valid use cases. 

* The only third party libraries are RxSwift and RxCocoa and the code is written using the below coding standards

## Coding standards ##

### Naming ###

* Use descriptive names with camelcase for classes, methods, variables, etc. Classes should be capitalized while method names should start with lowercase 

### Spacing ###

* Method braces always open in the same line
* Use one space separation between any operators for clarity

### Code Separation ###

* Use //MARK: - to make navigating the code easier

### Conditionals ###

* Conditionals bodies should always be in braces

### Ternary Operator ###

* Should only be used when increases clarity

### Methods ###

* There should be an space between method arguments

### Extensions naming ###

* ClassName+Functionality

### Protocols ###

* Declare all protocols in its own file
* File should have the same name as the protocol

### Use of self ###

* Avoid using self since Swift doesn’t require it to access objects or methods

### Completion blocks ###

* Don't include their definition unless is necessary e.g () -> () in remove () -> ()

### Types ###

* Try to use native types when available

### Type inference ###

* Let the compiler infer the type for a constant or variable unless you need to specify a type

### Semicolons ###

* No need to use them, you should not have two statements in the same line

### Code header comments ###

* Should be removed as the code belongs to the team not to the person the has created the class

### Other considerations ###

* Keep it simple
* Keep classes and methods short
* No comments (the code should be self explanatory)

## Project structure ##

* Classes
* * AppDelegate
* * Utils
* * Vendors 
* * Model
* * * Domain
* * * Services 
* * Controllers
* * * ViewControllers (Storyboards)
* * * Views 
* * Resources
* * * Images, fonts, strings, plists, etc

### Folders ###

* Create class folders in finder and drag them to Xcode

### Configs ###

* Configuration driven by xcconfigs

## Unit Testing ##

* Unit testing is done using XCTest

