//
//  ExploreTableView.swift
//  unsplashApp
//
//  Created by Oleg Bogdanov on 2023-06-20.
//

import UIKit

class ExploreTableView: UITableView  {
    
    let identifire = "cell"
   
    
    
    let myTableView: UITableView = {
        let view = UITableViewController()
        let table = UITableView(frame: view.tableView.bounds, style: .plain)
        table.translatesAutoresizingMaskIntoConstraints = false
        
        return table
    }()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func setupView() {
        
        addSubview(myTableView)
    }
    
    

      /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
