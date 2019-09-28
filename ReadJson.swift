//
//  readjson.swift
//  Baitapjson
//
//  Created by Nguyễn Minh Hiếu on 9/19/19.
//  Copyright © 2019 Nguyễn Minh Hiếu. All rights reserved.
//

import Foundation

class Readjson {
    static let shared = Readjson()

    func  pasejson() -> [City]{
        var json = [City]()
        if let path = Bundle.main.path(forResource: "city", ofType: "json"){
            do{
                let fileurl = URL(fileURLWithPath: path)
                let data = try Data(contentsOf: fileurl )
                //                json = try? JSONSerialization.jsonObject(with: data)
                json = try! JSONDecoder().decode([City].self, from: data)
                return json
            }
            catch{}
        }
        return [City]()
    }
}
