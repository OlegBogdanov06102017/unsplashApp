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
    private var authorizeUrl = "https://unsplash.com/oauth/authorize"
    private var authTokenUrl = "https://unsplash.com/oauth/token"
    weak var delegate: SendAlertsToIntroViewController?
    private var showAlert = false
    
    
    
    
    
    //MARK: Подгружаем элементы
    override func loadView() {
        super.loadView()
        let myView = IntroView()
        myView.moveToAuthSession()
        myView.tapExploreButton()
        self.view.addSubview(myView)
        let leftConstForImageView = myView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0)
        let rightConstForImageView = myView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
        let bottomConstForImageView = myView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        let topConstForImageView = myView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0)
        NSLayoutConstraint.activate([leftConstForImageView, rightConstForImageView,bottomConstForImageView,topConstForImageView])
        delegate?.sentSuccessAlert()
      
}
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        print("[DEBUG] Login button targets: \(logInButton.allTargets)")
        
        // Do any additional setup after loading the view.
    }
    //MARK: функция для перехода на ExploreViewController
     @objc func moveToExplore () {
        let storyBoard = UIStoryboard(name: "Main", bundle:nil)
        let exploreVC = self.storyboard?.instantiateViewController(withIdentifier: "ExploreViewController") as! ExploreViewController
        self.navigationController?.pushViewController(exploreVC, animated: true)
     //   self.present(exploreVC, animated: true)
 }
  
}

extension IntroViewController: SendAlertsToIntroViewController {
    func sentSuccessAlert() {
        show(self, sender: UIButton?.self)
        
    }
    
    func sentDuplicateToken() {
        show(self, sender: UIButton?.self)
    }
    
    
}




