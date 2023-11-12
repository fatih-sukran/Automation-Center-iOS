//
//  TestDetailViewModel.swift
//  Automation Center
//
//  Created by fatih.sukran on 9.11.2023.
//

import Foundation

class TestDetailViewModel: ObservableObject {
        
    func runTest(id: Int) {
        let runTestEndpoint = "/run/test/\(id)";
//        ServiceUtil.get(url: runTestEndpoint);
        
    }
}
