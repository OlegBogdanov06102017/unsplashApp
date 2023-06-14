//
//  KeychainManager.swift
//  unsplashApp
//
//  Created by Oleg Bogdanov on 2023-06-08.
//

import Foundation
import Security

enum KeychainError: Error {
    case duplicateToken
    case tokenNotFound
    case unknowned(OSStatus)
}

final class KeychainManager {
   // let service = "https://unsplash.com/@olegbogdanov26"
    static func save(accessToken: Data)  throws  {
        let responseData: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,       //используется для значений хранимых элементов
//            kSecAttrAccount: identifier,               //акк соотвествующий сохраняемому паролю
//            kSecAttrService: service,
            kSecValueData: accessToken                //для передачи данных сохраняемого элемента
            ]
       let status = SecItemAdd(responseData as CFDictionary, nil)
        
        guard status == errSecSuccess else {
            if status == errSecDuplicateItem {
                throw KeychainError.duplicateToken
            }
            throw KeychainError.unknowned(status)
        }
    }
    static func getToken() throws -> String {
        let getData: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecMatchLimit: kSecMatchLimitOne,
            kSecReturnData: true
        ]
        var result: AnyObject?
        let status = SecItemCopyMatching(getData as CFDictionary, &result)  //что значит &result???
        guard status == errSecSuccess else {
            if status == errSecItemNotFound {
                throw KeychainError.tokenNotFound
            }
            throw KeychainError.unknowned(status)
        }
        return String(data: result as! Data, encoding: .utf8)!
    }
}
