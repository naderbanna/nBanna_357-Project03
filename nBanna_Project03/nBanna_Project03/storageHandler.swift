//
//  storageHandler.swift
//  nBanna_Project03
//
//  Created by Nader Banna on 3/15/21.
//

import Foundation

struct storageHandler {
    static var defaultStorage: UserDefaults = UserDefaults.standard
    static let defaultDict: String = "BasicDictStorage"
    static let storedDict: [String: String] = ["website": "password"]
    
    static func setStorage(object: [String: String]){
        defaultStorage.set(object, forKey: self.defaultDict)
    }
    
    static func getStorage() -> [String: String]{
        if let storedDict = defaultStorage.object(forKey: self.defaultDict) as? [String: String]{
            return storedDict
        }else{
            return [:]
        }
    }
}
