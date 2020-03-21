//
//  readJs.swift
//  Sky.Tech-Route.Rebuild
//
//  Created by Артем Стратиенко on 18/08/2019.
//  Copyright © 2019 Артем Стратиенко. All rights reserved.
//

import Foundation

// start time
let startTime = NSDate().timeIntervalSince1970
//
var limit = 300000;
var sizeAIXMMessage = Int()
var dataAIXMMessage = String()//NSData()
var _fileManager = FileManager()
var _pathForFile = String()
var aixm_succes = CheckDirectoryAsterix()
var aixm = String()
var aixm_mod = String()
var export_aixm_s : Data? = nil
var export_aixm_d : Data? = nil
var arrayIndex = [Int]()

//===============================================================================================
//===============================================================================================
func _initCheckDirectory (_ file : String) -> String {
    _fileManager = FileManager()
    // create object FileManager
    _pathForFile = "/Users/brazilec22/{Хакатон}/sky.tech/json_data"
    // create path to AIXM file's
    
    let _file = file//"vrp.json"
    // using class CheckDirectory
    aixm_succes = CheckDirectoryAsterix(_fileManager, _pathForFile, _file)
    let directoryWithFiles = aixm_succes.checkDirectory(fileName: _file) ?? "Empty"
    //print(directoryWithFiles)
    let path = (aixm_succes.dirWFile as NSString).appendingPathComponent(directoryWithFiles)
    print(path)
    export_aixm_s = _fileManager.contents(atPath: path)
    export_aixm_d = (NSData(contentsOfFile: path)! as Data)
    do {
        dataAIXMMessage = try String(contentsOfFile: path)//NSData(contentsOfFile: path)
        sizeAIXMMessage = dataAIXMMessage.count ;
        print("Вывод длины строки NSData = \(sizeAIXMMessage)")
    }
    catch let error as NSError
    {
        print("there is an file reading error: \(error)")
    }
    return dataAIXMMessage
}
