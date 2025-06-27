//
//  ViewController.swift
//  unsplashApp
//
//  Created by Oleg Bogdanov on 2023-05-11.
//

import UIKit
import AuthenticationServices
import Security
import SnapKit




final class IntroViewController: UIViewController {
    
    private let introview = IntroView()
    private var authorizeUrl = "https://unsplash.com/oauth/authorize"
    private var authTokenUrl = "https://unsplash.com/oauth/token"
    weak var delegate: SendAlertsToIntroViewController?
    private var showAlert = false
    
    
    
    
    
    //MARK: Подгружаем элементы
    override func loadView() {
        super.loadView()
        introview.moveToAuthSession()
        introview.tapExploreButton()
        configure()
        delegate?.sentSuccessAlert()
      
}
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //MARK: функция для перехода на ExploreViewController
     @objc func moveToExplore () {
        let exploreVC = ExploreViewController()
       self.navigationController?.pushViewController(exploreVC, animated: true)
 }
    
    private func configure() {
        view.addSubview(introview)
        introview.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
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






