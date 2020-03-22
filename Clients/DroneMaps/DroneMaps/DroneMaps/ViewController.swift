//
//  ViewController.swift
//  DroneMaps
//
//  Created by Артем Стратиенко on 22.03.2020.
//  Copyright © 2020 Артем Стратиенко. All rights reserved.

import UIKit

import NMAKit
import CoreTelephony
import CoreML
import AVFoundation

//
protocol quaklyInit{
    func MapInit ()
}
protocol InitMap {
    var copyrightLogoPosition : UInt {get set}
    var orientation : UInt {get set}
    var mapScheme : String {get set}
}
struct LastPosition {
    var  latitude : Double
    var longitude : Double
}
//*** user's struct
struct Location {
    var  latitude : Double
    var longitude : Double
}
var arrayLocation = [Location]()
var poly = Location(latitude: 0, longitude: 0)
var last = LastPosition(latitude: 0, longitude: 0)
//

struct objpost {
    var latitude = Double()
    var longitude = Double()
    var cellor = String()
}
struct closedArea {
    var frame_area = [NMAGeoCoordinates]()
}
//
struct circlePoint {
    var frame_area = [NMAGeoCoordinates]()
}
struct poly_struct {
    var id : Int
    var poly : [NMAMapPolyline]
}
struct stops {
    var id : Int
    var coordinates : NMAGeoCoordinates
}
struct routes {
    var id : Int
    var coordinates : [NMAGeoCoordinates]
    init() {
        self.id = 0
        self.coordinates = []
    }
    init (id : Int,coordinates : [NMAGeoCoordinates]) {
        self.id = id
        self.coordinates = coordinates
    }
}
struct drone_ {
    var id : Int
    var stop : stops
    var route : routes
    var coordinate : NMAGeoCoordinates
}
var arrayBus = [drone_]()
var arrayPolys = [poly_struct]()
let routeBus = [NMAGeoCoordinates(latitude: 55.78975234252623, longitude: 38.437278270721436),
                NMAGeoCoordinates(latitude: 55.79057571375545, longitude: 38.43688666820526),
                NMAGeoCoordinates(latitude: 55.79059984158761, longitude: 38.43688130378723),
                NMAGeoCoordinates(latitude: 55.79061793745191, longitude: 38.4369134902954),
                NMAGeoCoordinates(latitude: 55.79063301733242, longitude: 38.43697249889374),
                NMAGeoCoordinates(latitude: 55.79065714512908, longitude: 38.43708515167236),
                NMAGeoCoordinates(latitude: 55.79071746455533, longitude: 38.43745529651642),
                NMAGeoCoordinates(latitude: 55.7908230233265, longitude: 38.43817412853241),
                NMAGeoCoordinates(latitude: 55.79125731926113, longitude: 38.44126403331756)]
let routeBus_2 = [NMAGeoCoordinates(latitude: 55.7975234252623, longitude: 38.47278270721436),
NMAGeoCoordinates(latitude: 55.5071746455533, longitude: 38.23745529651642),
NMAGeoCoordinates(latitude: 55.4908230233265, longitude: 38.12817412853241),
NMAGeoCoordinates(latitude: 55.39125731926113, longitude: 38.24126403331756)]
var testStops = stops(id: 1, coordinates: NMAGeoCoordinates(latitude: 55.76238, longitude: 37.61084))
//var testRoutes = routes(id: 1, coordinates: routeBus)
//var testtrm = routes(id: 1, coordinates: routeBus_2)

// let/var
    var detected = "Delete"
    var str = [NMAGeoCoordinates]()
    var array_area = closedArea()
    //
    var dropCircle = circlePoint()
    private var geoBox1 : NMAGeoBoundingBox?
    private var geoPolyline : NMAMapPolyline?
    var id_user = 1
    var offsetPoint : NMAGeoCoordinates?// = nil
    var arrayARObject = [NMAGeoCoordinates]()//?//[offsetPoint]?
    var arrayBusMove = [NMAMapMarker]()

/* "LineString","coordinates":[[37.54329800605774,55.89138380688599],[37.5432550907135,55.89074306140778],[37.54386126995086,55.8907550942842],[37.544381618499756,55.89076411893906],[37.5444620847702,55.89076712715686],[37.544424533843994,55.891498117173775]] */
 

                    
// class vc
class ViewController: UIViewController {
    //
    var _drone_route_1 = routes()
    var _drone_route_2 = routes()
    var _drone_route_3 = routes()

    // TableView Properties
    @IBOutlet var polyCount : UILabel!
    @IBOutlet var polyDetec : UILabel!

    @IBOutlet var status: UITextField!

    // MapProperties
    var idArea = 0
    var end_area = ""
    var shape = ""
    var boxik : NMAGeoBoundingBox?

    var polyX = [Double]()
    var polyY = [Double]()
    //
    let zoomLevel : Float = 15
    var index_touch = Int()
    var index_placed = Int()
    // def values
     private var geoBox1 : NMAGeoBoundingBox?
     private var geoPolyline : NMAMapPolyline?
     private var mapCircle : NMAMapCircle?
     var timeNewRoute = Timer()
//     var obj = track_info()
     var arrayObj = [String:Any]()
     public var coordSystemHeli = [NMAGeoCoordinates]()
     public var computeRoute = [NMAGeoCoordinates]()
     var myCordinate = NMAGeoCoordinates()
    //
    var coreRouter: NMACoreRouter!
    //
    var mapRouts = [NMAMapRoute]()
    var progress: Progress? = nil
    //
    var route = [NMAGeoCoordinates]()
    //
        let LeftUp = UIImage(named: "1.png")
        let RightUp = UIImage(named: "2.png")
        let RightDown = UIImage(named: "3.png")
        let LeftDown = UIImage(named: "4.png")
        let drone_ui = UIImage(named: "4.png")
        let waypoint_ui = UIImage(named: "way-x.png")
   
