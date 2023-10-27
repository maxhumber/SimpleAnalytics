import XCTest
@testable import SwiftSimpleAnalytics

final class Swift_SimpleAnalyticsTests: XCTestCase {
    func testPageview() async throws {
        let tracker = SimpleAnalytics(hostname: "simpleanalyticsswift.app")
        await tracker.track(view: "test")
    }
    
    func testEvent() async throws {
        let tracker = SimpleAnalytics(hostname: "simpleanalyticsswift.app")
        await tracker.track(event: "test")
    }
}
