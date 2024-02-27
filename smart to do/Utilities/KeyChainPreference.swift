//
//  KeyChainPreference.swift
//  smart to do
//
//  Created by Asif Reddot on 25/2/24.
//

import Foundation

public enum KeyChainKey: String{
    case loginMobileNumber
    case testLogin
    case authToken
    case sessionId
    case sessionKey
    case pushToken
    case biometricAuthToken
}

public class KeyChainPreference {
    public static let shared = KeyChainPreference()
    private let keyChainPreference: UserDefaults
    private init() {
        keyChainPreference = UserDefaults.standard
    }
    
    public func save(key: String, value: String) {
        let query = [
            kSecValueData: Data(value.utf8),
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key
        ] as CFDictionary
           
        let saveStatus = SecItemAdd(query, nil)
        if saveStatus != errSecSuccess {
            print("Error: \(saveStatus)")
        }
        if saveStatus == errSecDuplicateItem {
            update(existingKey: key, updatedValue: value)
        }
    }
    
    public func update(existingKey: String, updatedValue: String) {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: existingKey
        ] as CFDictionary
            
        let updatedData = [kSecValueData: Data(updatedValue.utf8)] as CFDictionary
        SecItemUpdate(query, updatedData)
    }
    
    public func delete(key: String) {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key
        ] as CFDictionary
            
        SecItemDelete(query)
    }
    
    public func load(keyString: String) -> Data? {
        let query = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrAccount as String : keyString,
            kSecReturnData as String  : kCFBooleanTrue!,
            kSecMatchLimit as String  : kSecMatchLimitOne ] as [String : Any]
        
        var dataTypeRef: AnyObject? = nil
        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        
        if status == noErr {
            return dataTypeRef as! Data?
        } else {
            return nil
        }
    }
    
    public func loadKeyChainString(forKey: String) -> String {
        guard let receivedData = self.load(keyString: forKey) else { return "" }
        let result = String(decoding: receivedData, as: UTF8.self)
        
        return result
    }
    
    public func getAllKeyChainItems() -> [String:String] {
        let query: [String: Any] = [
            kSecClass as String : kSecClassGenericPassword,
            kSecReturnData as String  : kCFBooleanTrue as Any,
            kSecReturnAttributes as String : kCFBooleanTrue as Any,
            kSecReturnRef as String : kCFBooleanTrue as Any,
            kSecMatchLimit as String: kSecMatchLimitAll
        ]
                    
        var result: AnyObject?
                    
        let lastResultCode = withUnsafeMutablePointer(to: &result) {
            SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0))
        }
                    
        var values = [String:String]()
        if lastResultCode == noErr {
            let array = result as? Array<Dictionary<String, Any>>
                        
            for item in array! {
                if let key = item[kSecAttrAccount as String] as? String,
                   let value = item[kSecValueData as String] as? Data {
                       values[key] = String(data: value, encoding:.utf8)
                 }
             }
        }
                    
        return values
    }
}

extension Data {
    init<T>(value: T) {
        self = withUnsafePointer(to: value) { (ptr: UnsafePointer<T>) -> Data in
            return Data(buffer: UnsafeBufferPointer(start: ptr, count: 1))
        }
    }

    mutating func append<T>(value: T) {
        withUnsafePointer(to: value) { (ptr: UnsafePointer<T>) in
            append(UnsafeBufferPointer(start: ptr, count: 1))
        }
    }
}

