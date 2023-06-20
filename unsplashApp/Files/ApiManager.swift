//
//  ApiManager.swift
//  unsplashApp
//
//  Created by Oleg Bogdanov on 2023-06-15.
//

import Foundation
import AuthenticationServices
import UIKit


class ApiManager: NSObject  {   //какой тип класса бы подошел?
    private var authTokenUrl = "https://unsplash.com/oauth/token"
    private var authorizeUrl = "https://unsplash.com/oauth/authorize"
    
   
   @objc func authorize(_ sender:UIButton!) {
       tapToLogin()
       print("tapped")
    }
    //MARK: старт логина
    func tapToLogin() {
        var initialUrl = URLComponents(string: authorizeUrl)
            
        let paramets = [
            URLQueryItem(name: "client_id", value: "7yu-nrpW_2e3gNkkEqvIDNBTyqrX4W7oUdnXUTQ8yw0"),
            URLQueryItem(name: "redirect_uri", value: "myUnspalshApp://successCallBack"),
            URLQueryItem(name: "response_type", value: "code"),
            URLQueryItem(name: "scope", value: "public")
        ]
        initialUrl?.queryItems = paramets
        let resultUrl = initialUrl?.url
        makeAuthorize(resultUrl)
        
    }
    //MARK: функция для обработки authorize
  func makeAuthorize(_ url: URL?) {
      //  guard let authUrl = URL(string: url) else { return }
        let scheme = "myUnspalshApp"
        let session = ASWebAuthenticationSession(url: url!, callbackURLScheme: scheme) { callbackURL, error in
            guard error == nil, let callbackURL = callbackURL,
            let queryItems = URLComponents(string: callbackURL.absoluteString)?.queryItems,
            let authToken = queryItems.filter({ $0.name == "code" }).first?.value
            else {
                print("An error occurred when attempting to sign in.")
                return }
            print(authToken ?? "No Token")
            self.postRequestGetToken(code: authToken) { response, error in
                print(response?.access_token)
            }
        }
        session.presentationContextProvider = self
        session.start()
    }
    //MARK: Отправляем запрос на получение токена
    private func postRequestGetToken(code: String, completion: @escaping (ResponseAccessToken?, Error?) -> Void) {
        guard let url = URL(string: authTokenUrl) else {return}
        let body = Request(client_id: "7yu-nrpW_2e3gNkkEqvIDNBTyqrX4W7oUdnXUTQ8yw0",
                           client_secret: "sEBSPdHKCZMQgokmV2kZLqSniFjc09RKZfyzjSzUmmE",
                           redirect_uri: "myUnspalshApp://successCallBack",
                           code: code,
                           grant_type: "authorization_code")
        guard let bodyData = try? JSONEncoder().encode(body) else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = bodyData
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    print(error)
                    completion(nil, error)
                    return
                }
                guard let response = response, let data = data else {return}
                print(response)
                do {
                    let newBody = try JSONDecoder().decode(ResponseAccessToken.self, from: data)
                    completion(newBody, nil)
                    // let newBody = try JSONSerialization.jsonObject(with: data)
                    print(newBody)
                    let result = newBody.access_token.data(using: .utf8)
                    do {
                        _ = try KeychainManager.save(accessToken: result!)
                        print("Token is successfuly saved")
                    } catch {
                        print(error)
                    }
                } catch let error {
                    completion(nil, error)
                    print(error)
                }
            }
        }.resume()
        
    }
    
    
}
extension ApiManager: ASWebAuthenticationPresentationContextProviding  {
        func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
            return ASPresentationAnchor()
        }
    }

