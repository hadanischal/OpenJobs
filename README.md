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

## Instructions:
* The first tab you need to create is the **Open Jobs** tab, which contains all **Open Jobs**.
![Invited Tab](https://s3-ap-southeast-2.amazonaws.com/hipgrp-assets/tech-test/mob/open-jobs.png "Open Jobs")

* Assets **hipgrp-assets**.
![assets](https://s3-ap-southeast-2.amazonaws.com/hipgrp-assets/tech-test/mob/menu-open.png "assets")

An iOS template project implementing MVVM pattern in Swift around a currency exchange rate app.

Related to that project, I shared my approach in an article how to implement an MVVM pattern: https://benoitpasquier.com/ios-swift-mvvm-pattern/

I recently added unit testing for a MVVM architecture: https://benoitpasquier.com/unit-test-swift-mvvm-pattern/

A RxSwift version is available under rxswift branch: https://benoitpasquier.com/integrate-rxswift-in-mvvm/