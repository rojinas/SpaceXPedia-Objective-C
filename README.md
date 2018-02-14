SpaceXpedia

App that makes use of SpaceX public APIs to show various stats about Rocket, Capsule, Launch dates.

Code is broken down to smaller tasks. Can serve a starter project for anyone who wants to learn iOS programming.

High level Design:
- Contains 4 tab bars: Rocket, Capsule, Upcoming launches & Past launches
- All tabs display data in UITableViewContorller
- Rocket tab makes use of a custom datamodel (RocketModel), all other tabs use generalized NSDictionary to render the content
- RocketModel makes use of 'JSONModel' framework to parse JSON response to Model
- I used only few fields in RocketModel to demonstrate the proof of concept
- Notice the use of Auto-layout to compute dynamic height of the table cell and the height of Description UILabel
- Implemented 'Pull to refresh' in the first tab (Rocket Data)
- Wrote a method to flatten JSON/NSDictionary and display it ( 2nd ,3rd and 4th tabs)
- Used a custom Parent class to define all commonly used methods eg to show error, display/hide busy indicator
- Display error banner at top using a library via Cocoapod

Regarding API calls:
- I implemented http request calls using NSURLSession. Could have used AFNetworking, but wanted to demonstrate some usage.
- There is a Service Layer (SpaceXApiService) that acts as a bridge between the controllers and the actual API calls.
This allows us to maintain all API related code in one place, and define a consistent way of making these calls. Looks much cleaner.
- Added some error handling cases, like if returned data is empty or if there is any issue with the HTTP request or network issues

Unit Test:
- Added a test to ensure JSON to Model conversion is working as expected.
- Loaded a static JSON file and checked multiple parameters, code is pretty verbose and it is well explained.

Other improvements:
- Added few comments on few source files, but not on all files. There are simply many files, this requires more time.
- Will be writing this same project in Swift and also for Android. Just for fun.
- Better unit test coverage
