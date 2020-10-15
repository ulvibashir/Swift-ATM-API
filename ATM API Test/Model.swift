//
//  Model.swift
//  ATM API Test
//
//  Created by Ulvi Bashirov on 10/8/20.
//

import Foundation

struct ATM: Codable {
    var id: Int?
    var extId: String?
    var type: String?
    var latitude: Float?
    var longitude: Float?
    var workOnWeekend: Bool?
    var atmCashIn: Bool?
    var name: String?
    var address: String?
}

struct Data: Codable {
    var data: [ATM]?
}

enum Languages: String, CaseIterable {
    case AZ = "AZ"
    case EN = "EN"
    case RU = "RU"
}
