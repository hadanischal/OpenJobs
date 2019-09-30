# OpenJobs
## Requirements:
* iOS 12.0+
* Xcode 10.3
* Swift 5.0

## Compatibility
This demo is expected to be run using Swift 5.0 and Xcode 10.3

## Objective:
This is a simple Demo project which aims to display Job information using MVVM pattern + RxSwift in Swift.
* This project was intended to work as a  Job information demo projects for iOS using Swift. 
* The demo uses the [Jobs API](https://s3-ap-southeast-2.amazonaws.com/hipgrp-assets/tech-test/jobs.json) since it is well-maintained API which returns information in a JSON format.
* The goal is to create a Jobs Feed app which gives a user regularly-updated jobs from the internet related to a particular topic, person, or location.
* Use of UITableViewController to display Jobs information.
* Implemented Unit test for business logic
* Persistent data using core data

## Design patterns:
### MVVM:
MVVM stands for Model,View,ViewModel in which controllers, views and animations take place in View and Business logics, api calls take place in ViewModel. In fact this layer is interface between model and View and its going to provide data to View as it wants. 

![Alt text](/ScreenShots/MVVM.jpeg?raw=true)

### RxSwift:
One of the MVVM’s features is binding of data and view, which makes it pleasant with RxSwift.We can do this with delegate,KVO or closures as well. [ReactiveX/RxSwift](https://github.com/ReactiveX/RxSwift). 


## Implementations:

### Test Frameworks:
There is a lot of test framework that helps us to write test cases easily and we should add them into application dependencies:

#### Cuckoo
A mocking framework for unit tests. We should write test cases in isolation because we need to develop just one method without consideration about other methods and their functionalities. Mockito helps us to create a stub (mock) from other objects. Github link for [Brightify/Cuckoo](https://github.com/Brightify/Cuckoo). It is very similar to Mockito, so anyone using it in Java/Android can immediately pick it up and use it.

#### Nimble
Provides a fluent interface for writing assertions. Nimble help us to check conditions in unit tests and Nimble is the lovely one, with good syntax and various assert methods.
Nimble allows us to express expectations using a natural, easily understood language. Github link for [Quick/Nimble](https://github.com/Quick/Nimble).

#### Quick
Quick is a behavior-driven development framework for Swift and Objective-C. Inspired by RSpec, Specta, and Ginkgo. Github link for [Quick/Quick](https://github.com/Quick/Quick).




## Instructions:
* The first tab you need to create is the **Open Jobs** tab, which contains all **Open Jobs**.
![Invited Tab](https://s3-ap-southeast-2.amazonaws.com/hipgrp-assets/tech-test/mob/open-jobs.png "Open Jobs")


* The second tab you need to create is the **Closed Jobs** tab, which contains all **Closed Jobs**.
![Invited Tab](https://s3-ap-southeast-2.amazonaws.com/hipgrp-assets/tech-test/mob/menu-open.png "Menu Open")
