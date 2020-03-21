//
//  ViewController.swift
//  Sky.Tech-Route.Rebuild
//
//  Created by Артем Стратиенко on 17/08/2019.
//  Copyright © 2019 Артем Стратиенко. All rights reserved.
//

import UIKit
import NMAKit

class ViewController: UIViewController,NMAMapViewDelegate {
    
    public var ret = [NMAGeoCoordinates]()
    let colorSchemeName = "color"
    let floatSchemeName = "float"
    let zoom = NMAZoomRange(minimum: 0, maximum: 20)
    var colorScheme: NMACustomizableScheme?
    var floatScheme: NMACustomizableScheme?
    public var status = Bool()
    @IBOutlet weak var headerLoadHeli: UILabel!
    @IBOutlet weak var countHeliLoad: UILabel!
    @IBOutlet var MapView: NMAMapView!
     let geoCoordCenter = NMAGeoCoordinates(latitude: 55.7576218, longitude: 37.6607666,altitude: 600)
     let testPoint = NMAGeoCoordinates(latitude: 56.5167, longitude: 38.1917,altitude: 600)
    //private var geoPolygon : NMAMapPolygon?
    private var geoPolyline : NMAMapPolyline?
    private var geoBox : NMAGeoBoundingBox?
    private var geoBox1 : NMAGeoBoundingBox?
    var boxik : NMAGeoBoundingBox?
    private var mapMarker : NMAMapMarker?
    private var mapCircle : NMAMapCircle?
    var  geoArrayCoord = [NMAGeoCoordinates(latitude: 56.5167, longitude: 38.1917,altitude: 600),
                          NMAGeoCoordinates(latitude: 56.4778, longitude: 38.1125,altitude: 600)]
    var CTRAREA = [NMAGeoCoordinates(latitude: 56.5167, longitude: 38.1917,altitude: 600),
                   NMAGeoCoordinates(latitude: 56.4778, longitude: 38.1125,altitude: 600),
                   NMAGeoCoordinates(latitude: 56.4639, longitude: 38.1167,altitude: 600),
                   NMAGeoCoordinates(latitude: 56.4639, longitude: 38.2,altitude: 600),
                   NMAGeoCoordinates(latitude: 56.5125, longitude: 38.2153,altitude: 600),
                   NMAGeoCoordinates(latitude: 56.5167, longitude: 38.1917,altitude: 600)]

    var CTRARC = [String:[NMAGeoCoordinates]]()//["UUP69"] = CTRAREA;
    var lineDraw = [NMAGeoCoordinates(latitude: 55.7576218, longitude: 37.6607666,altitude: 600),
                 NMAGeoCoordinates(latitude: 52.7408484, longitude: 33.65,altitude: 100)]
    var drawNewRouting = [NMAGeoCoordinates(latitude: 55.7576218, longitude: 37.6607666,altitude: 600),
                    NMAGeoCoordinates(latitude: 55.6576218, longitude: 33.65,altitude: 100)]

    public var gestureMarker: NMAMapMarker?
    @IBOutlet weak var currentPosition: UIButton!
    public var coordSystemHeli = [NMAGeoCoordinates]()
 
