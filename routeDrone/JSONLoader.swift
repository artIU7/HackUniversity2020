//
//  JSONLoader.swift
//  here_sdk_use
//
//  Created by Артем Стратиенко on 28/07/2019.
//  Copyright © 2019 Артем Стратиенко. All rights reserved.
//

import Foundation
import Alamofire

protocol JSONLoad {
    var numberPost : Int {get}
    var API_URL:String{get}
    var parameters:[String:String]{get}
    var headerParameters:[String:String]{get}
    func loadData(API_URL : String)
}
class LoadJSONData : JSONLoad {
    // variable
    var API_URL = String()
    var parameters = [String:String]()
    var headerParameters = [String:String]()
    var numberPost : Int = 1
    // method
func loadData(API_URL: String) {
    //self.numberPost = numberPost
    self.API_URL  = API_URL /*+ String(numberPost)*/ // "http://jsonplaceholder.typicode.com/posts/" + String(numberPost)
    /*http://cre.api.here.com/2/overlays/upload.json
     ?map_name=OVERLAYBLOCKROAD
     &overlay_spec=[{"op":"override","shape":[[50.10765,8.68774],[50.10914,8.68771]],"layer":"LINK_ATTRIBUTE_FCN","data":{"VEHICLE_TYPES":"0"}}]
     &storage=readonly
     &app_id={YOUR_APP_ID}
     &app_code={YOUR_APP_CODE}*/
    parameters = ["?map_name":"",
                  "&overlay_spec":"",
                  "&storage":"",
                  "&app_id":"",
                  "&app_code":""]
    headerParameters = ["HEADER":"JSON"]
    print(parameters)
    //
    }
    func loadJSONGeoCoder() {
        let app_id = "0ZZSBa9QPnfBc8zgJC1p"
        let app_code = "R7UJ1isf9yaZLiV058KZoQ"
        let query = "Moscow"
        let geocoder = "http://autocomplete.geocoder.api.here.com/6.2/suggest.json"+"?app_id=\(app_id)"+"&app_code=\(app_code)"+"&query=\(query)"+"&beginHighlight=<b>"+"&endHighlight=</b>"
        //
    }
}

