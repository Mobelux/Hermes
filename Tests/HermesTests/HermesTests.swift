import XCTest
@testable import Hermes

class HermesTests: XCTestCase {
    let hermes = Hermes(socket: MockWebSocket(request: URLRequest(url: URL(string: "http://mobelux.com")!))!)

    func testConnect() {
        let expectation = self.expectation(description: "Connection")

        hermes.connectHandler = {
            expectation.fulfill()
        }

        hermes.connect()
        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func testDisconnect() {
        let expectation = self.expectation(description: "Disconnect")

        hermes.disconnectHandler = { error in
            expectation.fulfill()
        }

        hermes.disconnect()
        waitForExpectations(timeout: 1.0, handler: nil)
    }

    static var allTests = [
        ("testConnect", testConnect)
    ]
}
