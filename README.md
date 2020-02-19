# OpenJobs
## Requirements:
* iOS 12.0+
* Xcode 11.3.1
* Swift 5.0

## Objective:
This is a simple Demo project which aims to demonstrate some examples of MVVM pattern + RxSwift in Swift using  **clean architecture**, **SOLID principles** code organisation, loose coupling, **unit testing** and some of the best practices used in modern iOS programming using `Swift`.

App Goal:
* This project was intended to work as a  Job information demo projects for iOS using Swift. 
* The demo uses the [Jobs API](https://gist.githubusercontent.com/hadanischal/47ec8878164b7cdf7f66fe45092673fc/raw/9dd9e33e50bee5e2b9f40ba2bda95a67e6c7aa9a/jobs.json) since it is well-maintained API which returns information in a JSON format.
* The goal is to create a Jobs Feed app which gives a user regularly-updated jobs from the internet related to a particular topic, person, or location.
* Use of UITableViewController to display Jobs information.
* Implemented Unit test for business logic
* Persistent data using core data

## Implementation:
 - For job list, app polls the following URL: [Jobs API](https://gist.githubusercontent.com/hadanischal/47ec8878164b7cdf7f66fe45092673fc/raw/9dd9e33e50bee5e2b9f40ba2bda95a67e6c7aa9a/jobs.json) 
 - This will return jobs list in JSON format. For more information [API documentation](https://gist.github.com/hadanischal/47ec8878164b7cdf7f66fe45092673fc)
 - It Persistent data using core data.

## Installation

- Xcode **11.3**(required)
- Clean `/DerivedData` folder if any
- Run the pod install `pod install`
- Run Cuckoo script to Mock your Swift objects `./Cuckoo-GeneratedMocks.sh`
- Run SwiftGen script to generator Swift code for assets, Localizable.strings etc `./generate-swiftgen.sh`
- Then clean and build the project in Xcode

## 3rd Party Libraries
 - **`RxSwift`** - [ReactiveX/RxSwift](https://github.com/ReactiveX/RxSwift) is  used to make `Reactive` binding of API call and response
 - **`Kingfisher`** - [onevcat/Kingfisher](https://github.com/onevcat/Kingfisher) for downloading and caching images from the web.
 - **`Segmentio`** - [Yalantis/Segmentio](https://github.com/Yalantis/Segmentio) Animated custom segmented control
 - **`NewPopMenu`** - [CaliCastle/PopMenu](https://github.com/CaliCastle/PopMenu) customizable popup style menu for iOS
 - **`CocoaLumberjack`** - [CocoaLumberjack/CocoaLumberjack](https://github.com/CocoaLumberjack/CocoaLumberjack) logging framework for Mac and iOS
 - **`SwiftLint`** - [realm/SwiftLint](https://github.com/realm/SwiftLint) A tool to enforce Swift style and conventions. 
 - **`Pecker`** - [woshiccm/Pecker](https://github.com/woshiccm/Pecker) Pecker is a tool to automatically detect unused Swift code.
 - **`SwiftGen`** - [SwiftGen/SwiftGen](https://github.com/SwiftGen/SwiftGen) swift code generator for your assets, storyboards, Localizable.strings. 
 - **`Quick`** - [Quick/Quick](https://github.com/Quick/Quick) is testing framework in swift
 - **`Nimble`** - [Quick/Nimble](https://github.com/Quick/Nimble) is Matcher Framework for Swift to pair with Quick
 - **`Cuckoo`** - [Brightify/Cuckoo](https://github.com/Brightify/Cuckoo) is tasty mocking framework for unit tests in swift

## Design patterns:
### MVVM:
MVVM stands for “Model View ViewModel”, and it’s a software architecture often used by Apple developers to replace MVC. Model-View-ViewModel (MVVM) is a structural design pattern that separates objects into three distinct groups:
- Models hold application data. They’re usually structs or simple classes.
- Views display visual elements and controls on the screen. They’re typically - subclasses of UIView.
- View models transform model information into values that can be displayed on a view. They’re usually classes, so they can be passed around as references.

![Alt text](/ScreenShots/MVVM.jpeg?raw=true)

![Alt text](/ScreenShots/MVVM_Diagram.png?raw=true)

 #### App Demo

* The first tab is the **Open Jobs** tab, which contains all **Open Jobs**.
* The second tab is the **Closed Jobs** tab, which contains all **Closed Jobs**.

 ![](/ScreenShots/openjob.gif "")

