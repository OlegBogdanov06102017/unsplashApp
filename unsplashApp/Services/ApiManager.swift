import Foundation
import AuthenticationServices
import UIKit

class ApiManager: NSObject  { //какой тип класса бы подошел?
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
    
    
    //MARK: Выполняем запрос на получение коллекиця, в дальнейшей для добавления в коллекш вью (класс getResopnseCollection)
    func getRequestCollection(completion: @escaping([Collections]?, Error?) -> Void) {
        
        guard let url = URL(string: CustomerAPI.collections.path) else {return}
        
        var request = URLRequest(url: url)
        
        do {
            let token = try KeychainManager.getToken()
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        } catch {
            print(error)
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data, let response = response else { return }
            print(data)
            print(response)
            
            do {
                let newBodyForCollection = try JSONDecoder().decode([Collections].self, from: data)
                completion(newBodyForCollection, nil)
                let result = newBodyForCollection
                print(data)
                print(result)
            } catch let error {
                print(error)
                completion(nil, error)
                return
            }
            
        }.resume()
    }
    //MARK: Получение рандом фото для заголовка
    func getRequestRandomPhoto(completion: @escaping (RandomPhoto?, Error?)-> Void) {
        
        guard let url = URL(string: CustomerAPI.randomPhoto.path) else {
            completion(nil, NetworkError.badURL)
            return
        }
        
        var request = URLRequest(url: url)
        
        do {
            let token = try KeychainManager.getToken()
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        } catch {
            completion(nil,error)
        }
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error)
                completion(nil, error)
                return
            }
            guard let data = data, let response = response else { return }
            print(data)
            print(response)
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let newBody = try decoder.decode(RandomPhoto.self, from: data)
                completion(newBody, nil)
                let result = newBody
                print(data)
                print(result)
            }
            catch let error {
                completion(nil, error)
                print(error)
            }
            
        }.resume()
    }
    
    //MARK: Получение категорий или топиков
    
    func getResponseTopic(completion: @escaping ([Topic]?, Error?)-> Void) {
        guard let url = URL(string: CustomerAPI.topic.path) else {
            completion(nil, NetworkError.badURL)
            return
        }
        
        var request = URLRequest(url: url)
        
        do {
            let token = try KeychainManager.getToken()
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        } catch {
            completion(nil,error)
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error)
                completion(nil, error)
                return
            }
            
            guard let data = data, let response = response else { return }
            print(data)
            print(response)
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let body = try decoder.decode([Topic].self, from: data)
                completion(body, nil)
                let result = body
                print(data)
                print(result)
            } catch let error {
                completion(nil, error)
                print(error)
            }
        }.resume()
    }
    
    
    func getResponsePhotoBySlug(slug: String, completion: @escaping([TopicPhoto]?, Error?) -> Void) {
        guard let url = URL(string: CustomerAPI.topicPhotos(slug: slug).path) else {
            completion(nil, NetworkError.badURL)
            return
        }
        var reqestLandscpe = URLComponents(string: CustomerAPI.topicPhotos(slug: slug).path)
        
        let queryItem = [
            URLQueryItem(name: "orientation", value: "landscape")
        ]
        
        reqestLandscpe?.queryItems = queryItem
        var finalRequest = reqestLandscpe?.url
        var request = URLRequest(url: finalRequest!)
        
        
        do {
            let token = try KeychainManager.getToken()
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        } catch {
            completion(nil,error)
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error)
                completion(nil, error)
                return
            }
            
            guard let data = data, let response = response else { return }
                print(data)
                print(response)
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let body = try decoder.decode([TopicPhoto].self, from: data)
                completion(body, nil)
                let result = body
                print(data)
                print(result)
            } catch let error {
                completion(nil, error)
            }
        }.resume()
    }
}
    
    
    
    
    
    
    
    
    
    
    
    //MARK: Запрос на фотки с пагинацией
    func getPhotoForPagination(pagination: Bool = false, completion: @escaping (Result<[String], Error>) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + (pagination ? 3: 2), execute: {
            let originalData = [
            "Apple",
            "Google",
            "Facebook",
            "Apple",
            "Google",
            "Facebook",
            "Apple",
            "Google",
            "Facebook",
            "Apple",
            "Google",
            "Facebook"
            ]
            
            let newData = [
            "banana",
            "oranges",
            "grapes"
            ]
            completion(.success(pagination ? newData : originalData ))
        })
    }


extension ApiManager: ASWebAuthenticationPresentationContextProviding  {
        func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
            return ASPresentationAnchor()
        }
    }

