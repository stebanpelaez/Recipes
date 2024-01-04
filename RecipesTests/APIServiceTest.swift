//
//  APIServiceTest.swift
//  Recipes
//
//  Created by Juan Esteban Pelaez on 3/01/24.
//

import XCTest

@testable import Recipes

final class APIServiceTest: XCTestCase {

    func testGetService() {

        let consumeService = expectation(description: "Consume get services from server")

        let urlSessionMock = MockURLSession()
        urlSessionMock.data = try? JSONSerialization.data(withJSONObject: MockConstants.responseCategories)

        let apiService = APIService(session: urlSessionMock)

        let headers = [HTTPHeader.contentType: HTTPHeader.applicationJson]
        let params = ["q": "p"]

        let request = APIRequestBuilder(urlApi: Constants.urlBase.rawValue)
            .withMethod(.get)
            .withHeaders(headers)
            .withParams(params)
            .withTimeOut(30)
            .withEndPoint(Constants.endPointCategories.rawValue)
            .build()

        apiService.consumeAPIEndpoint(request: request, type: CategoryList.self) { result in
            switch result {
            case .success(let categories):
                XCTAssertTrue(!categories.categories.isEmpty)
                consumeService.fulfill()
            case .failure(_):
                assertionFailure()
            }
        }

        wait(for: [consumeService], timeout: 3.0)
    }

    func testGetServiceError() {

        let consumeService = expectation(description: "Consume get services Error from server")

        let urlSessionMock = MockURLSession()
        urlSessionMock.statusCode = 401
        urlSessionMock.data = try? JSONSerialization.data(withJSONObject: MockConstants.responseCategories)

        let apiService = APIService(session: urlSessionMock)

        let headers = [HTTPHeader.contentType: HTTPHeader.applicationJson]
        let params = ["q": "p"]

        let request = APIRequestBuilder(urlApi: Constants.urlBase.rawValue)
            .withMethod(.post)
            .withHeaders(headers)
            .withParams(params)
            .withTimeOut(30)
            .withEndPoint(Constants.endPointCategories.rawValue)
            .build()

        apiService.consumeAPIEndpoint(request: request, type: CategoryList.self) { result in
            switch result {
            case .success(_):
                assertionFailure()
            case .failure(let error):
                XCTAssertNotNil(error.localizedDescription)
                consumeService.fulfill()
            }
        }

        wait(for: [consumeService], timeout: 3.0)
    }

}
