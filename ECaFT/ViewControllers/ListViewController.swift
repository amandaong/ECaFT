//
//  ListViewController.swift
//  ECaFT
//
//  Created by Amanda Ong on 1/26/18.
//  Copyright © 2018 ECAFT. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    var companyViewModel: CompanyViewModel!
    let screenSize: CGRect = UIScreen.main.bounds
    let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    var listsView: UICollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: UICollectionViewFlowLayout())
    var header : ListCollectionViewHeader = ListCollectionViewHeader()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Favorites"
        self.view.backgroundColor = UIColor.green
        
        makeListsView()
        makeListHeader()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let customCell: ListCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCollectionViewCell.identifier, for: indexPath) as? ListCollectionViewCell else {
            print("ListViewController.swift - cellForRowAt method:  Company Table View dequeuing cell error")
            return UICollectionViewCell()
        }
        return customCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        print("User tapped on item \(indexPath.row)")
    }
    
    // List collectionViewCell's height and width adjust based on size of list view
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.bounds.height - flowLayout.sectionInset.bottom - flowLayout.sectionInset.top
        // Set width such that collection view displays 4 cells at a time
        let width = (collectionView.bounds.width - flowLayout.sectionInset.left - flowLayout.sectionInset.right)/4.0
        return CGSize(width: width, height: height)
    }
    
    /* MARK: - Private functions */
    private func makeListHeader() {
        header.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: 42)
        // Place header above collection view
        header.center.y = getViewHeight() - listsView.frame.height - header.frame.height/2.0
        header.roundCorners([.topLeft, .topRight], radius: 10)
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
        
        listsView.dataSource = self
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
}
