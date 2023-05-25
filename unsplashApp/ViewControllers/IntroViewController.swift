//
//  ViewController.swift
//  unsplashApp
//
//  Created by Oleg Bogdanov on 2023-05-11.
//

import UIKit
import AuthenticationServices
import Auth0


class introViewController: UIViewController {
    //MARK: Свойства класса
    let image = UIImage(named: "image 1") //фон в виде фотки
    let exploreUnspalshPhotoText = UILabel()  //главный лэйбл explore unsplash photo
    let sourceText = UILabel()  // лейбл ниже
    let logInButton = UIButton(type: .system) // кнопка Log in
    let explorePhotosButton = UIButton(type: .system) // кнопка explore photos
    private var userIsAuthorized = false
    private var authorizeUrl = "https://unsplash.com/oauth/authorize"
    private var canStartSessionAuth = false
    private var authTokenUrl = "https://unsplash.com/oauth/token"
    
    
    
    //MARK: Подгружаем элементы
    override func loadView() {
        super.loadView()
        let imageView = UIImageView(image: image)
        view = imageView
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
  //      logInButton.addTarget(self, action: #selector(tapToLogin), for: .touchUpInside)
        view.addSubview(logInButton)
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
        let leftExploreButtonConst = explorePhotosButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16)
        let rightExploreButtonConst = explorePhotosButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 16)
        let topExploreButtonConst = explorePhotosButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 664)
        let bottomExploreButtonConst = explorePhotosButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 84)
        let constBetweenLogInExploreSource = explorePhotosButton.topAnchor.constraint(equalTo: logInButton.bottomAnchor, constant: 10) //попробовал сделать констрейнт между двумя лэйблами. не уверене что верно как проверить в дебагере
        NSLayoutConstraint.activate([leftExploreButtonConst, rightExploreButtonConst, topExploreButtonConst, bottomExploreButtonConst, constBetweenLogInExploreSource])
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tapToLogin()
        // Do any additional setup after loading the view.
    }
    
    
    //MARK: метод для нажатия на клавижу
    
    @objc func tapToLogin() {
        if !userIsAuthorized {
            makeAuthorize(url: authorizeUrl)
        }
    }
    func makeAuthorize(url: String) {
        guard let authUrl = URL(string: url) else { return }
        let scheme = "code"
        let session = ASWebAuthenticationSession(url: authUrl, callbackURLScheme: scheme) { callbackURL, error in
            guard error == nil, let callbackURL = callbackURL else { return }

            // The callback URL format depends on the provider. For this example:
            //   exampleauth://auth?token=1234
//            let queryItems = URLComponents(string: callbackURL.absoluteString)?.queryItems
//            let token = queryItems?.filter({ $0.name == "token" }).first?.value
        var initialUrl = URLComponents(string: url)
            
            let params = [
                URLQueryItem(name: "client_id", value: "7yu-nrpW_2e3gNkkEqvIDNBTyqrX4W7oUdnXUTQ8yw0"),
                URLQueryItem(name: "redirect_uri", value: "successAuth"),
                URLQueryItem(name: "response_type", value: "code"),
                URLQueryItem(name: "scope", value: "read_user")
            ]
            initialUrl?.queryItems = params
            let resultUrl = initialUrl?.url
            print(resultUrl)
        }
        session.presentationContextProvider = self
        session.start()
        
    }
}
extension introViewController: ASWebAuthenticationPresentationContextProviding  {
        func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
            return ASPresentationAnchor()
        }
    }

