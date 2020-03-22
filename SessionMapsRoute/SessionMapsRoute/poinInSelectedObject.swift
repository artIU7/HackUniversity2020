//
//  poinInSelectedObject.swift
//  Sky.Tech-Route.Rebuild
//
//  Created by Артем Стратиенко on 18/08/2019.
//  Copyright © 2019 Артем Стратиенко. All rights reserved.
//

import Foundation
import NMAKit

func pointInSelectedPoint(selectedPoint : NMAGeoCoordinates,interactionObject :NMAGeoBoundingBox) -> Bool {
    let x = round(selectedPoint.latitude * 1000)/1000
    let y = round(selectedPoint.longitude * 1000)/1000
    let a = round(interactionObject.topLeft.latitude * 1000)/1000
    let b = round(interactionObject.topLeft.longitude * 1000)/1000
    let c = round(interactionObject.bottomRight.latitude * 1000)/1000
    let d = round(interactionObject.bottomRight.longitude * 1000)/1000
    
    if (x >= a && x <= c) && (y <= b && y >= d) {
        print("point in bound : lat :\(selectedPoint.latitude))\nlon :\(selectedPoint.longitude))")
        print("lat1\(a)")
        print("lon1\(b)")
        print("lat1\(c)")
        print("lon1\(d)")
        return true
    } else {
          print("point out bound : lat :\(selectedPoint.latitude)\nlon :\(selectedPoint.longitude)")
        return false
    }

    //print("res\(res)")
   // var lat = test.latitude
   // if selectedPoint.latitude < test.map{NMAvertices : $0.topLeft}//test.latitude.map{$0.topLeft}//{ NMAMapPolygon(vertices: [$0.topLeft]}
}
