//
//  ListViewController.swift
//  ECaFT
//
//  Created by Amanda Ong on 1/26/18.
//  Copyright © 2018 ECAFT. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, ListCollectionViewDelegate,  UITableViewDelegate, UITableViewDataSource, ListTableViewDelegate {
    
    
    let screenSize: CGRect = UIScreen.main.bounds
    let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    var listsView: UICollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: UICollectionViewFlowLayout())
    var header : ListCollectionViewHeader = ListCollectionViewHeader()
    
    var companyViewModel: CompanyViewModel!
    var listViewModel: ListViewModel!
    
    var listTableView: UITableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = listViewModel.selectedList.title
        self.view.backgroundColor = UIColor.listBackground
        
        makeListsView()
        makeListHeader()
        
        makeTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = listViewModel.selectedList.title
    
    }
    
    // Add List Plus Button
    func didPressListAddBtn(button: UIButton) {
        let addListVC = AddListPopUpViewController()
        addListVC.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        addListVC.modalTransitionStyle = UIModalTransitionStyle.coverVertical
        self.present(addListVC, animated: true, completion: nil)
    }
    
    // Mark: - List Collection View
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        listViewModel.selectedList = listViewModel.userLists[indexPath.row]
        collectionView.reloadData()
    }
    
    // List collectionViewCell's height and width adjust based on size of list view
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.bounds.height - flowLayout.sectionInset.bottom - flowLayout.sectionInset.top
        // Set width such that collection view displays 4 cells at a time
        let width = (collectionView.bounds.width - flowLayout.sectionInset.left - flowLayout.sectionInset.right)/4.0
        return CGSize(width: width, height: height)
    }
    
    
    func didPressCheckButton(button: UIButton!) {
        let index = button.tag
        var isSelected = listViewModel.selectedList.items[index].isSelected
        listViewModel.selectedList.items[index].isSelected = !isSelected
        listTableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listViewModel.selectedList.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesTableViewCell.identifier) as! FavoritesTableViewCell
        
        cell.checkButton.tag = indexPath.row
        cell.listItem = listViewModel.selectedList.items[indexPath.row]
        
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: false)
        let companyDetailsVC = CompanyDetailsViewController()
        companyDetailsVC.company = companyViewModel?.displayedCompanies[indexPath.row]
        companyDetailsVC.isFavorite = (companyViewModel?.displayedCompanies[indexPath.row].isFavorite)!
        self.show(companyDetailsVC, sender: nil)
    }
    
    /* MARK: - Private functions */
    private func makeListHeader() {
        header.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: 42)
        // Place header above collection view
        header.center.y = getViewHeight() - listsView.frame.height - header.frame.height/2.0
        header.roundCorners([.topLeft, .topRight], radius: 10)
        header.delegate = self
        self.view.addSubview(header)
    }
    
    private func makeListsView() {
        flowLayout.sectionInset = UIEdgeInsets(top: 5, left: 10, bottom: 17, right: 10)
        flowLayout.scrollDirection = UICollectionViewScrollDirection.horizontal
        flowLayout.minimumInteritemSpacing = CGFloat.greatestFiniteMagnitude
        
        // Place List view above tab bar
        let frame = CGRect(x: 0, y: 0, width: screenSize.width, height: 0.22*screenSize.height)
        listsView = UICollectionView(frame: frame, collectionViewLayout: flowLayout)
        listsView.center.y = getViewHeight() - listsView.frame.height/2.0
        
        listsView.backgroundColor = UIColor.ecaftLightGray3
        
        listsView.dataSource = listViewModel
        listsView.delegate = self
        listsView.register(UINib(nibName: "ListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: ListCollectionViewCell.identifier)
        listsView.register(ListCollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: ListCollectionViewHeader.identifier)

        self.view.addSubview(listsView)
    }
    
    private func getViewHeight() -> CGFloat {
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        let navBarHeight = self.navigationController?.navigationBar.frame.size.height ?? 0
        let tabBarHeight = self.tabBarController?.tabBar.frame.size.height ?? 0
        let viewHeight = screenSize.height - statusBarHeight - navBarHeight - tabBarHeight
        return viewHeight
    }
    
    // Make table view function
    private func makeTableView() {
        //Total height of nav bar, status bar, tab bar
        let barHeights = (self.navigationController?.navigationBar.frame.size.height)!+UIApplication.shared.statusBarFrame.height + 100
        
        listTableView.backgroundColor = UIColor.listBackground
        
        //edited CGRect to make margins and center it
        let listHeight = getViewHeight() - listsView.frame.height - header.frame.height
        
        listTableView = UITableView(frame: CGRect(x: 0, y: 0, width: Int(screenSize.width), height: Int(listHeight)), style: UITableViewStyle.plain)
        
        // UI
        listTableView.backgroundColor = UIColor.clear
        
        listTableView.dataSource = self
        listTableView.delegate = self
        
        //Regsiter custom cells and xib files
        listTableView.register(UINib(nibName: FavoritesTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: FavoritesTableViewCell.identifier)
        self.view.addSubview(self.listTableView)
    }

}
