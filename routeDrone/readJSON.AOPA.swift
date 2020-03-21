//
//  readJSON.AOPA.swift
//  Sky.Tech-Route.Rebuild
//
//  Created by Артем Стратиенко on 18/08/2019.
//  Copyright © 2019 Артем Стратиенко. All rights reserved.
//

import Foundation
import Alamofire
import NMAKit

extension ViewController {
    public struct pointObject {
        var coords = NMAGeoCoordinates()
    }
    func readJSON(_ num : Int)  {
        var pointHeli = NMAGeoCoordinates()
        let aopa_close_area = "https://fpln.ru/api/landing/\(num)"
        //let aopa_close_area = "http://hack.bakhuss.ru/helipad"
        Alamofire.request(aopa_close_area, method: .get, parameters: [:], encoding: URLEncoding.default, headers: [:])
            .responseJSON
            { response in
                if let JSON:[String:Any] = response.result.value as? [String:Any] {
                    let mainObject:[String:Any] = JSON
                    let locPosition = mainObject["locPosition"] as! NSArray
                    pointHeli.latitude = locPosition[1] as! Double
                    pointHeli.longitude = locPosition[0] as! Double
                    pointHeli.altitude = 1
                    if num > 1800 && num < 1870 {
                        self.drawCh(geo: pointHeli,type : "heli_x-red-25.png")
                    } else if num > 1870 && num < 1900 {
                        self.drawCh(geo: pointHeli,type : "way-x.png")
                    } else if num > 1900 && num < 2000 {
                        self.drawCh(geo: pointHeli,type : "heli_x-fio-25.png")
                    } else if num > 2000 && num < 2050 {
                        self.drawCh(geo: pointHeli,type : "heli_x-grn-25.png")
                    } else {
                        self.drawCh(geo: pointHeli,type : "heli_x-blue-25.png")
                    }
                    self.status = true
        } else {
                    self.status = false
                    print("json no reader")
                   return
                }
        }
    }
    func jsonFromfile(_ fileJson : String) -> String   {
        let json =  _initCheckDirectory(fileJson)
       // print("json : \(json)")
        return json
        //jsonFromfile("vrp.json")
    }
}