        var objSelect = objectSelectedUsers()
        var arrayObjSelect = [Any]()
    var obj = objpost()
    var locObj = [String:Any]()
    var timeGeoPosition = Timer()
    var timeGeoPositionChild = Timer()
    var timerTeleBus = Timer()
  //  private var mapCircle : NMAMapCircle?
   
    //
   // UIColor(displayP3Red: 0.6, green: 0.8, blue: 1, alpha: 0.6)
    //
    @IBOutlet weak var mapHere: NMAMapView!
   
    let areCheking =
    /*1*/       [NMAGeoCoordinates(latitude: 55.76238, longitude: 37.61084, altitude: 10),
    /*2*/        NMAGeoCoordinates(latitude: 55.75794, longitude: 37.60277, altitude: 10),
    /*3*/        NMAGeoCoordinates(latitude: 55.75040, longitude: 37.60054, altitude: 10),
    /*4*/        NMAGeoCoordinates(latitude: 55.74499, longitude: 37.60723, altitude: 10),
    /*5*/        NMAGeoCoordinates(latitude: 55.74480, longitude: 37.61581, altitude: 10),
    /*6*/        NMAGeoCoordinates(latitude: 55.75137, longitude: 37.61238, altitude: 10),
    /*7*/        NMAGeoCoordinates(latitude: 55.75774, longitude: 37.61908, altitude: 10),
    /*8*/        NMAGeoCoordinates(latitude: 55.75504, longitude: 37.62302, altitude: 10),
    /*9*/        NMAGeoCoordinates(latitude: 55.74837, longitude: 37.63212, altitude: 10),
    /*10*/       NMAGeoCoordinates(latitude: 55.75697, longitude: 37.63521, altitude: 10),
    /*11*/       NMAGeoCoordinates(latitude: 55.76325, longitude: 37.61599, altitude: 10),
    /*12*/       NMAGeoCoordinates(latitude: 55.76238, longitude: 37.61084, altitude: 10)]
    var testRoute = [NMAGeoCoordinates(latitude: 55.89138380688599, longitude: 37.54329800605774),
                      NMAGeoCoordinates(latitude: 55.89074306140778, longitude: 37.5432550907135),
                      NMAGeoCoordinates(latitude: 55.8907550942842, longitude: 37.54386126995086),
                      NMAGeoCoordinates(latitude: 55.89076411893906, longitude: 37.544381618499756),
                      NMAGeoCoordinates(latitude: 55.89076712715686, longitude: 37.5444620847702),
                      NMAGeoCoordinates(latitude: 55.891498117173775, longitude: 37.544424533843994)]
  
    @IBOutlet var alertCard: CardView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.alertCard.backgroundColor = #colorLiteral(red: 0.8823654819, green: 0.8115270822, blue: 0.578507819, alpha: 0.5)
        self.index_touch = 0
        self.index_placed = 1
        self.mapHere.MapInit()
        self.mapHere.gestureDelegate = self
        self.mapHere.mapScheme = NMAMapSchemeHybridDay
        coreRouter = NMACoreRouter()
        // tpos
        NMAPositioningManager.sharedInstance().dataSource = NMAHEREPositionSource()
        NotificationCenter.default.addObserver(self,
                                                selector: #selector(ViewController.didUpdatePosition),
                                                name: NSNotification.Name.NMAPositioningManagerDidUpdatePosition,
                                                object: NMAPositioningManager.sharedInstance())
        let  myPosition = NMAPositioningManager.sharedInstance().currentPosition
        
        self.trackingTimer()
       // self.trackingTimerChild()
        self.zoneObject(id: 1, geo: NMAGeoCoordinates(latitude: 55.79510365474969, longitude: 37.55457465864718), type: "home")
        
