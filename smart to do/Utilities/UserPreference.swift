//
//  UserPreference.swift
//  smart to do
//
//  Created by Asif Reddot on 25/2/24.
//

import Foundation

public enum UserPreferenceAppInfoData: String {
    case userId
}

public class UserPreference {
    public static let shared = UserPreference()
    public let userPreference: UserDefaults
    
    public init() {
        userPreference = UserDefaults.standard
    }
    
    //MARK: Set value
    public func setIntForKey(_ value:Int, key:String) {
        if key.isEmpty {return}
        userPreference.set(value, forKey: key)
    }
    
    public func setCustomObject<T: Encodable>(_ object: T?, forKey key: String, completion: @escaping(_ success: Bool) -> Void) {
        do {
            let encoded = try PropertyListEncoder().encode(object)
            userPreference.set(encoded , forKey:key)
            userPreference.synchronize()
            completion(true)
            
        } catch {
            completion(false)
        }
    }
    
    //MARK: Get value
    public func getIntForKey(_ key:String) -> Int {
        if let value = userPreference.value(forKey: key) as? Int? {
            return value ?? 0
        }
        return 0
    }
    
    public func getCustomObject<T: Decodable>(forKey key: String) -> T? {
        guard let data = userPreference.data(forKey: key) else {
            return nil
        }
        let decodedData = try? PropertyListDecoder().decode(T.self, from: data)
    
        return decodedData
    }
    
    public func deleteObject(forKey key: String) {
        userPreference.removeObject(forKey: key)
    }
}
