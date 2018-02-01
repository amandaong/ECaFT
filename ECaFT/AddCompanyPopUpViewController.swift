//
//  AddCompanyPopUpViewController.swift
//  ECaFT
//
//  Created by Jannie on 1/28/18.
//  Copyright © 2018 ECAFT. All rights reserved.
//

import UIKit
import SnapKit

class AddCompanyPopUpViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    let screenSize : CGRect = UIScreen.main.bounds
    var popUpView: UIView = UIView()
    var titleView: UIView = UIView()
    var saveBtn: UIButton = UIButton()
    var favoriteBtn: UIButton = UIButton()
    var listTable: UITableView = UITableView()
    var listTableCell: UITableViewCell = UITableViewCell()
    var companyName: String = ""
    
    var popUpTitle: UILabel = UILabel()
    var listViewModel: ListViewModel!
    var companyViewModel: CompanyViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.grayFaded
        makePopUpView()
        makeTitleView()
        makeListTable()
        makeConstraints()
    }
    
    private func makePopUpView() {
        popUpView.frame = CGRect(x: 0, y: 0, width: screenSize.width*0.65, height: 308)
        popUpView.center = CGPoint(x: 0.5*screenSize.width, y: 0.5*screenSize.height)
        popUpView.backgroundColor = UIColor.white
        popUpView.layer.shadowColor = UIColor.gray.cgColor
        popUpView.layer.shadowOffset = CGSize(width: 0, height: 10)
        popUpView.layer.shadowOpacity = 0.9
        popUpView.layer.shadowRadius = 5
        self.view.addSubview(popUpView)
    }
    
    private func makeTitleView() {
        titleView.frame = CGRect(x: 0, y: 0, width: screenSize.width*0.65, height: 47)
        popUpTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
        popUpTitle.textAlignment = .center
        popUpTitle.text = "Add to list"
        popUpTitle.font = UIFont(name: "Avenir-Heavy", size: 20)
        titleView.addSubview(popUpTitle)
        
        //make save button
        saveBtn.setTitle("Save", for: .normal)
        saveBtn.setTitleColor(.ecaftRed, for: .normal)
        saveBtn.frame = CGRect(x: 185, y: 23, width: 100, height: 20)
        saveBtn.titleLabel?.font =  UIFont(name: "Avenir-Medium", size: 20)
        titleView.addSubview(saveBtn)
        
        popUpView.addSubview(titleView)
    }
    
    private func makeListTable() {
        listTable.frame = CGRect(x: 0, y: 55, width: popUpView.frame.width, height: popUpView.frame.height - 40)
        
        listTable.dataSource = self
        listTable.delegate = self
        
        listTable.register(UINib(nibName: "AddCompanyPopUpViewCell", bundle: nil), forCellReuseIdentifier: AddCompanyPopUpViewCell.identifier)
        
        popUpView.addSubview(listTable)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listViewModel.userLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let customCell: AddCompanyPopUpViewCell = tableView.dequeueReusableCell(withIdentifier: AddCompanyPopUpViewCell.identifier) as? AddCompanyPopUpViewCell else {
            
            return UITableViewCell()
        }
        //cell.checkButton.tag = indexPath.row
        
        return customCell
    }
    
    private func makeConstraints() {
        popUpTitle.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(popUpView)
            make.top.equalTo(popUpView).offset(20)
        }
    }

}