         self.zoneObject(id: 2, geo: NMAGeoCoordinates(latitude: 55.80510365474969, longitude: 37.52457465864718), type: "school")
        self.zoneObject(id: 3, geo: NMAGeoCoordinates(latitude: 55.76510365474969, longitude: 37.50457465864718), type: "home")
        self.zoneObject(id: 4, geo: NMAGeoCoordinates(latitude: 55.83510365474969, longitude: 37.49457465864718), type: "school")
        self.zoneObject(id: 5, geo: NMAGeoCoordinates(latitude: 55.82510365474969, longitude: 37.45457465864718), type: "home")
        self.zoneObject(id: 6, geo: NMAGeoCoordinates(latitude: 55.85510365474969, longitude: 37.37457465864718), type: "school")
        self.zoneObject(id: 7, geo: NMAGeoCoordinates(latitude: 55.806611, longitude: 37.652319), type: "school")
        let newArray = [NMAGeoCoordinates(latitude: 55.75223581897627, longitude: 38.03672790527344),
        NMAGeoCoordinates(latitude: 55.74953074789918, longitude: 37.967376708984375),
        NMAGeoCoordinates(latitude: 55.72556335763928, longitude: 38.20976257324219),
        NMAGeoCoordinates(latitude: 55.75146296066621, longitude: 37.89459228515625),
        NMAGeoCoordinates(latitude: 55.7398682484427, longitude: 38.16032409667969),
        NMAGeoCoordinates(latitude: 55.75880449639896, longitude: 38.069000244140625)]
        let drone_route_1 = NMAGeoCoordinates(latitude: 55.7487578359952, longitude: 37.72499084472656)
        let drone_route_2 = NMAGeoCoordinates(latitude: 55.74634238759795, longitude: 37.606201171875)
        let drone_route_3 = NMAGeoCoordinates(latitude: 55.75223581897627, longitude: 37.6226806640625)
        let route_drone_route_1 = [NMAGeoCoordinates(latitude: 55.70274201066954, longitude: 37.606201171875),
        NMAGeoCoordinates(latitude: 55.69732481849101, longitude: 37.61787414550781),
        NMAGeoCoordinates(latitude: 55.68881057085534, longitude: 37.61787414550781),
        NMAGeoCoordinates(latitude: 55.67642290029142, longitude: 37.61787414550781),
        NMAGeoCoordinates(latitude: 55.665580469670985, longitude: 37.621307373046875),
        NMAGeoCoordinates(latitude: 55.66015812760702, longitude: 37.635040283203125),
        NMAGeoCoordinates(latitude: 55.65705930913831, longitude: 37.643280029296875),
        NMAGeoCoordinates(latitude: 55.650086070637734, longitude: 37.65632629394531),
        NMAGeoCoordinates(latitude: 55.63846124636454, longitude: 37.65495300292969),
        NMAGeoCoordinates(latitude: 55.62760829717496, longitude: 37.66456604003906),
        NMAGeoCoordinates(latitude: 55.62799595426723, longitude: 37.657012939453125),
        NMAGeoCoordinates(latitude: 55.62373151534754, longitude: 37.65769958496094),
        NMAGeoCoordinates(latitude: 55.617915623580316, longitude: 37.659759521484375),
        NMAGeoCoordinates(latitude: 55.610547588603886, longitude: 37.6666259765625),
        NMAGeoCoordinates(latitude: 55.60123861794095, longitude: 37.67280578613281),
        NMAGeoCoordinates(latitude: 55.591151406351784, longitude: 37.676239013671875),
        NMAGeoCoordinates(latitude: 55.63846124636454, longitude: 37.65495300292969),
        NMAGeoCoordinates(latitude: 55.62760829717496, longitude: 37.66456604003906),
        NMAGeoCoordinates(latitude: 55.62799595426723, longitude: 37.657012939453125),
        NMAGeoCoordinates(latitude: 55.62373151534754, longitude: 37.65769958496094),
        NMAGeoCoordinates(latitude: 55.617915623580316, longitude: 37.659759521484375),
        NMAGeoCoordinates(latitude: 55.610547588603886, longitude: 37.6666259765625),
        NMAGeoCoordinates(latitude: 55.60123861794095, longitude: 37.67280578613281),
        NMAGeoCoordinates(latitude: 55.591151406351784, longitude: 37.676239013671875)
        ]

