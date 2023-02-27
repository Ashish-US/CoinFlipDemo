//
//  MockFlowController.swift
//  CoinFlipDemoAppTests
//
//  Created by Ashish Singh on 2/26/23.
//

import Foundation
@testable import CoinFlipDemoApp

class MockFlowController: FlowControllable {
    var destination: Destination!
    
    func handleNavigation(destination: Destination) {
        self.destination = destination
    }
}
