//
//  Item.swift
//  Automation Center
//
//  Created by fatih.sukran on 5.11.2023.
//

import Foundation
import SwiftData

@Model
final class TestMethod {
    var id: Int
    var name: String
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}
