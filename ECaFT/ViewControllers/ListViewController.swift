//
//  ListViewController.swift
//  ECaFT
//
//  Created by Jannie on 4/11/18.
//  Copyright © 2018 ECAFT. All rights reserved.
//

import UIKit
import SnapKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //add some sample data
    let item1 = ListItem(companyName: "Google", booth: "A2", isSelected: false)
    let item2 = ListItem(companyName: "Facebook", booth: "B8", isSelected: false)
    
    var tableView: UITableView!
    var collectionView: UICollectionView!
    let tableReuseIdentifier = "tableReuseIdentifier"
    let collectionReuseIdentifier = "collectionReuseIdentifier"
    var sampleTableData: [ListItem] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "List Name"
        view.backgroundColor = .black
        
        sampleTableData.append(item1)
        sampleTableData.append(item2)
        
        //tableView
        tableView = UITableView()
        tableView.bounces = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UserListTableViewCell.self, forCellReuseIdentifier: tableReuseIdentifier)
        
//        //collectionView
//        collectionView = UICollectionView()
//        collectionView.backgroundColor = .blue
//        collectionView.delegate = self
//        collectionView.dataSource = self
//        collectionView.register(UserListCollectionViewCell.self, forCellWithReuseIdentifier: collectionReuseIdentifier)
        
        view.addSubview(tableView)
        //view.addSubview(collectionView)
        setupConstraints()
    }
    
    //##############################################
    //set up constraints
    func setupConstraints() {
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(view)
            make.right.equalTo(view)
            make.left.equalTo(view)
            make.bottom.equalTo(view)
        }
        
        //collectionView stuff
//        collectionView.snp.makeConstraints { (make) in
//            make.top.equalTo(view).offset(-150)
//            make.right.equalTo(view)
//            make.left.equalTo(view)
//            make.bottom.equalTo(view)
//        }
    }
    
    
    //##############################################
    //set up tableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sampleTableData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableReuseIdentifier, for: indexPath) as! UserListTableViewCell
        
        cell.companyName.text = sampleTableData[indexPath.row].companyName
        cell.booth.text = sampleTableData[indexPath.row].booth
        //enter stuff on selecting the button
        
        cell.setNeedsUpdateConstraints()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    //##############################################
    //set up collectionView
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UserListCollectionViewCell()
    }
    

}
