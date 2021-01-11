//
//  ViewController.swift
//  ChocofoodProject
//
//  Created by Murat Merekov on 07.01.2021.
//  Copyright © 2021 Murat Merekov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var tableView: UITableView!
    var cafes = [Cafe]()
    var reuseIdentifier = "cellView"
    private let cafeUrl = "https://api.jsonbin.io/b/5ff1946009f7c73f1b6d134f"
    static let shared = NetworkManager(baseUrl: "https://api.jsonbin.io")
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = .white
        setupTablewView()
       
        
        
        ViewController.shared.getData(path: "/b/5ff1946009f7c73f1b6d134f", method: .get, params: ["id": 12]) { (result: Result<[Cafe],Error>) in
               switch result{
                     case .success(let result):

                        self.cafes = result
                        DispatchQueue.main.async{
                            self.tableView.reloadData()
                        }
                     case .failure(_):
                         print("\n \n error hetting data! \n \n")

                     }
        }
        
        ViewController.shared.postData(path: "/c/5ff1946009f7c73f1b6d134f", method: .post, params: ["userId": 15,"title":"meduza","body":"gobadod"]) { (result: Result<[Cafe],Error>) in
                      switch result{
                            case .success(let result):
                               
                             print("sucseeeesd")
                            case .failure(_):
                                print("\n \n error hetting data! \n \n")
                               
                            }
               }
      
//        NetworkManager.getData() { (result: [Cafe]) in
//            self.cafes = result
//            DispatchQueue.main.async{
//                self.tableView.reloadData()
//            }
//        }
       
       setupConstraints()
}
    func setupTablewView(){
        tableView = UITableView()
        tableView.allowsSelection = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MenuViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.tableFooterView = UIView() // so there's no empty lines at the bottom
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
    }
    func setupConstraints(){
        NSLayoutConstraint.activate([
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        tableView.topAnchor.constraint(equalTo: view.topAnchor),
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cafes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! MenuViewCell
               cell.configure(for: cafes[indexPath.row])
               return cell
    }
    
    
}
extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