    override func viewDidLoad() {
        super.viewDidLoad()
         //venueMapLayer = self.MapView.venue3dMapLayer;
        MapView.gestureDelegate = self
        
        guard let image = UIImage(named: "resource.png") else { return }
        // 1
         guard let A = UIImage(named: "1.png") else { return }
        // 2
         guard let B = UIImage(named: "2.png") else { return }
        // 3
         guard let C = UIImage(named: "3.png") else { return }
        // 4
         guard let D = UIImage(named: "4.png") else { return }
        // 5
         guard let Y = UIImage(named: "5.png") else { return }
        CTRARC["UUP69"] = CTRAREA;
        CTRARC["ROUTE23"] = lineDraw
        CTRARC["ROUTE"] = drawNewRouting
        //CTRARC["cc"] = ctrr
        self.MapView.set(geoCenter: geoCoordCenter, animation: .linear)
        self.MapView.zoomLevel = 20;
        // Do any additional setup after loading the view.
      // 4  MapView.positionIndicator.isVisible = true;
        NMAPositioningManager.sharedInstance().dataSource = NMAHEREPositionSource()
        MapView.orientation = 20;
        //MapView.tilt = 210;
        MapView.mapScheme = NMAMapSchemeHybridDay
        //colorCustomization()
       NotificationCenter.default.addObserver(self,
                                               selector: #selector(ViewController.didUpdatePosition),
                                               name: NSNotification.Name.NMAPositioningManagerDidUpdatePosition,
                                               object: NMAPositioningManager.sharedInstance())
        // Set position indicator visible. Also starts position updates.
        MapView.positionIndicator.isVisible = true
        for g in geoArrayCoord {
            var polyTester = drawRectwithPoint(centrBox: g, 0.01)
            _ = polyTester.polyGon.map{MapView.add(mapObject: $0)}
            boxik = polyTester.polyBox
        }
       // pointInSelectedPoint(selectedPoint: testPoint, interactionObject: polyTester.polyBox!)
       // print(polyTester.polyBox?.bottomLeft)
    
        //
        let one = NMAMapMarker(geoCoordinates: NMAGeoCoordinates(latitude: (boxik?.topLeft.latitude)!, longitude: (boxik?.topLeft.longitude)!), image: A)
        MapView.add(mapObject: one)
        let four = NMAMapMarker(geoCoordinates: NMAGeoCoordinates(latitude: (boxik?.bottomRight.latitude)!, longitude: (boxik?.bottomRight.longitude)!), image: D)
        MapView.add(mapObject: four)
        let five = NMAMapMarker(geoCoordinates: NMAGeoCoordinates(latitude: geoCoordCenter.latitude, longitude: geoCoordCenter.longitude), image: Y)
        MapView.add(mapObject: five)
        
       // readJSON()
        //
       /* let two = NMAMapMarker(geoCoordinates: geoCoordCenter, image: B)
        MapView.add(mapObject: indicatorMarker)
        //
        let tree = NMAMapMarker(geoCoordinates: geoCoordCenter, image: C)
        MapView.add(mapObject: indicatorMarker)
        //
        let four = NMAMapMarker(geoCoordinates: geoCoordCenter, image: D)
        MapView.add(mapObject: indicatorMarker)
        //
        let five = NMAMapMarker(geoCoordinates: testPoint, image: Y)
        MapView.add(mapObject: indicatorMarker) */
      //  vrpJson()
         /*readJSON(1)
         readMap() */
    }
 
