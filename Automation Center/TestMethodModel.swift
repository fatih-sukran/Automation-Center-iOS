//
//  Item.swift
//  Automation Center
//
//  Created by fatih.sukran on 5.11.2023.
//

import Foundation
import SwiftData

@Model
final class TestMethod: Decodable {
    let id: Int
    let name: String

    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }

    // Implement the required initializer for Decodable conformance.
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
    }

    // If your CodingKeys are different from the property names, define them.
    private enum CodingKeys: String, CodingKey {
        case id
        case name
    }
}

