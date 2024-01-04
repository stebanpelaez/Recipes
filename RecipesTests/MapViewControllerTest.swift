//
//  MapViewControllerTests.swift
//  Recipes
//
//  Created by Juan Esteban Pelaez on 3/01/24.
//

import XCTest
@testable import Recipes

class MapViewControllerTests: XCTestCase {

    private var sut: MapViewController!

    override func setUp() {
        super.setUp()

        sut = MapViewController()

        sut.loadViewIfNeeded()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testMaps() {

        let expectation = expectation(description: "Expectation map")

        DispatchQueue.global().async {
            Thread.sleep(forTimeInterval: 2)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 4.0)

        XCTAssertNotNil(sut.mapView)
    }

}