    func rebuild() -> NMAGeoBoundingBox{
        var temp = boxik
        return temp!
    }
    @objc func didUpdatePosition() {
        guard let position = NMAPositioningManager.sharedInstance().currentPosition,
            let coordinates = position.coordinates else {
                return
        }
            MapView.set(geoCenter: coordinates, animation: .linear)
       // let myPosition = NMAPositioningManager.sharedInstance().currentPosition
       // print("my pos\(myPosition?.coordinates)")
    }
    public func createPolyline(CTR : [NMAGeoCoordinates]) {
       // cleanup()
        
        //create a NMAGeoBoundingBox with center gec coordinates, width and hegiht in degrees.
        geoBox1 = NMAGeoBoundingBox(coordinates: CTR)
        geoPolyline = geoBox1.map{ _ in NMAMapPolyline(vertices: CTR) }
        //set border line width in pixels
        geoPolyline?.lineWidth = 10;
        //set border line color to be red
        geoPolyline?.lineColor = UIColor(displayP3Red: 0.5, green: 0.2, blue: 0.6, alpha: 0.3)
        //add NMAMapPolyline to map view
        _ = geoPolyline.map { MapView?.add(mapObject: $0) }
    }
    // showMessageTap
    public func showMessage(_ message: String,_ x : CGFloat,_ y : CGFloat) {
        var frame = CGRect(x: x, y: y, width: 220, height: 120)
        
        let label = UILabel(frame: frame)
        label.backgroundColor = UIColor.groupTableViewBackground
        label.textColor = UIColor.blue
        label.text = message
        label.numberOfLines = 0
        
        let text = message as NSString
        let options : NSStringDrawingOptions = [.usesLineFragmentOrigin, .usesFontLeading]
        
        let rect = text.boundingRect(with: frame.size,
                                     options: options,
                                     attributes: [NSAttributedString.Key.font :label.font],
                                     context: nil)
        
        frame.size = rect.size
        label.frame = frame
        
        self.view.addSubview(label)
        
    //    UIView.animate(withDuration: 2.0,
      //                 animations: { label.alpha = 0 })
     //   { _ in label.removeFromSuperview() }
    }
    func drawCh(geo : NMAGeoCoordinates, type : String) {
        let marker = NMAMapMarker(geoCoordinates: geo, image: UIImage(named: type)!)
        coordSystemHeli.append(geo)
        let cluster = NMAClusterLayer()
        cluster.addMarker(marker)
        self.MapView.add(clusterLayer: cluster)
        print("coordMass\(coordSystemHeli)")
        print("coordMass.count :\(coordSystemHeli.count)")
        rechangeCount()
}
 
    @IBAction func curPosition(_ sender: Any) {
      
         var k = 0
        for i in 1800...2222 {
           readJSON(i)
            if (status) {
                k+=1
            }
        }
       // readMap()
    }
    func rechangeCount() {
        countHeliLoad.text = String(coordSystemHeli.count)
    }
    func drawPolyWithHeliport(allHeli : [NMAGeoCoordinates]) {
        var newArray = [NMAGeoCoordinates]()
        var count  = allHeli.count
        for var i in 0...count - 1 {
                newArray.append(allHeli[i])
        }
        print("count new\(newArray.count)")
        createPolyline(CTR: newArray)
    }
    @IBAction func drawRoute(_ sender: Any) {
        drawPolyWithHeliport(allHeli: coordSystemHeli)
    }
   
    @IBAction func drawCTR(_ sender: Any) {
    readMap()
    print(CTRARC)
       for keyA in CTRARC.keys {
            print(keyA)//createPolyline(CTR: CTRARC[keyA])
            print(CTRARC[keyA]!)
            let parametr = CTRARC[keyA]!
            createPolyline(CTR: parametr)
        } 
    }
    func colorCustomization() {
        //if customized map scheme already exists, remove it first.
        if MapView.getCustomizableScheme(floatSchemeName) != nil {
            //it is not allowed to remove map scheme which is active.
            //set to other map scheme then remove.
            MapView.mapScheme = NMAMapSchemeCarNavigationNightWithTraffic
            MapView.removeCustomizableScheme(floatSchemeName)
        }
        
        //create customizable scheme with specific scheme name based on NMAMapSchemeNormalDay
        if (colorScheme == nil) {
            colorScheme = MapView.createCustomizableScheme(colorSchemeName, basedOn: NMAMapSchemeCarNavigationNightWithTraffic)
        }
        
        //create customizable color for property NMASchemeBuildingColor for specific zoom level
        let buildingColor = colorScheme?.colorForProperty(NMASchemeColorProperty.buildingColor, zoomLevel: 18.0)
        
        buildingColor?.red = 91
        buildingColor?.green = 164
        buildingColor?.blue = 143
        
        //set color property
        if let color = buildingColor {
            colorScheme?.setColorProperty(color, zoomRange: zoom)
        }
        
        //set map scheme to be customized scheme
        MapView.mapScheme = colorSchemeName
        MapView.set(geoCenter: NMAGeoCoordinates(latitude: 55.7576218, longitude: 37.6607666), zoomLevel: 5, animation: NMAMapAnimation.none)
    }
}


