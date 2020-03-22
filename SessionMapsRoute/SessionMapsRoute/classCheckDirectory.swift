//
//  classCheckDirectory.swift
//  SessionMapsRouting
//  
//

import Foundation

class CheckDirectoryAsterix {
    
        var fileManager = FileManager()
        var dirWFile = ""
        var fileName = ""
 // func 1
    func checkDirectory(fileName : String) -> String? {
        /*var _ : Bool = false*/
            do
            {
                //fileName = self.fileName
                let filesInDirectory = try fileManager.contentsOfDirectory(atPath: dirWFile)
                let files = filesInDirectory
                var indexFile : Int?
//                print(files.description)
                //
                if files.count > 1 {
                    for i in 0...files.count - 1 {
                        if files[i] == fileName/*"in.stream"*/ {
                            indexFile = i
                        }
                    }
                    if indexFile != nil {
                        print("\(fileName) found")
                        return files[indexFile!]
                    }
                    else
                    {
                         print("\(fileName) not a found")
                        return nil
                    }
                } else {return files.first}
                //
               // print("count files = \(files.count)");
                //
            }
            catch let error as NSError  {
                
                print(error)
            }
            return nil
    }

// create  init(f,d,fn)

    init(_ _file_manger: FileManager,_ _path: String,_ _name: String){
        self.fileManager = _file_manger
        self.dirWFile = _path
        self.fileName = _name

    }
    init(){
        
    }

}