        let route_drone_route_2 = [NMAGeoCoordinates(latitude: 55.70274201066954, longitude: 37.606201171875),
        NMAGeoCoordinates(latitude: 55.74634238759795, longitude: 37.61272430419922),
        NMAGeoCoordinates(latitude: 55.74697041856728, longitude: 37.6146125793457),
        NMAGeoCoordinates(latitude: 55.74755013048941, longitude: 37.61693000793457),
        NMAGeoCoordinates(latitude: 55.74803321717797, longitude: 37.61924743652343)]
        let route_drone_route_3 = [NMAGeoCoordinates(latitude: 55.70274201066954, longitude: 37.606201171875),
        NMAGeoCoordinates(latitude: 55.75230827365778, longitude: 37.70413398742676),
        NMAGeoCoordinates(latitude: 55.75199430239924, longitude: 37.70516395568848),
        NMAGeoCoordinates(latitude: 55.75160787276572, longitude: 37.70602226257324),
        NMAGeoCoordinates(latitude: 55.75112483034055, longitude: 37.706923484802246)]
         _drone_route_1 = routes(id: 1, coordinates: route_drone_route_1)
          _drone_route_2 = routes(id: 2, coordinates: route_drone_route_2)
         _drone_route_3 = routes(id: 3, coordinates: route_drone_route_3)
        arrayBusMove.append(self.drone(drone_route_1,_drone_route_2))
        arrayBusMove.append(self.drone(drone_route_2,_drone_route_2))
        arrayBusMove.append(self.drone(drone_route_3,_drone_route_1))
   self.routeBusDraw()
   self.timerTelematics()
       // for arr in newArray {
       //     self.drone(arr, testRoutes)
       // }
    //    for point in testRoute {
    //          arrayARObject.append(point)
    //    }
        //55.807830, 37.656263
        //55.806611, 37.652319
    }

    
    @IBAction func first_user(_ sender: Any) {
        id_user = 1
    }
    @IBAction func two_user(_ sender: Any) {
        id_user = 2
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        progress?.cancel()
    }
    @IBOutlet var Label_button: UIButton!
    @IBOutlet var drawPoly: UIButton!
    @IBOutlet var drawCircle: UIButton!
    @objc func didUpdatePosition() {
       guard let position = NMAPositioningManager.sharedInstance().currentPosition,
           let coordinates = position.coordinates else {
               return
       }
   }
  @objc  func TrackingMyPosition() {
    var cerror: String = "empty"
    if NMAPositioningManager.sharedInstance().currentPosition?.coordinates != nil {
    //         let networkInfo = CTTelephonyNetworkInfo()
            //
           /*     if #available(iOS 11.0, *) {
                    let back_info = networkInfo.serviceSubscriberCellularProviders
                    //print(back_info)
                }
                else {
                    let back_info = networkInfo.subscriberCellularProvider
                    //print(back_info)
                }
            //
            let radio_info = networkInfo.serviceCurrentRadioAccessTechnology
            let level_info = radio_info?.values
            for name_carrier in level_info! {
            cerror = name_carrier
            }
                    if cerror == "CTRadioAccessTechnologyLTE" {
        //                print("CTRadioAccessTechnologyLTE")
                    } else if cerror == "CTRadioAccessTechnologyWCDMA" {
        //                print("CTRadioAccessTechnologyWCDMA")
                    } else if cerror == "CTRadioAccessTechnologyEdge" {
        //                print("CTRadioAccessTechnologyEdge")
                    } */
            obj.cellor = cerror
            let latTracking = NMAPositioningManager.sharedInstance().currentPosition?.coordinates?.latitude
            let lonTracking = NMAPositioningManager.sharedInstance().currentPosition?.coordinates?.longitude
            obj.latitude = latTracking!
            obj.longitude = lonTracking!
            //
        if last.latitude != 0 && last.longitude != 0 {
            let diff = distanceGeo(pointA: NMAGeoCoordinates(latitude: obj.latitude, longitude: obj.longitude), pointB: NMAGeoCoordinates(latitude: last.latitude, longitude: last.longitude))
            if diff > 2000 || diff < 2000 {
              //  mapHere.set(geoCenter: NMAGeoCoordinates(latitude: obj.latitude, longitude: obj.longitude), animation: .linear )
            }
        }
            //
            last.latitude = obj.latitude
            last.longitude = obj.longitude
            
            arrayObj["latitude"] = obj.latitude as Double
            arrayObj["longitude"] = obj.longitude as Double
            arrayObj["cellor"] = obj.cellor
            self.createCircle(geoCoord: NMAGeoCoordinates(latitude:  arrayObj["latitude"] as! Double, longitude: arrayObj["longitude"] as! Double), color: UIColor.green, rad: Int(2.5))
//         post(url: "https://servchild.vapor.cloud/api/location/live", parametrs: arrayObj)

       var statusL = ckeckPoint(checkPoint: NMAGeoCoordinates(latitude: arrayObj["latitude"] as! Double, longitude: arrayObj["longitude"] as! Double))
        print("\(statusL) - ptmp")
        
        if statusL!.status == true {
            self.alertCard.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
            if (self.alertCard.isHidden == true) {
                self.alertCard.isHidden = false
            } else {
                self.alertCard.isHidden = true
            }
        } else {
             self.alertCard.backgroundColor = #colorLiteral(red: 0.8823654819, green: 0.8115270822, blue: 0.578507819, alpha: 0.5)
        }
        polyDetec.text! = "\(statusL!.id_obj) - \(statusL!.status)"
     //       print(arrayObj)
           
    }
}
    @objc  func TrackingChildPosition() {
        getLive()
    }
    @objc func telematiksBus() {
       //self.timerTelematics()
              arrayBus.removeAll()
              // add new pos drone
              for i in 0...arrayBusMove.count - 1  {
                  self.moveBusic(arrayBusMove[i], i)
              }
              self.routeBusDraw()
    }
    func timerTelematics() {
    timerTeleBus.invalidate()
    timerTeleBus = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: Selector("telematiksBus"), userInfo: nil, repeats: true)
    }
    func moveBusic(_ input_drone : NMAMapMarker, _ idx : Int) {
        self.clear_drone(input_drone)
        let lat = input_drone.coordinates.latitude
        let lon = input_drone.coordinates.longitude
        arrayBusMove[idx] = self.drone(NMAGeoCoordinates(latitude: lat + 0.00025, longitude: lon + 0.00015), _drone_route_2)
    }
    @IBAction func StartPoly(_ sender: Any)
    {
        let colorPoly = #colorLiteral(red: 0.7450980392, green: 0.3098039216, blue: 0.3215686275, alpha: 0.65)
        let button = sender as! UIButton
        if button == drawPoly {
            if button.currentTitle == "Draw Poly" {
                   end_area = "start"
                   shape = "poly"
                   button.setTitle("Draw Finish", for: .normal)
                   } else if button.currentTitle == "Draw Finish"{
                   button.setTitle("Draw Poly", for: .normal)
                   end_area = "end"
                   shape = "poly"
                      //
                       //arrayObjSelect.append(objSelect)
                       //arrayObjSelect as! [objectSelectedUsers]
                       objSelect.frame = array_area.frame_area
                       let last =  array_area.frame_area[0]
                       array_area.frame_area.append(last)
                       //arrayObjSelect.append(array_area.frame_area)
                       objSelect.id = arrayObjSelect.count + 1
                       objSelect.header = "no way this zone"
                      // objSelect.frame = array_area.frame_area//arrayObjSelect as! [NMAGeoCoordinates]
                       arrayObjSelect.append(objSelect)
                       arrayObjSelect as! [objectSelectedUsers]
                       polyCount.text! = "Poly in map : \(arrayObjSelect.count)"
                       print(arrayObjSelect)
                    self.createPolyline(CTR: array_area.frame_area, colorPoly, 3)
                //
              
                //
                    self.drawPolygonInMap(array_area.frame_area)
                    print(array_area.frame_area)
                    array_area.frame_area.removeAll()
                   }
        } else if button == drawCircle {
            if button.currentTitle == "Draw Circle" {
            end_area = "start"
            shape = "circle"
            button.setTitle("Draw Finish", for: .normal)
            } else if button.currentTitle == "Draw Finish"{
            button.setTitle("Draw Circle", for: .normal)
            end_area = "end"
            shape = "circle"
        }
    }
}
    @IBAction func postPoly(_ sender: Any) {
      //  post(url: "https://servchild.vapor.cloud/api/location/polygon", parametrs: locObj)
  //      print("f")
    }
    @IBAction func setMyPos(_ sender: Any) {
        let latTracking = (NMAPositioningManager.sharedInstance().currentPosition?.coordinates?.latitude)!
        let lonTracking = NMAPositioningManager.sharedInstance().currentPosition?.coordinates?.longitude
        self.mapHere.set(geoCenter: NMAGeoCoordinates(latitude: latTracking, longitude: lonTracking!), zoomLevel: 15, orientation: 35, tilt: 0, animation: .none)//(geoCenter: NMAGeoCoordinates(latitude: latTracking, longitude: lonTracking!), animation: .none)
        self.findIntersectionOfCircle()
    }
    @IBAction func drawZone(_ sender: Any) {
        self.getLive()
    }
    @IBAction func startMoveBus(_ sender: Any) {
       self.timerTelematics()
        /*arrayBus.removeAll()
        // add new pos drone
        for ts in arrayBusMove {
            self.moveBusic(ts)
        }
        arrayBusMove.removeAll()
        self.routeBusDraw() */
    }
    @IBAction func getPoint(_ sender: Any) {
        let image = "https://image.maps.api.here.com/mia/1.6/mapview?app_id=0ZZSBa9QPnfBc8zgJC1p&app_code=R7UJ1isf9yaZLiV058KZoQ&lat=55.86&lon=38.402277&vt=0&z=15"
     //   getImage(url: image)
    }
    @IBAction func selectTypeDraw(_ sender: Any)
    {
        self.DrawZone.isHidden = true
        self.typeDrawZone.isHidden = false
    }
    @IBOutlet var DrawZone: CardView!
    @IBOutlet var typeDrawZone: CardView!
}

