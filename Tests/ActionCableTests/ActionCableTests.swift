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
    
    func testSubscribe() {
        let expectation = self.expectation(description: "Subscribe")
        let channelName = "channelName"
        
        do {
            try actionCable.subscribe(channelName, handler: { _ in
              expectation.fulfill()
            })
        } catch {
            print(error.localizedDescription)
        }
         waitForExpectations(timeout: 1.0, handler: nil)
    }
    func testUnsubscribe() {
        let expecation = self.expectation(description: "Unsubscribe")
        let channelName = "channelName"
       
        do {
            try actionCable.unsubscribe(channelName)
            expecation.fulfill()
        } catch {
            print(error.localizedDescription)
        }
          waitForExpectations(timeout: 1.0, handler: nil)
    }
    func testSend(){
        let expectation = self.expectation(description: "Send")
        let instruction = Instruction(command: .message, identifier: Identifier(channel: Channel(name: "channelName")), data: nil)
       
        do {
            try actionCable.send(instruction)
             expectation.fulfill()
        } catch {
            print(error.localizedDescription)
        }
         waitForExpectations(timeout: 1.0, handler: nil)
    }
}
