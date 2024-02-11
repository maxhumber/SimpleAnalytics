# Simple Analytics Swift Package
Swift package for [Simple Analytics](https://www.simpleanalytics.com/?referral=roel-van-der-kraan). Add privacy friendly analytics to your iOS apps. Currently in development. This is an alpha version, everything might change.

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fsimpleanalytics%2Fswift-package%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/simpleanalytics/swift-package)

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fsimpleanalytics%2Fswift-package%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/simpleanalytics/swift-package)

## Installation
When using Xcode to add the package dependency add this repository via `File` > `Add package dependency`:
`https://github.com/simpleanalytics/swift-package.git`

Or when working with a package manifest use:
```swift
.package(url: "https://github.com/simpleanalytics/swift-package.git", from: "0.3.0")
```

## Usage
You'll need a Simple Analytics account to be able to use this package. See [Simple Analytics](https://www.simpleanalytics.com/?referral=roel-van-der-kraan) for more info.

Import the library:
```swift
import SimpleAnalytics
```

You will need the hostname of a Simple Analytics website to start an instance of `SimpleAnalytics` in your app. You can add a fake "website" to Simple Analytics specifically for your app. There is no need to point to a real server. You can use something like `mobileapp.yourdomain.com`. Skip the HTML validation by clicking "I installed the script". 
⚠️ Make sure the hostname you set in Swift matches the website domain name in Simple Analytics (without http:// or https://).
```swift
let simpleAnalytics = SimpleAnalytics(hostname: "mobileapp.yourdomain.com")
```

You can create an instance where you need it, or you can make an extension and use it as a static class.
```swift
import SimpleAnalytics

extension SimpleAnalytics {
    static let shared: SimpleAnalytics = SimpleAnalytics(hostname: "mobileapp.yourdomain.com")
}
```

## Tracking
You can call the tracking functions from anywhere in your app.
### Tracking Pageviews
Use pageviews to track screens in your app.
```swift
SimpleAnalytics.shared.track(path: ["list"])
```
To represent a hierarchy in your views, add every level as an entry in the path array:
```swift
SimpleAnalytics.shared.track(path: ["detailview", "item1", "edit"])
```
This will be converted to a pageview on `/detailview/item1/edit` on Simple Analytics.

### Tracking Events
Use events to track interactions or noticable events like errors or success on a page.
```swift
SimpleAnalytics.shared.track(event: "logged in")
```
You can provide an optional path to track alongside the event.
```swift
SimpleAnalytics.shared.track(event: "logged in", path: ["login", "social"])
```

### Tracking Visitors for Apps + Widgets
If you have an app + widget(s), by default, these are treated as separate 'visitors'. However, you can prevent one visitor from appearing multiple times by creating an App Group in your Xcode project in each of your targets (Project > Targets > Signing & Capabilities > App Groups) with the same name. Use this app group name in your SimpleAnalytics instance.
```swift
let simpleAnalytics = SimpleAnalytics(hostname: "app.simpleanalytics.com", sharedDefaultsSuiteName: "com.simpleanlytics.app")
```

## Examples
### SwiftUI example
 In SwiftUI, a good place to put the Pageview tracking code is in your view `.onAppear{}` modifier. 
```swift
import SwiftUI
import SimpleAnalytics

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
            SimpleAnalytics.shared.track(path: ["example"])
        }
    }
}
```

### UIKit example
When using UIKit, you can put Pageview tracking in `viewDidAppear()`
```swift
import UIKit
import SimpleAnalytics

class ExampleViewController: UITableViewController {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        SimpleAnalytics.shared.track(path: ["example"])
    }
}
```
