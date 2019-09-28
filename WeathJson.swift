//
//  WeathJson.swift
//  Baitapjson
//
//  Created by Nguyễn Minh Hiếu on 9/26/19.
//  Copyright © 2019 Nguyễn Minh Hiếu. All rights reserved.
//

import Foundation

class WeathJSON : NSObject,Codable {
    var weather : [dataweather]? // error here
    var main : datamain?
    var sys : datasys?
}

struct dataweather : Codable {
    let description : String
}

struct datamain : Codable {
    let temp : Int?
    let pressure : Int?
    let humidity : Int?
    let temp_min : Int?
    let temp_max : Int?
}

struct datasys : Codable {
    let sunrise : Int?
    let sunset : Int?
}
