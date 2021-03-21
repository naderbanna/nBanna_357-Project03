//
//  storageHandler.swift
//  nBanna_Project03
//
//  Created by Nader Banna on 3/15/21.
//

import Foundation

struct storageHandler {
    static var defaultStorage: UserDefaults = UserDefaults.standard
    static let defaultDict: String = "BasicStringStorage"
    
    static func setStorage(object: [String: String]){
        defaultStorage.set(object, forKey: self.defaultDict)
    }
    
    static func getStorage() -> [String: String]{
        if let storedWords = defaultStorage.object(forKey: self.defaultDict){
            return storedWords
        }else{
            return [:]
        }
    }
}
