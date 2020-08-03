# OpenJobs
## Requirements:
* iOS 13.0+
* Xcode 11.6
* Swift 5.2

## Objective:
This sample app to demonstrate some aspect of clean architecture using  MVVM pattern, RxSwift, dependency injection, **SOLID principles** , loose coupling, **unit testing** and some of the best practices used in modern iOS programming using `Swift`.

## App Goal:
* This project was intended to work as a  Job information demo projects for iOS using Swift. 
* The demo uses the [Jobs API](https://gist.githubusercontent.com/hadanischal/47ec8878164b7cdf7f66fe45092673fc/raw/9dd9e33e50bee5e2b9f40ba2bda95a67e6c7aa9a/jobs.json) which returns information in a JSON format.
* Use of UITableViewController to display Jobs information.
* Implemented Unit test for business logic
* Persistent data using **Core Data**
* Use of **RxSwift** for Reactive programming.

## Installation
- Xcode **11.6**(required)
- Clean `/DerivedData` folder if any
- Run setup script file 
  - `./setup.sh`

- Or if you prefer follow following step
  - pod install `pod install`
  - Run Cuckoo script to Mock your Swift objects `./Cuckoo-GeneratedMocks.sh`
  - Run SwiftGen script to generator Swift code for assets, Localizable.strings etc `./generate-swiftgen.sh`
- Then clean and build the project in Xcode

## 3rd Party Libraries
 - **`RxSwift`** - [ReactiveX/RxSwift](https://github.com/ReactiveX/RxSwift) is  used to make `Reactive` binding of API call and response
 - **`Kingfisher`** - [onevcat/Kingfisher](https://github.com/onevcat/Kingfisher) for downloading and caching images from the web.
 - **`PKHUD`** - [pkluz/PKHUD](https://github.com/pkluz/PKHUD) to show loading activity indicator
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
- MVVM - My preferred architecture.
    - MVVM stands for “Model View ViewModel”
    - It’s a software architecture often used by Apple developers to replace MVC. Model-View-ViewModel (MVVM) is a structural design pattern that separates objects into three distinct groups:
- Models hold application data. They’re usually structs or simple classes.
- Views display visual elements and controls on the screen. They’re typically - subclasses of UIView.
- View models transform model information into values that can be displayed on a view. They’re usually classes, so they can be passed around as references.

![Alt text](/README/MVVM.jpeg?raw=true)


## Screenshot:
* The first tab is the **Open Jobs** tab, which contains all **Open Jobs**.
* The second tab is the **Closed Jobs** tab, which contains all **Closed Jobs**.

![Screen Shot 1](/README/screenshot1.png?raw=true)


![Screen Shot 2](/README/screenshot2.png?raw=true)

 #### App Demo

 ![](/README/demo.gif "")
