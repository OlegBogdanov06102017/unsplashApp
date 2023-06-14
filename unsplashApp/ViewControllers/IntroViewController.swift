//
//  ViewController.swift
//  unsplashApp
//
//  Created by Oleg Bogdanov on 2023-05-11.
//

import UIKit
import AuthenticationServices
import Security
import Auth0




class IntroViewController: UIViewController {
    //MARK: Свойства класса
    let image = UIImage(named: "image 1") //фон в виде фотки
    let exploreUnspalshPhotoText = UILabel()  //главный лэйбл explore unsplash photo
    let sourceText = UILabel()  // лейбл ниже
    let logInButton = UIButton(type: .system) // кнопка Log in
    let explorePhotosButton = UIButton(type: .system) // кнопка explore photos
    private var userIsAuthorized = false
    private var authorizeUrl = "https://unsplash.com/oauth/authorize"
    private var authTokenUrl = "https://unsplash.com/oauth/token"
    
    
    
    
    //MARK: Подгружаем элементы
    override func loadView() {
        super.loadView()
        let imageView = UIImageView(image: image)
        view = imageView
        view.isUserInteractionEnabled = true
        //MARK: Explore Unspalsh photos
        let exploreFrame = CGRect(x: 24, y: 292 , width: 341, height: 186)
        exploreUnspalshPhotoText.frame = exploreFrame
        exploreUnspalshPhotoText.font = UIFont.boldSystemFont(ofSize: 48)
        exploreUnspalshPhotoText.text = "Explore Unsplash photos"
        exploreUnspalshPhotoText.textColor = .white
        exploreUnspalshPhotoText.numberOfLines = 0 // или 3? // 0 это когда лэйбл сам подстраивается под количество строк
        exploreUnspalshPhotoText.textAlignment = .left//в фигме написано что размещение по центру фрейма но выглядит убого
        view.addSubview(exploreUnspalshPhotoText)
        let leftConst = exploreUnspalshPhotoText.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24)
        let rightConst = exploreUnspalshPhotoText.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 10)
        let topConst = exploreUnspalshPhotoText.topAnchor.constraint(equalTo: view.topAnchor, constant: 290)
        let bottomConst = exploreUnspalshPhotoText.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 336)
        NSLayoutConstraint.activate([leftConst, rightConst, topConst, bottomConst])


        //MARK: The source of freely-usable images. Powered by creators everywhere.
        let sourceFrame = CGRect(x: 24, y: 494, width: 327, height: 84)
        sourceText.frame = sourceFrame
        sourceText.font = UIFont.boldSystemFont(ofSize: 18)
        sourceText.text = "The source of freely-usable images. Powered by creators everywhere."
        sourceText.textColor = .white
        sourceText.numberOfLines = 2
        sourceText.textAlignment = .left //в фигме написано что размещение по центру фрейма но выглядит убого
        view.addSubview(sourceText)
        let leftSourceConst = sourceText.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24)
        let rightSourceConst = sourceText.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 24)
        let topSourceConst = sourceText.topAnchor.constraint(equalTo: view.topAnchor, constant: 494)
        let bottomSourceConst = sourceText.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 236)
        let constBetweenTwoSubViews = sourceText.topAnchor.constraint(equalTo: exploreUnspalshPhotoText.bottomAnchor, constant: 16) //попробовал сделать констрейнт между двумя лэйблами. не уверене что верно как проверить в дебагере
        NSLayoutConstraint.activate([leftSourceConst, rightSourceConst, topSourceConst, bottomSourceConst, constBetweenTwoSubViews])
        
        
        //MARK: Кнопка Log in
        let logInFrame = CGRect(x: 16, y: 648, width: 343, height: 56)
        logInButton.frame = logInFrame
        logInButton.setTitle("Log in", for: .normal)
        logInButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        logInButton.titleLabel?.tintColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
        logInButton.backgroundColor = UIColor(red: 255/255 , green: 255/255, blue: 255/255, alpha: 1)
        logInButton.layer.cornerRadius = 5
        logInButton.titleLabel?.textAlignment = .center
        view.addSubview(logInButton)
        logInButton.addTarget(self, action: #selector(tapToLogin(_:)), for: .touchUpInside)
        let leftLogInConst = logInButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16)
        let rightSLogInConst = logInButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 16)
        let topLogInConst = logInButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 648)
        let bottomLogInConst = logInButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 110)
        let constBetweenLogInSource = logInButton.topAnchor.constraint(equalTo: sourceText.bottomAnchor, constant: 70) //попробовал сделать констрейнт между двумя лэйблами. не уверене что верно как проверить в дебагере
        NSLayoutConstraint.activate([leftLogInConst, rightSLogInConst, topLogInConst, bottomLogInConst, constBetweenLogInSource])
        
        
        
        //MARK: Explore photos button
        let exploreButtonFrame = CGRect(x: 16, y: 714, width: 343, height: 56)
        explorePhotosButton.frame = exploreButtonFrame
        explorePhotosButton.setTitle("Explore photos", for: .normal)
        explorePhotosButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        explorePhotosButton.titleLabel?.tintColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1)
        explorePhotosButton.layer.borderWidth = 2  // установил размер ширины для границы
        explorePhotosButton.layer.borderColor = UIColor.white.cgColor
        explorePhotosButton.titleLabel?.textAlignment = .center
        explorePhotosButton.layer.cornerRadius = 5
        view.addSubview(explorePhotosButton)
        explorePhotosButton.addTarget(self, action: #selector(moveToExplore), for: .touchUpInside)
        let leftExploreButtonConst = explorePhotosButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16)
        let rightExploreButtonConst = explorePhotosButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 16)
        let topExploreButtonConst = explorePhotosButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 664)
        let bottomExploreButtonConst = explorePhotosButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 84)
        let constBetweenLogInExploreSource = explorePhotosButton.topAnchor.constraint(equalTo: logInButton.bottomAnchor, constant: 10) //попробовал сделать констрейнт между двумя лэйблами. не уверене что верно как проверить в дебагере
        NSLayoutConstraint.activate([leftExploreButtonConst, rightExploreButtonConst, topExploreButtonConst, bottomExploreButtonConst, constBetweenLogInExploreSource])
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logInButton.isUserInteractionEnabled = true
        explorePhotosButton.isUserInteractionEnabled = true
        
        print("[DEBUG] Login button targets: \(logInButton.allTargets)")
       
        // Do any additional setup after loading the view.
    }
    
    //MARK: метод для нажатия на клавижу
    
    @objc func tapToLogin(_ sender: UIButton) {
        var initialUrl = URLComponents(string: authorizeUrl)
            
        let paramets = [
            URLQueryItem(name: "client_id", value: "7yu-nrpW_2e3gNkkEqvIDNBTyqrX4W7oUdnXUTQ8yw0"),
            URLQueryItem(name: "redirect_uri", value: "myUnspalshApp://successCallBack"),
            URLQueryItem(name: "response_type", value: "code"),
            URLQueryItem(name: "scope", value: "public")
        ]
        initialUrl?.queryItems = paramets
        let resultUrl = initialUrl?.url
        
        makeAuthorize(url: (resultUrl))
        
        
    }
    
    //MARK: функция для обработки authorize
    func makeAuthorize(url: URL?) {
      //  guard let authUrl = URL(string: url) else { return }
        let scheme = "myUnspalshApp"
        let session = ASWebAuthenticationSession(url: url!,  callbackURLScheme: scheme) { callbackURL, error  in
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
                                                                                                    // распарсить callbackurl и вытащить из него code
                                                                                                            //засунуть в переменную
                                                                                                            // отправить пост запрос на token с переменной
                                                                                                            //call back подправить на корректный
            
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
                        let status = try KeychainManager.save(accessToken: result!)
                        self.successAlert()
                        print("Token is successfuly saved")
                    } catch {
                        print(error)
                        DispatchQueue.main.async {
                            self.alreadySuccess()  // почему выплывает старый алерт
                        }
                    }
                } catch let error {
                    completion(nil, error)
                    print(error)
                }
            }
        }.resume()
        
    }
    //MARK: Метод для создания алерт об успешной авторизации
    private func successAlert() {
        let alert = UIAlertController(title: "Success", message: "You have successfuly passed authorization", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }
    private func alreadySuccess() {
        let alert = UIAlertController(title: "Success", message: "You have already authorized", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }

     //MARK: функция для перехода на ExploreViewController
    @objc func moveToExplore (_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: "Main", bundle:nil)
        let exploreVC = self.storyboard?.instantiateViewController(withIdentifier: "ExploreTableViewController") as! ExploreTableViewController
        self.navigationController?.pushViewController(exploreVC, animated: true)
      //  self.present(exploreVC, animated: true)
    }
}
extension IntroViewController: ASWebAuthenticationPresentationContextProviding  {
        func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
            return ASPresentationAnchor()
        }
    }



//override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//    let exploreVC = segue.destination as! ExploreViewController
