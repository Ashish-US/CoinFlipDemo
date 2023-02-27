//
//  CoinFlipViewModelTests.swift
//  CoinFlipDemoAppTests
//
//  Created by Ashish Singh on 2/26/23.
//

import XCTest
import Combine
@testable import CoinFlipDemoApp

class CoinFlipViewModelTests: XCTestCase {

    var sut: CoinFlipViewModel!
    var mockFlowController: MockFlowController!
    var mockNetworkManager: MockNetworkManager!
    var subscription: Set<AnyCancellable>!
    
    override func setUp() {
        subscription = Set<AnyCancellable>()
        mockFlowController = MockFlowController()
        mockNetworkManager = MockNetworkManager()
        sut = CoinFlipViewModel(flowController: mockFlowController, networkManager: mockNetworkManager)
    }
    
    override func tearDown() {
        mockFlowController = nil
        mockNetworkManager = nil
        sut = nil
        subscription = nil
    }

    func testNetworkManagerIsConnected() throws {
        sut.handleEvent(input: .fetchData)
        XCTAssertTrue(mockNetworkManager.isFetchDataCalled) 
    }
    
    func testHandleEventSuccess() {
        // Given
        let expected = CoinFlipDataModel.mock()
        mockNetworkManager.mockResult = .success(expected)

        sut.subject.sink { _ in } receiveValue: { result in
            // Then
            XCTAssertEqual(expected, result)
        }.store(in: &self.subscription)

        // When
        sut.handleEvent(input: .fetchData)
    }

    func testHandleEventFailed() {
        // Given
        let expectedError = AppErrors.network
        mockNetworkManager.mockResult = .failure(expectedError)

        sut.subject.sink { completion in
            // Then
            if case let .failure(error) = completion {
                XCTAssertEqual(error, expectedError)
            }
        } receiveValue: { _ in }
        .store(in: &self.subscription)

        // When
        sut.handleEvent(input: .fetchData)
    }

    func testUserSelection() {
        sut.handleEvent(input: .userSelection(row: 2))
        XCTAssertEqual(mockFlowController.destination, .detailScreen)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
