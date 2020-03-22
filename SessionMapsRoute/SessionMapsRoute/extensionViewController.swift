//
//  extensionMapView.swift
//  SessionMapsRouting
//
//

import Foundation
import NMAKit


extension ViewController : NMAMapGestureDelegate {
    /**
     * callback when tap gesture occurred. It showed a image icon at location when tap gesture was applied.
     */
    func mapView(_ mapView: NMAMapView, didReceiveTapAt location: CGPoint) {
        mapView.longPressDuration = 0.1
        // it showed a message label for tap gesture
        /*showMessage("Tap gesture")
        
        //calculate geoCoordinates of tap gesture
        guard let markerCoordinates = mapView.geoCoordinates(from: location) else { return }
        
        //it added a image icon to map view at location where tap gesture was applied.
        if gestureMarker == nil {
            let image = UIImage(named: "heliport.png")
            gestureMarker = NMAMapMarker(geoCoordinates: markerCoordinates, image: image!)
            mapView.add(mapObject: gestureMarker!)
        } else {
            gestureMarker?.coordinates = markerCoordinates
        }
        
        if let defaultHandler = mapView.defaultGestureHandler {
            defaultHandler.mapView!(mapView, didReceiveTapAt: location)
        } */
        if let defaultHandler = mapView.defaultGestureHandler {
            defaultHandler.mapView!(mapView, didReceiveTapAt: location)
        }
        print("loc\(location)")
        showMessage("p",location.x, location.y)
        var geo =
        mapView.geoCoordinates(from: location)
        print("geo : \(geo)")
   
        if (pointInSelectedPoint(selectedPoint: mapView.geoCoordinates(from: location)!, interactionObject: rebuild())) {
               showMessage("in rect",location.x, location.y)
        } else {   showMessage("check route",location.x, location.y)}
        //var geo = NMAPositioningManager.sharedInstance().currentPosition
        //print("geo : \(geo)")
    }
    
    /**
     * callback when pan gesture occurred. It showed a message when pan gesture was applied.
     */
/*    func mapView(_ mapView: NMAMapView, didReceivePan translation: CGPoint, at location: CGPoint) {
        showMessage("Pan gesture")
        if let defaultHandler = mapView.defaultGestureHandler {
            defaultHandler.mapView!(mapView, didReceivePan: translation, at: location)
        }
    } */
    
    /**
     * callback when rotation gesture occurred. It showed a message when rotation gesture was applied.
     */
   /* func mapView(_ mapView: NMAMapView, didReceiveRotation rotation: Float, at location: CGPoint) {
        showMessage("Rotation gesture")
        if let defaultHandler = mapView.defaultGestureHandler {
            defaultHandler.mapView!(mapView, didReceiveRotation: rotation, at: location)
        }
    } */
    func mapView(_ mapView: NMAMapView, didSelect objects: [NMAViewObject]) {
        print("object\(objects)")
    }
}
