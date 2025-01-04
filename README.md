### SimpleAnalytics

Fork of [simpleanalytics/swift-package](https://github.com/simpleanalytics/swift-package)

#### Usage

Note: You'll need a [Simple Analytics](https://www.simpleanalytics.com/?referral=toveg) account to be able to use this package. When setting up a "website" just put in your unique bundle ID, something like: `come.yourdomain.mobileapp` (without `http://` or `https://`). Skip the HTML validation by clicking "I installed the script". 

In Xcode add the package dependency via `File` > `Add package dependency`:
`https://github.com/maxhumber/SimpleAnalytics.git`

Import the library and instantiate an instance:

```swift
import SimpleAnalytics
let sa = SimpleAnalytics(hostname: "com.yourdomain.mobileapp")
```

#### Tracking Page Views

```swift
simpleAnalytics.trackPageview(path: ["list"])
simpleAnalytics.trackPageview(path: ["detailview", "item1", "edit"])
```
#### Tracking Events

```swift
SimpleAnalytics.shared.track(event: "logged in")
SimpleAnalytics.shared.track(event: "logged in", path: ["login", "social"])
```
