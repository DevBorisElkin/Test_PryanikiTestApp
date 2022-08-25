//
//  NetworkResults.swift
//  PryanikiTestApp
//
//  Created by Boris on 25.08.2022.
//

import Foundation

struct PryanikiResultWrapped: Decodable {
    var data: [DataObjectWrapped]
    var view: [String]
}

struct DataObjectWrapped: Decodable {
    var name: String
    var data: DataObject
}

struct DataObject: Decodable {
    var text: String?
    var url: String?
    var selectedId: Int?
    var variants: [Variant]?
}

struct Variant: Decodable {
    var id: Int
    var text: String
}
