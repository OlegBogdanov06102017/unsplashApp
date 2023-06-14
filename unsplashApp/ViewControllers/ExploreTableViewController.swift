//
//  ExploreViewController.swift
//  unsplashApp
//
//  Created by Oleg Bogdanov on 2023-06-12.
//

import UIKit

class ExploreTableViewController: UITableViewController {
    
    override func loadView() {
        super.loadView()
        hideNavigationBar()
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
 
extension ExploreTableViewController {
    func hideNavigationBar() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
}