extension NMAMapView : quaklyInit {
    // MARK 1
    func MapInit() {
        self.copyrightLogoPosition = NMALayoutPosition.bottomLeft
        self.orientation = 35
        self.mapScheme = NMAMapSchemeNormalDay
        self.positionIndicator.isVisible = true
        let geoCoodCenter = NMAGeoCoordinates(
        latitude: 55.812619,
        longitude: 37.572213)
        self.set(geoCenter: geoCoodCenter, animation: .none)
    }
}
extension ViewController {
     
    public func createCircle(geoCoord : NMAGeoCoordinates, color : UIColor,rad : Int) {
        //create NMAMapCircle located at geo coordiate and with radium in meters
        mapCircle = NMAMapCircle(geoCoord, radius: Double(rad))
        //set fill color to be gray
        mapCircle?.fillColor = color
        //set border line width.
        mapCircle?.lineWidth = 12;
        //set border line color to be red.
        mapCircle?.lineColor = color
        //add Map Circel to map view
        
        _ = mapCircle.map{ mapHere.add(mapObject: $0)
        
        }
    }
func trackingTimer() {
    timeGeoPosition.invalidate()
    timeGeoPosition = Timer.scheduledTimer(timeInterval: 0.8, target: self, selector: Selector("TrackingMyPosition"), userInfo: nil, repeats: true)
    }
    func trackingTimerChild() {
    timeGeoPositionChild.invalidate()
        timeGeoPositionChild = Timer.scheduledTimer(timeInterval: 0.6, target: self, selector: "TrackingChildPosition", userInfo: nil, repeats: true)
    }
}
extension ViewController {
    // draw segment Line
    public func createPolyline(CTR : [NMAGeoCoordinates],_ color : UIColor , _ width : Int) -> NMAMapPolyline {
        // add animation
        let animationGroup = CAAnimationGroup.init()
        
        // cleanup()
        //create a NMAGeoBoundingBox with center gec coordinates, width and hegiht in degrees.
        geoBox1 = NMAGeoBoundingBox(coordinates: CTR)
        geoPolyline = geoBox1.map{ _ in NMAMapPolyline(vertices: CTR) }
        //set border line width in pixels
        geoPolyline?.lineWidth = UInt(width);
        //set border line color to be red
        geoPolyline?.lineColor = color//UIColor(displayP3Red: 0.6, green: 0.8, blue: 1, alpha: 0.6)
        //add NMAMapPolyline to map view
        
        _ = geoPolyline.map { mapHere?.add(mapObject: $0) }
        return geoPolyline!
    }
    // draw polygon
    public func drawPolygonInMap(_ points : [NMAGeoCoordinates]) {
        let polygonDraw = drawPolygonWithPoints(centrBox: points)
        polygonDraw.map{mapHere.add(mapObject: $0)}
    }
    // draw label object
    public func drawLabel(_ GeoCoord : NMAGeoCoordinates,_ Text : String) {
        var leb = UILabel(frame: CGRect(x: 0, y: 0, width: 120, height: 60))
                   leb.text = Text
                   leb.textColor = UIColor.brown
                   let label = NMAMapOverlay(leb, GeoCoord)
                   self.mapHere.add(mapOverlay: label)
        
    }
    // draw route with segment
    func LineRoute(_ points : [NMAGeoCoordinates],_ color : UIColor) -> [NMAMapPolyline] {
        var array = [NMAMapPolyline]()
        let mainLine = self.createPolyline(CTR:points, color, 20)
        let subLine = self.createPolyline(CTR:points, UIColor.black, 4)
        array.append(mainLine)
        array.append(subLine)
        return array
    }
}
extension ViewController : NMAMapGestureDelegate {
    // add touch in map and draw rote to point
    func mapView(_ mapView: NMAMapView, didReceiveLongPressAt location: CGPoint) {
   //     print("location :\(String(describing: mapView.geoCoordinates(from: location)))")
        if detected != "Delete" {
        let alert = UIAlertController(title: "location", message: "\(String(describing: mapView.geoCoordinates(from: location)))", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Построить маршрут", style: .default) { (_) -> Void in
            let latLocal = mapView.geoCoordinates(from: location)!.latitude
            let lonLocal = mapView.geoCoordinates(from: location)!.longitude
            self.route.append(NMAGeoCoordinates(latitude: latLocal, longitude: lonLocal))
            //self.zoneObject(id: self.index_placed, geo: NMAGeoCoordinates(latitude: latLocal, longitude: lonLocal,altitude: 1), type: "home-button-for-interface 1.png")
           // print(self.route)
            //mapView.onMapObjectSelected(latLocal, lonLocal)
            self.routeChild((Any).self)
            self.index_placed += 1
        }
        let canceledAction = UIAlertAction(title: "Отменить", style: .cancel) {
            (_) -> Void in
        }
        alert.addAction(saveAction)
        alert.addAction(canceledAction)
        self.present(alert, animated: true, completion: nil)
    } //
        else {
            let getObject = mapHere.objects(at: location)
                   print("get object : \(getObject)")
                   if getObject != [] {
                       print("delete \(getObject)")
                    //getObject.removeAll()
                    mapView.remove(mapObjects: getObject as! [NMAMapObject])
                   }
        }
    }
    //
    //
    func drone(_ positionBus : NMAGeoCoordinates, _ routes : routes) -> NMAMapMarker {
        let drone = NMAMapMarker(geoCoordinates:  positionBus/*NMAGeoCoordinates(latitude: 55.79061793745191, longitude: 38.4369134902954)*/, image: drone_ui!)
   //     drone.setSize(CGSize(width: 40, height: 40), forZoomLevel: UInt(15))
      //  drone.setSize(CGSize(width: 10, height: 10), forZoomRange: NSRange(location: 5,length: 20))
        drone.resetIconSize()
        drone.setSize(CGSize(width: 10, height: 10), forZoomRange: NSRange(location: 5,length: 20))
        let id = Int(drone.uniqueId())
        var obj = drone_(id: id, stop: testStops, route: routes, coordinate: positionBus)
        print(obj)
        arrayBus.append(obj)
        self.mapHere.add(mapObject: drone)
        return drone
    }
    func clear_drone(_ object :NMAMapMarker) {
        mapHere.remove(mapObject: object)
    }
    //
    // MARK Draw route drone
    func routeBusDraw() {
    for objStructArray in arrayBus {
        let bRoute = #colorLiteral(red: 0.8549019608, green: 0.6769049658, blue: 0.8281600022, alpha: 0.75)
        let polyArray = self.LineRoute(objStructArray.route.coordinates, bRoute)
        let polys = poly_struct(id : objStructArray.id,poly : polyArray)
        arrayPolys.append(polys)
        polys.poly[0].isVisible = false
        polys.poly[1].isVisible = false
    }
}
    func mapView(_ mapView: NMAMapView, didReceiveTapAt location: CGPoint) {
        
        guard let pTemp = self.ckeckPoint(checkPoint: mapView.geoCoordinates(from: location)!) else {return}
        print("\(pTemp) - ptmp")
        polyDetec.text! = "\(pTemp.id_obj) - \(pTemp.status)"
        //
       
            let objStruct = mapHere.objects(at: location)
            print("get object : \(objStruct)")
            if objStruct != [] {
                print(objStruct)
                for get in objStruct {
                        guard let mark = get as? NMAMapMarker else {return}
                        for objStructArray in arrayBus {
                        print(objStructArray.id)
                        print(Int(mark.uniqueId()))
                        if Int(mark.uniqueId()) == objStructArray.id  {
                            for pol in arrayPolys {
                                print(pol.id)
                                print(objStructArray.id)
                                print("stop")
                                if pol.id == objStructArray.id {
                                    pol.poly[0].isVisible = true
                                    pol.poly[1].isVisible = true
                                    break
                                }// else {
                                 //   pol.poly[0].isVisible = false
                                   // pol.poly[1].isVisible = false
                               // }
                        }
                    }
                }
            }
            } else {
                for pol in arrayPolys {
                    pol.poly[0].isVisible = false
                    pol.poly[1].isVisible = false
                }
        }
    }
        
       
    // *LongPress* touch to detected point in poly
       
