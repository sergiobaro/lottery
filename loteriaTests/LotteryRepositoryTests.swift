import XCTest
@testable import loteria

class LotteryRepositoryTests: XCTestCase {
  
  let repository = LotteryRepository()
  
  func test_() {
    let expectation = self.expectation(description: "Fetch summary")
    repository.fetchSummary() { response in
      XCTAssertNotNil(response)
      XCTAssertEqual(response?.status, .finished)
      XCTAssertEqual(response?.error, 0)
      
      expectation.fulfill()
    }

    self.waitForExpectations(timeout: 1.0, handler: nil)
  }
}
