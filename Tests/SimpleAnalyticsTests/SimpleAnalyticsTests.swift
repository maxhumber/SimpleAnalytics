import Foundation
import Testing
@testable import SimpleAnalytics

/// Tests for Swift SimpleAnalytics
/// You can see logged pageviews with these tests on this SimpleAnalytics page: https://dashboard.simpleanalytics.com/simpleanalyticsswift.app
struct SimpleAnalyticsTests {
    @Test func trackerSetup() throws {
        let tracker = SimpleAnalytics(hostname: "simpleanalyticsswift.app")
        #expect(tracker.hostname == "simpleanalyticsswift.app")
    }
    
    @Test func pageview() async throws {
        await confirmation("Test pageview") { done in
            let tracker = SimpleAnalytics(hostname: "simpleanalyticsswift.app")
            do {
                try await tracker.trackPageview(path: ["test"])
                done()
            } catch {
                Issue.record("Failed to log a pageview: \(error)")
            }
        }
    }
    
    @Test func pageviewWithMetadata() async throws {
        await confirmation("Log a pageview") { done in
            let tracker = SimpleAnalytics(hostname: "simpleanalyticsswift.app")
            let metadata: [String: CustomStringConvertible] = ["plan": "premium", "meta": "data", "date": "2024-01-24T11:29:35.123Z", "number": 834710, "bool": true]
            do {
                try await tracker.trackPageview(path: ["testmetadata"], metadata: metadata)
                done()
            } catch {
                Issue.record("Failed to log pageview with metadata: \(error)")
            }
        }
    }
    
    @Test func event() async throws {
        await confirmation("Log an event") { done in
            let tracker = SimpleAnalytics(hostname: "simpleanalyticsswift.app")
            do {
                try await tracker.trackEvent(event: "test event")
                done()
            } catch {
                Issue.record("Failed to log event: \(error)")
            }
        }
    }
    
    @Test func eventWithMetadata() async throws {
        await confirmation("Log an event with metadata") { done in
            let tracker = SimpleAnalytics(hostname: "simpleanalyticsswift.app")
            let metadata: [String: CustomStringConvertible] = ["plan": "premium", "meta": "data", "date": "2024-01-24T11:29:35.123Z", "number": 834710, "bool": true]
            do {
                try await tracker.trackEvent(event: "test event metadata", metadata: metadata)
                done()
            } catch {
                Issue.record("Failed to log event with metadata: \(error)")
            }
        }
    }
    
    @Test func eventWithPath() async throws {
        await confirmation("Log an event with path") { done in
            let tracker = SimpleAnalytics(hostname: "simpleanalyticsswift.app")
            do {
                try await tracker.trackEvent(event: "test event path", path: ["testpath1", "testpath2"])
                done()
            } catch {
                Issue.record("Failed to log event with path: \(error)")
            }
        }
    }
    
    @Test func eventWithPathAndMetadata() async throws {
        await confirmation("Log an event with path and metadata") { done in
            let tracker = SimpleAnalytics(hostname: "simpleanalyticsswift.app")
            let metadata = ["plan": "premium", "meta": "data"]
            do {
                try await tracker.trackEvent(event: "test event path metadata", path: ["testpath1", "testpathmetadata"], metadata: metadata)
                done()
            } catch {
                Issue.record("Failed to log event with path and metadata: \(error)")
            }
        }
    }
    
    @Test func invalidHostname() async throws {
        let tracker = SimpleAnalytics(hostname: "piet.henkklaas")
        tracker.track(event: "test")
    }
    
    @Test func pageviewArray() async throws {
        let tracker = SimpleAnalytics(hostname: "simpleanalyticsswift.app")
        tracker.track(path: ["testpath", "testarray"])
    }
    
    @Test func eventWithDefaultsGroup() async throws {
        await confirmation("Log an event with userdefaults") { done in
            let tracker = SimpleAnalytics(hostname: "simpleanalyticsswift.app", sharedDefaultsSuiteName: "app.yourapp.com")
            do {
                try await tracker.trackEvent(event: "test user defaults")
                done()
            } catch {
                Issue.record("Failed to log event with user defaults: \(error)")
            }
        }
    }
    
    @Test func path() {
        let tracker = SimpleAnalytics(hostname: "simpleanalyticsswift.app")
        let path = tracker.pathToString(path: ["path1", "path2"])
        #expect(path == "/path1/path2")
        let emptyPath = tracker.pathToString(path: [])
        #expect(emptyPath == "/")
        let invalidPath = tracker.pathToString(path: ["árhùs#$@"])
        #expect(invalidPath == "/arhus")
    }
}
