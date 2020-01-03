import XCTest
@testable import loteria

class LotteryRepositoryTests: XCTestCase {
  
  let christmasRepository = LotteryRepositoryBuilder.christmas()
  let childRepository = LotteryRepositoryBuilder.child()
  
  func test_christmas_summary() {
    let expectation = self.expectation(description: "Christmas fetch summary")
    
    self.christmasRepository.fetchSummary() { response in
      XCTAssertNotNil(response)
      XCTAssertEqual(response?.status, .finishedOfficial)
      XCTAssertEqual(response?.error, 0)
      
      expectation.fulfill()
    }

    self.waitForExpectations(timeout: 1.0, handler: nil)
  }
  
  func test_christmas_search() {
    let expectation = self.expectation(description: "Christmas search number")
    
    self.christmasRepository.search(number: 750) { (response) in
      XCTAssertNotNil(response)
      XCTAssertEqual(response?.numero, 750)
      XCTAssertEqual(response?.error, 0)
      
      expectation.fulfill()
    }
    
    self.waitForExpectations(timeout: 1.0, handler: nil)
  }
  
  func test_child_summary() {
    let expectation = self.expectation(description: "Child fetch summary")
    
    self.childRepository.fetchSummary { (response) in
      XCTAssertNotNil(response)
      
      expectation.fulfill()
    }
    
    self.waitForExpectations(timeout: 1.0, handler: nil)
  }
  
  func test_child_search() {
    let expectation = self.expectation(description: "Child search number")
    
    self.childRepository.search(number: 750) { (response) in
      XCTAssertNotNil(response)
      XCTAssertEqual(response?.numero, 750)
      XCTAssertEqual(response?.error, 0)
      
      expectation.fulfill()
    }
    
    self.waitForExpectations(timeout: 1.0, handler: nil)
  }
  
  func test_christmasSummaryResponse() {
    let response = ChristmasSummaryResponse.example()
    XCTAssertNotNil(response)
  }
  
  func test_childSummaryResponse() {
    let response = ChildSummaryResponse.example()
    XCTAssertNotNil(response)
  }
  
  func test_lotterySearchResponse() {
    let response = LotterySearchResponse.example()
    XCTAssertNotNil(response)
  }
}
