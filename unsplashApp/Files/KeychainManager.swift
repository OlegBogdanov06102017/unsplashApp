//
//  KeychainManager.swift
//  unsplashApp
//
//  Created by Oleg Bogdanov on 2023-06-08.
//

// Results

// 1. Sync

// 1.1. Simple result

//let km = KeychanManager()
//
//let token = km.getToken()
//
//print(token)
//
//// 1.2. Simple result with exceptions
//
//let km = KeychanManager()
//
//do {
//    let token = km.getToken()
//    
//    print(token)
//    
//} catch {
//    print(error)
//}
//
//// 2. Async
//
//// 2.1. Simple result
//
//let km = KeychanManager()
//
//km.getToken(completionHandler: { token in
//    print(token)
//})
//
//// 2.2. Simple result with error
//
//let km = KeychanManager()
//
//km.getToken(completionHandler: { token, error in
//    if let error {
//        print(error)
//        return
//    }
//    
//    guard let token else {
//        print("Token is nil")
//        return
//    }
//    
//    print(token)
//})
//
//// 2.3. Simple result with Result
//
//let km = KeychanManager()
//
//km.getToken(completionHandler: { result in
//    switch result {
//    case let .failure(error): print(error)
//    case let .success(token): print(token)
//    }
//})
//
//// 2.4. Async/await result (Swift concurrency)
//
//let km = KeychanManager()
//
//// func getToken() async -> Token?
//let token = await km.getToken()
//
//print(token)
//
//// 2.5. Async/await result (Swift concurrency)
//
//let km = KeychanManager()
//
//// func getToken() async throws -> Token?
//
//do {
//    let token = await km.getToken()
//    print(token)
//} catch {
//    print(error)
//}
//
//// 2.6. Delegate
//
//class Test: KeychanManagerDelegate {
//    
//    
//    func didChangeTokenWithSuccess(token: Token) {
//        print(token)
//    }
//    
//    func didChangeTokenWitError(error: Error) {
//        print(error)
//    }
//}
//
//let km = KeychanManager()
//km.delegate = Test()
//
//// 2.7. Observer
//
//class Test: KeychanManagerDelegate {
//    
//    
//    func setupNotifications() {
//        NotificationCenter.default.addObserver(forName: NSNotification.Name("Token changed")) { notification in
//            guard let token = notification.userInfo["token"] else {
//                return
//            }
//            print(token)
//        }
//    }
//}
//
//let km = KeychanManager()

// 2.8. Combine


// KeychainManager
//
// 1. KeychainManager.save(accessToken: Data)
//    Saving token...
//    1.1. Success
//       KeychainManager.delegate.didSuccess(...)
//             ...
//    Ending ...

//    1.2. Error
//       KeychainManager.delegate.didError(...)
//             ...
//    Ending ...


// UITableView
//
// UITableView.reloadView()
//  ...
//  let sections = UITableView.dataSource.numberOfSections()
//  for section in sections {
//     ...
//     let rows = UITableView.dataSource.numberOfRows(in section)
//     ...
//  }
//  ...
//




//// 1. Delegate
//
//let km = KeychainManager()
//
//let kmd1: KeychanManagerDelegate = infoVC()
//let kmd2: KeychanManagerDelegate = someVC()
//
//km.delegate = kmd2
//
//// 2. Delegate + DataSource
//
//let km = KeychainManager()
//
//let kmd1: KeychanManagerDelegate = infoVC()
//let kmd2: KeychanManagerDelegate = someVC()
//
//km.delegate1 = kmd1
//km.delegate2 = kmd2
//
//// 3. Observer
//// NotificationCenter
//
//let km = KeychainManager()
//
//// NotificationCenter.default.post("Token Changed", payload)
//
//let kmd1 = infoVC()
//
////  NotificationCenter.default.addObserver("Token Changed") { payload in
////  ...
////  }
//
//let kmd2 = someVC()
//
////  NotificationCenter.default.addObserver("Token Changed") { payload in
////  ...
////  }
//


import Foundation
import Security
import UIKit

enum KeychainError: Error {
    case duplicateToken
    case tokenNotFound
    case unknowned(OSStatus)
}
protocol SendAlertsToIntroViewController: AnyObject {
    func sentSuccessAlert()
    func sentDuplicateToken()
}

final class KeychainManager {
    
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
    func sentDelegate() {
        let intro = IntroViewController()
        intro.delegate = self
    }
<<<<<<< HEAD
=======
    
    
>>>>>>> be12693 (add some logic on ExploreViewController, try to add CollectionView in Table View)
}
extension KeychainManager: SendAlertsToIntroViewController {
    func sentSuccessAlert() {
        let alert = UIAlertController(title: "Success", message: "You have successfuly passed authorization", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default)
            alert.addAction(action)
    
    }
    
    func sentDuplicateToken() {
            let alert = UIAlertController(title: "Success", message: "You have already authorized", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default)
            alert.addAction(action)
    }
    
    
}


