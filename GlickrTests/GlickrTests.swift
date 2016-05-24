//
//  GlickrTests.swift
//  GlickrTests
//
//  Created by Ilter Cengiz on 22/05/16.
//  Copyright © 2016 Ilter Cengiz. All rights reserved.
//

import XCTest
@testable import Glickr

class GlickrTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testRecents() {
        let expectation = expectationWithDescription("Recent photos")
        FlickrAPIClient.recentPhotos(0, handler: { (photos, page, pages, total) in
            XCTAssertEqual(page, 1)
            XCTAssertEqual(pages, 10)
            XCTAssertEqual(total, 1000)
            XCTAssertGreaterThan(photos.count, 0)
            expectation.fulfill()
        }) { (error) in
            XCTAssert(false, "Recent photos failed: \(error?.localizedDescription)")
            expectation.fulfill()
        }
        waitForExpectationsWithTimeout(60) { (error) in }
    }
    
}
