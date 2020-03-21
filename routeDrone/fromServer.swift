//
//  fromServer.swift
//  Sky.Tech-Route.Rebuild
//
//  Created by Артем Стратиенко on 18/08/2019.
//  Copyright © 2019 Артем Стратиенко. All rights reserved.
//

import Foundation
import NMAKit
import Alamofire
extension ViewController {
struct objectHead {
    var id = String()
    var position = NSArray()
}
    func readMap() -> [String:[NMAGeoCoordinates]]  {
    var obj = objectHead()
        var ret = [String:[NMAGeoCoordinates]]()
    var arrayObj = [objectHead]()
    var pointHeli = NMAGeoCoordinates()
    var fullArrayT = [NMAGeoCoordinates]()
    let heli_port = "http://hack.bakhuss.ru/helipad"
    let rect = "http://hack.bakhuss.ru/restrictions"
    let area = "http://hack.bakhuss.ru/bans"
    var mainObject = [String:Any]()
    Alamofire.request(area, method: .get, parameters: [:], encoding: URLEncoding.default, headers: [:])
        .responseJSON
        { response in
            if let JSON:[Any] = response.result.value as? [Any] { //response.result.value as? [String:Any] {
                for i in 0...JSON.count - 1 {
                     mainObject = JSON[i]  as! [String:Any]
                    obj.id = mainObject["id"] as! String
                    obj.position = mainObject["path"] as! NSArray
                    print("id :\(obj.id)\n array :\(obj.position)")
                   // fullArray.removeAll()
                    for i in 0...obj.position.count - 1 {
                        var kkk = obj.position.count - 1
                       //var fullArray = repeatElement(NMAGeoCoordinates(latitude: 0.0, longitude: 0.0), count: kkk)
                        print("count:\(kkk)")
                        //fullArrayT = fullArray
                        let geo_cord = obj.position[i] as! NSArray
                        pointHeli.latitude = (geo_cord[0] as? Double)!
                        pointHeli.longitude = (geo_cord[1] as? Double)!
                        pointHeli.altitude = 600
                        fullArrayT.append(pointHeli)
                    }
                    print(fullArrayT)
                    
                    ret[obj.id] = fullArrayT as [NMAGeoCoordinates]
                    self.copyDict(copy: ret)
                    fullArrayT.removeAll()
                }
            }
        }
        return ret
    }
    func copyDict(copy : [String:[NMAGeoCoordinates]]) {
            print(copy)
        for keyA in copy.keys {
            print(keyA)//createPolyline(CTR: CTRARC[keyA])
            print(copy[keyA]!)
            let parametr = copy[keyA]!
            
            self.createPolyline(CTR: parametr)
        }
    }
}
