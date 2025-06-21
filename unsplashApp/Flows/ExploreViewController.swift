//
//  ExploreViewController.swift
//  unsplashApp
//
//  Created by Oleg Bogdanov on 2023-06-24.
//

import UIKit

class ExploreViewController: UIViewController {
    private var collections: [ResponseGetRandomPhoto] = []
    private let api = ApiManager()
    private var myTableView = UITableView()
    private let headerCell = "headerCell"

    
    override func loadView() {
        super.loadView()
        hideNavigationBar()
        createTable()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func createTable() {
            self.myTableView = UITableView(frame: view.bounds, style: .plain)
            self.view.addSubview(myTableView)
            myTableView.register(HeaderCell.self, forHeaderFooterViewReuseIdentifier: headerCell)
            myTableView.register(ExploreTableViewCell.self, forCellReuseIdentifier: ExploreTableViewCell.reuseID)
        myTableView.register(CollectionViewTableCell.self, forCellReuseIdentifier: CollectionViewTableCell.id)
            myTableView.register(PhotoCell.self, forCellReuseIdentifier: PhotoCell.reuseID)
            self.myTableView.delegate = self
            self.myTableView.dataSource = self
            myTableView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            myTableView.headerView(forSection: 0)
            myTableView.separatorColor = .clear
            myTableView.allowsSelection = false
        }
    
//    func fetchData() {
//        api.getRequestRandomPhoto { result, error in
//            let raw = result?.urls.raw
//            
//            let imageURL = URL(string: raw)
//            let queue = DispatchQueue.global()
//                queue.async {
//                        if let data = try? Data(contentsOf: imageURL!) {
//                            DispatchQueue.main.async {
//                                print("show header image")
//                            }
//                    }
//                }
//        }
//            
//    }

    
    
    
    
     
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerCell) as! HeaderCell
        api.getRequestRandomPhoto { result, error in
            let raw = result?.urls?.raw
                     // TODO: Cделать guard чтобы обработать ошибку ???
            let imageURL = URL(string: raw!)
            let queue = DispatchQueue.global()
                queue.async {
                        if let data = try? Data(contentsOf: imageURL!) {
                            DispatchQueue.main.async {
                                view.headerImageView.image = UIImage(data: data)
                                print("show header image")
                            }
                    }
                }
        }
        
        return view
    }
    
    //MARK: получение коллекции из реквеста getCollection
  
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    

}

extension ExploreViewController: UITableViewDelegate, UITableViewDataSource  {
    func hideNavigationBar() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    //MARK: UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = myTableView.dequeueReusableCell(withIdentifier: CollectionViewTableCell.id, for: indexPath) as? CollectionViewTableCell else {
            return UITableViewCell()
        }
       // cell.backgroundColor = .blue
        return cell
        
        guard let cellText = myTableView.dequeueReusableCell(withIdentifier: ExploreTableViewCell.reuseID, for: indexPath) as? ExploreTableViewCell else {
            return UITableViewCell()
        }
        
        cellText.myCell.text = "NEw"
        
        }
    
    //MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height:CGFloat = CGFloat()
        if indexPath.row == 0 {
            height = 42
        } else if indexPath.row == 1 {
            height = 146
        } else if indexPath.row == 2 {
            height = 42
        }
        else {
            height = 50
        }
        return height
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        250.0
    }
}




