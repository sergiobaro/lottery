import XCTest
@testable import loteria

class LotteryRepositoryTests: XCTestCase {
  
  let repository = LotteryRepository()
  
  func test_summary() {
    let expectation = self.expectation(description: "Fetch summary")
    repository.fetchSummary() { response in
      XCTAssertNotNil(response)
      XCTAssertEqual(response?.status, .finishedOfficial)
      XCTAssertEqual(response?.error, 0)
      
      expectation.fulfill()
    }

    self.waitForExpectations(timeout: 1.0, handler: nil)
  }
  
  func test_search() {
    let expectation = self.expectation(description: "Search number")
    
    repository.search(number: 750) { (response) in
      XCTAssertNotNil(response)
      XCTAssertEqual(response?.numero, 750)
      XCTAssertEqual(response?.error, 0)
      
      expectation.fulfill()
    }
    
    self.waitForExpectations(timeout: 1.0, handler: nil)
  }
}
