//
//  Form.swift
//  TesteiOSSantander
//
//  Created by Mac on 19/08/2018.
//  Copyright © 2018 Leo Valentim. All rights reserved.
//

import Foundation

enum Type: Int, Codable {
    case field = 1
    case text = 2
    case image = 3
    case checkbox = 4
    case send = 5
}

enum TypeField: Int, Codable {
    case text = 1
    case telNumber = 2
    case email = 3
    
    static func from(string: String?) -> TypeField? {
        switch string {
        case "text"?:
            return TypeField(rawValue: 1)
        case "telnumber"?:
            return TypeField(rawValue: 2)
        case "email"?:
            return TypeField(rawValue: 3)
        default:
            return nil
        }
    }
}

struct Form: Codable {
    let cells: [Cell]?
}

struct Cell: Codable {
    let id: Int?
    let type: Type?
    let message: String?
    let typefield: TypeField?
    let hidden: Bool?
    let topSpacing: Double?
    let show: Int?
    let required: Bool?
    
    private enum CodingKeys: String, CodingKey {
        case id, type, message, typefield, hidden, topSpacing, show, required
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int?.self, forKey: .id)
        type = try container.decode(Type?.self, forKey: .type)
        message = try container.decode(String?.self, forKey: .message)
        hidden = try container.decode(Bool?.self, forKey: .hidden)
        topSpacing = try container.decode(Double?.self, forKey: .topSpacing)
        show = try container.decode(Int?.self, forKey: .show)
        required = try container.decode(Bool?.self, forKey: .required)
        
        if let value = try? container.decode(Int.self, forKey: .typefield) {
            typefield = TypeField(rawValue: value)
        } else if let value = try? container.decode(String.self, forKey: .typefield) {
            typefield = TypeField.from(string: value)
        } else {
            typefield = nil
        }
    }
}
