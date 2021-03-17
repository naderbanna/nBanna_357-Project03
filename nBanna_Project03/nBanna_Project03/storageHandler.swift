//
//  storageHandler.swift
//  nBanna_Project03
//
//  Created by Nader Banna on 3/15/21.
//

import Foundation

struct storageHandler {
    static var defaultStorage: UserDefaults = UserDefaults.standard
    static let defaultKey = "BasicStringStorage"
    
    static func setStoraage(input: [String]){
        defaultStorage.set(input, forKey: self.defaultKey)
    }
    
    static func getStorage() -> [String]{
        if let storedWords = defaultStorage.stringArray(forKey: self.defaultKey){
            return storedWords
        }else{
            return []
        }
    }
}
