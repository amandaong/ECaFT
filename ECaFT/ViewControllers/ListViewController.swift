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
    
    var tableView: UITableView!
    var collectionView: UICollectionView!
    let tableReuseIdentifier = "tableReuseIdentifier"
    let collectionReuseIdentifier = "collectionReuseIdentifier"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "List Name"
        view.backgroundColor = .white
        
        //tableView
        tableView = UITableView()
        tableView.bounces = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UserListTableViewCell.self, forCellReuseIdentifier: tableReuseIdentifier)
        
       /* //collectionView
        collectionView = UICollectionView()
        collectionView.backgroundColor = .blue
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UserListCollectionViewCell.self, forCellWithReuseIdentifier: collectionReuseIdentifier)*/
        
        view.addSubview(tableView)
        //view.addSubview(collectionView)
        setupConstraints()
    }
    
    //##############################################
    //set up constraints
    func setupConstraints() {
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        //collectionView stuff
    }
    
    
    //##############################################
    //set up tableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
    //##############################################
    //set up collectionView
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }

}