    func mapView(_ mapView: NMAMapView, didReceiveDoubleTapAt location: CGPoint) {
        
        var getCoordinate = mapView.geoCoordinates(from: location)
       
        if end_area == "start" && shape == "poly" {
        array_area.frame_area.append(getCoordinate!)
        let pointColor = #colorLiteral(red: 0.8644338001, green: 0.3671671473, blue: 0.6680456927, alpha: 0.653884243)
        let plineColor = #colorLiteral(red: 0.8644338001, green: 0.3671671473, blue: 0.6680456927, alpha: 0.653884243)
        self.createCircle(geoCoord: getCoordinate!, color: pointColor, rad: 2)
            
            createPolyline(CTR: array_area.frame_area, plineColor, 5)
            let waypoint = NMAMapMarker(geoCoordinates: getCoordinate!, image: waypoint_ui!)
                                      // print("Marker coordinates : \(leftUp.coordinates)")
            self.mapHere.add(mapObject: waypoint)
        } else if end_area == "end" && shape == "poly" {
        if array_area.frame_area != nil {
            }} else if end_area == "start" && shape == "circle" {
            let pointColorCenter = #colorLiteral(red: 0.1612316361, green: 0.3431667361, blue: 0.8644338001, alpha: 0.653884243) //colorObject
            let areaColor = #colorLiteral(red: 0.8024802703, green: 0.6241669053, blue: 0.05677067874, alpha: 0.653884243)
/*circle */
          self.createCircle(geoCoord: getCoordinate!, color: pointColorCenter, rad: 2)
          self.createCircle(geoCoord: getCoordinate!,
                  color: areaColor,rad: 500)
        let colorPoint = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 0.5)
        let colorPoint_other = #colorLiteral(red: 0.7450980544, green: 0.3117482386, blue: 0.3231185398, alpha: 1)
        let Cx = getCoordinate?.latitude
        let Cy = getCoordinate?.longitude
        let radius = 100.0
        let toRad = Double.pi/180 //M_PI
        let newX = radius*cos(90.0*toRad) + Cx!
        let newY = radius*sin(90.0*toRad) + Cy!
      //  let AZIMUT = 90.0
        let Degress = [0,45,90,135,180,225,270,315,360]
        for AZIMUT in 0...360/*Degress*/ {
            if AZIMUT%5 == 0 {
                let LAT1 = Cx!+radius*cos(Double(AZIMUT) * M_PI / 180)/(6371000 * M_PI / 180)
                let LON1 = Cy!+radius*sin(Double(AZIMUT) * M_PI / 180)/cos(Cx! * M_PI / 180) / (6371000/*6371000*/ * M_PI / 180)
                let coord = NMAGeoCoordinates(latitude: LAT1, longitude: LON1)
                self.createCircle(geoCoord: coord,color: colorPoint,rad: Int(1))
                dropCircle.frame_area.append(coord)
            }
        }
        var compass = [0,90,180,270]
            for bearing in compass {
                let LAT1 = Cx!+radius*cos(Double(bearing) * M_PI / 180)/(6371000 * M_PI / 180)
                let LON1 = Cy!+radius*sin(Double(bearing) * M_PI / 180)/cos(Cx! * M_PI / 180) / (6371000/*6371000*/ * M_PI / 180)
            let pointStrip = NMAGeoCoordinates(latitude: LAT1, longitude: LON1)
            let stripBearing = [getCoordinate,pointStrip]
                 let color_N = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
                 let color_E = #colorLiteral(red: 0.1529411765, green: 0, blue: 1, alpha: 1)
                 let color_S = #colorLiteral(red: 0, green: 0.6039215686, blue: 0.2666666667, alpha: 1)
                 let color_W = #colorLiteral(red: 0.8901960784, green: 0.4784313725, blue: 0.09019607843, alpha: 1)
                 if bearing == 0 {
                    self.createPolyline(CTR: stripBearing as! [NMAGeoCoordinates], color_N, 3)} else if bearing == 90 {
                    self.createPolyline(CTR: stripBearing as! [NMAGeoCoordinates], color_E, 3)} else if bearing == 180 {
                    self.createPolyline(CTR: stripBearing as! [NMAGeoCoordinates], color_S, 3)} else if bearing == 270 {
                    self.createPolyline(CTR: stripBearing as! [NMAGeoCoordinates], color_W, 3)}
            }
            let pointSecond = self.firstGeoTask(getCoordinate!, radius + 10, 45)
            self.createCircle(geoCoord: pointSecond,color: colorPoint_other,rad: Int(1))
        objSelect.id = arrayObjSelect.count + 1
        objSelect.header = "\(objSelect.id) - zone draw"
        objSelect.frame = dropCircle.frame_area
        arrayObjSelect.append(objSelect)
        arrayObjSelect as! [objectSelectedUsers]
        self.drawLabel(getCoordinate!, objSelect.header)
        var tempDrop = [NMAGeoCoordinates]()
            for i in 0...dropCircle.frame_area.count - 1 {
           //     print(dropCircle.frame_area.count - 1)
                if i > 22 && i < 55 {
                dropCircle.frame_area[i] = NMAGeoCoordinates(latitude: 0, longitude: 0)
                }
                if dropCircle.frame_area[i].latitude == 0 && dropCircle.frame_area[i].longitude == 0 {/*dropCircle.frame_area.remove(at: i)*/
                } else {tempDrop.append(dropCircle.frame_area[i])}
            }
        print("= = = \n \(dropCircle.frame_area)")
        self.drawPolygonInMap(tempDrop)
        dropCircle.frame_area.removeAll()
        } else {
        offsetPoint = getCoordinate!
            if offsetPoint != nil {
                let colorObject = #colorLiteral(red: 0.1612316361, green: 0.3431667361, blue: 0.8644338001, alpha: 0.653884243) //
                self.createCircle(geoCoord: offsetPoint!,color: colorObject,rad: Int(1))
                arrayARObject.append(offsetPoint!)
                offsetPoint = NMAGeoCoordinates(latitude: offsetPoint!.latitude, longitude: offsetPoint!.longitude, altitude: 10)
                let movePoint = self.findDirection(offsetPoint!,45)
                let vectorDirection = [offsetPoint,movePoint]
                //self.createPolyline(CTR: vectorDirection as! [NMAGeoCoordinates])
                print(vectorDirection)
                print(arrayARObject)
            }
        }
     //   self.mapHere.set(geoCenter: NMAGeoCoordinates(latitude: newX, longitude: newY), zoomLevel: 10, orientation: 35, tilt: 0, animation: .none)
    
}
    func mapView(_ mapView: NMAMapView, didReceiveTwoFingerTapAt location: CGPoint) {
        let getObject = mapHere.objects(at: location)
        print("get object : \(getObject)")
        if getObject != [] {
            print("delete \(getObject)")
        }
    }
    // *LongPress* touch to detected point in poly
}
extension ViewController {
    class circle {
        var id : Int
        var radius : Double
        var centr : NMAGeoCoordinates
        init(id : Int,radius : Double,centr : NMAGeoCoordinates) {
            self.id = id
            self.radius = radius
            self.centr = centr
        }
    }

