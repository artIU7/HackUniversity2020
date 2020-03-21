//
//  createdHeliport.swift
//  Sky.Tech-Route.Rebuild
//
//  Created by Артем Стратиенко on 18/08/2019.
//  Copyright © 2019 Артем Стратиенко. All rights reserved.
//

import Foundation
import NMAKit

public struct objectPoint {
    var polyGon : NMAMapPolygon?
    var polyBox : NMAGeoBoundingBox?
}
var object = objectPoint()
public func drawRectwithPoint(centrBox : NMAGeoCoordinates, _ height : Float) -> objectPoint {
    
    var geoBoxPolygon : NMAGeoBoundingBox?
    var boxPoly : NMAMapPolygon?
    geoBoxPolygon = NMAGeoBoundingBox(center: centrBox,
                               width: height,
                               height: height)
    //create a NMAMapPolygon with bounding box's vertices.
    boxPoly = geoBoxPolygon.map{ NMAMapPolygon(vertices: [$0.topLeft,
                                                      $0.bottomLeft,
                                                      $0.bottomRight,
                                                      $0.topRight]) }
    object.polyBox = geoBoxPolygon
    object.polyGon = boxPoly
    boxPoly?.fillColor = UIColor.gray
    boxPoly?.lineWidth = 1
    boxPoly?.lineColor = UIColor.red
    boxPoly?.isVisible = true
    //_ = boxPoly.map{MapView.add(mapObject: $0)}
    return object
}
