//
//  Item.swift
//  Automation Center
//
//  Created by fatih.sukran on 5.11.2023.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