   public func distanceGeo(pointA : NMAGeoCoordinates,pointB : NMAGeoCoordinates) -> Double {
       let toRad = Double.pi/180
       let radial = acos(sin(pointA.latitude*toRad)*sin(pointB.latitude*toRad) + cos(pointA.latitude*toRad)*cos(pointB.latitude*toRad)*cos((pointA.longitude - pointB.longitude)*toRad))
       let R = 6378.137//6371.11
       let D = (radial*R)*1000
       return D
   }
   public func findIntersectionOfCircle () {
        let colorPoint = #colorLiteral(red: 0.6981174897, green: 0.4388248936, blue: 0.6222423526, alpha: 0.2925836268)
        let interSecColor = #colorLiteral(red: 0.5, green: 0.08908936289, blue: 0.1093035199, alpha: 0.3674900968)
        let lineinterc = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        let circle1 = circle(id: 1, radius: 30.0, centr: NMAGeoCoordinates(latitude: 55.791065, longitude: 38.438890))
        let circle2 = circle(id: 2, radius: 60.0, centr: NMAGeoCoordinates(latitude: 55.790375, longitude: 38.438957))
        self.createCircle(geoCoord: circle1.centr,color: colorPoint,rad: Int(circle1.radius))
        self.createCircle(geoCoord: circle2.centr,color: colorPoint,rad: Int(circle2.radius))
    self.createPolyline(CTR: [circle1.centr,circle2.centr], lineinterc, 2)
        //Calculate distance between centres of circle 55.791065; longitude = 38.438890
        let d =  distanceGeo(pointA: circle1.centr, pointB: circle2.centr)  // round(km*1000)/1000
       // let d = (round(L*1000*100)/100)
        let c1r = circle1.radius
        let c2r = circle2.radius
        let m = c1r + c2r;
        var n = c1r - c2r;
        if (n < 0) { n = n * -1;}
        //No solns
        if (d > m) {return}
        //Circle are contained within each other
        if (d < n) {return}
        //Circles are the same
        if (d == 0 && c1r == c2r) {return}
        //Solve for a
        let a = (c1r * c1r - c2r * c2r + d * d )/(2 * d)
        //Solve for h
        let h = sqrt(c1r*c1r - a*a)//pow((c1r*c1r-a*a),0.5)
        //Calculate point p, where the line through the circle intersection points crosses the line between the circle centers.
        let subV1 = (2*Double.pi*6371000*cos(circle1.centr.latitude))/360
        let subV2 = (2*Double.pi*6371000)/360
        let p = NMAGeoCoordinates()
        p.latitude =
            circle1.centr.latitude+(a/d)*((circle2.centr.latitude-circle1.centr.latitude)/**subV2*/)
        p.longitude =
            circle1.centr.longitude+(a/d)*((circle2.centr.longitude-circle1.centr.longitude)/**subV1*/)
        //1 soln , circles are touching
        if (d==c1r + c2r) {return}
        //2solns
       let p1 = NMAGeoCoordinates()
       let p2 = NMAGeoCoordinates()
        p1.latitude =
            p.latitude+(h/d)*((circle2.centr.longitude-circle1.centr.longitude)/**subV1*/)
        p1.longitude =
            p.longitude-(h/d)*((circle2.centr.latitude-circle1.centr.latitude)/**subV2*/)
        p2.latitude =
            p.latitude-(h/d)*((circle2.centr.longitude-circle1.centr.longitude)/**subV1*/)
        p2.longitude =
            p.longitude+(h/d)*((circle2.centr.latitude-circle1.centr.latitude)/**subV2*/)
        self.createCircle(geoCoord: p1,color: interSecColor,rad: Int(2))
        self.createCircle(geoCoord: p2,color: interSecColor,rad: Int(2))
    }
    public func findDirection(_ startPoint : NMAGeoCoordinates, _ aizmutDirection : Double) -> NMAGeoCoordinates {
        let deltaLat = cos(aizmutDirection)
        let deltaLon = sin(aizmutDirection)
        let direction = [deltaLat,deltaLon]
        let fromLat = startPoint.latitude
        let fromLon = startPoint.longitude
        let endPoint = NMAGeoCoordinates(latitude: fromLat + deltaLat, longitude: fromLon + deltaLon,altitude : 20)
        return endPoint
    }
    public func firstGeoTask(_ firstPoint : NMAGeoCoordinates, _ deltaMetr : Double, _ directionRotate : Double) -> NMAGeoCoordinates {
        let toRad = Double.pi/180
        let Re = 6371000
        let deltaX = deltaMetr * cos(directionRotate*toRad)/(Double(Re)*toRad)
        let deltaY = deltaMetr * sin(directionRotate*toRad)/cos(firstPoint.latitude*toRad)/(Double(Re)*toRad)
        let newX = firstPoint.latitude + deltaX
        let newY = firstPoint.longitude + deltaY
        let secondPoint = NMAGeoCoordinates(latitude: newX, longitude: newY)
        return secondPoint
    }
}

extension ViewController {
    func getLive() {
     //   if NMAPositioningManager.sharedInstance().currentPosition?.coordinates != //nil {
  //      get(url: "https://servchild.vapor.cloud/api/location/live")
    //    }
    }
    @IBAction func changeShema(_ sender: Any){
       self.mapHere.mapScheme = NMAMapSchemeNormalDay;
       }
}

