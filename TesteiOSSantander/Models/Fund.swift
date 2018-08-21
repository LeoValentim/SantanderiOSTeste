//
//  Fund.swift
//  TesteiOSSantander
//
//  Created by Mac on 21/08/2018.
//  Copyright © 2018 Leo Valentim. All rights reserved.
//

import Foundation

struct Fund: Codable {
    let screen: Screen?
}

struct Screen: Codable {
    let title, fundName, whatIs, definition: String?
    let riskTitle: String?
    let risk: Int?
    let infoTitle: String?
    let moreInfo: MoreInfo?
    let info, downInfo: [Info]?
}

struct Info: Codable {
    let name: String?
    let data: String?
}

struct MoreInfo: Codable {
    let month, year, the12Months: The12_Months?
    
    enum CodingKeys: String, CodingKey {
        case month, year
        case the12Months = "12months"
    }
}

struct The12_Months: Codable {
    let fund, cdi: Double?
    
    enum CodingKeys: String, CodingKey {
        case fund
        case cdi = "CDI"
    }
}
