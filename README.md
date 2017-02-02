# Giphy Demo App

## Description
GIFApp is a demo app making use of MVVM patterns and functional programming to display trending and searched for Gifs from [Giphy](https://github.com/Giphy/GiphyAPI)


## Third party libraries
Some of the third party libraries used:
For functional programming, [RxSwift and RxCocoa](https://github.com/ReactiveX/RxSwift)
For networking, [Moya](https://github.com/Moya/Moya)
For view layout, [SnapKit](https://github.com/SnapKit/SnapKit), which makes working with autolayout constraints a breeze.
For GIF caching, [Kingfisher](https://github.com/onevcat/Kingfisher)


## Useful resources
As I had not previously worked with RxSwift before, some of these resources helped me:

[Networking from RxSwift examples](https://github.com/ReactiveX/RxSwift/blob/master/RxExample/RxExample/Examples/GitHubSearchRepositories/GitHubSearchRepositoriesAPI.swift)

[Eidolon](https://github.com/Artsy/eidolon) an open source RxSwift app by the folks that make Moya.

[Droids on Roids](https://www.thedroidsonroids.com/blog/ios/rxswift-examples-3-networking/) a guide to networking in Swift 3 with RxSwift

## Setup
Assuming you have CocoaPods and Xcode installed, once you've downloaded the repo, navigate to the folder and type the following
```
pod install
open GIFApp.xcworkspace
```