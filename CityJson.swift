//
//  CityJson.swift
//  Baitapjson
//
//  Created by Nguyễn Minh Hiếu on 9/17/19.
//  Copyright © 2019 Nguyễn Minh Hiếu. All rights reserved.
//

import Foundation

class City : NSObject, Codable {
    var id : Int?
    var name : String?
    var country : String?
    var coord : place?
}
struct place : Codable {
    var lon : Double
    var lat : Double
}
