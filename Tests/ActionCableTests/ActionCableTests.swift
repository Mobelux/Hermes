import XCTest
@testable import ActionCable
@testable import Hermes

class ActionCableTests: XCTestCase {
    let actionCable = ActionCable<MockSocketWrapper>(request: URLRequest(url: URL(string: "http://mobelux.com")!))!

    func testConnect() {
        let expectation = self.expectation(description: "Connection")

        actionCable.connect {
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func testDisconnect() {
        let expectation = self.expectation(description: "Disconnect")

        actionCable.disconnect { error in
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1.0, handler: nil)
    }
}
