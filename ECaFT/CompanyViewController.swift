//
//  CompanyViewController.swift
//  ECaFT
//
//  Created by Logan Allen on 11/22/16.
//  Copyright © 2016 loganallen. All rights reserved.
//

import UIKit

class CompanyViewController: UIViewController, UISearchBarDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    let screenSize: CGRect = UIScreen.main.bounds
    var searchBar: UISearchBar!
    var filterTitle : UILabel!
    var scrollView : UIScrollView!
    
    //filter collection view variables
    let leftAndRightPaddings: CGFloat = 80.0
    let numberOfItemsPerRow: CGFloat = 2.0
    private let cellReuseIdentifier = "collectionCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.ecaftGray
        
        makeSearchBar()
        makeFilterButtons()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.topItem?.title = "Companies"
    }
    
    func makeSearchBar() {
        //Make UISearchBar instance
        searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: 50)
        
        //Style & color
        searchBar.searchBarStyle = UISearchBarStyle.default
        searchBar.tintColor = UIColor.red
        
        //Make search bar background translucent
        searchBar.barTintColor = UIColor.clear //changes color around search bar
       let image = UIImage()
        searchBar.setBackgroundImage(image, for: .any, barMetrics: .default) //sets background image as clear
        searchBar.scopeBarBackgroundImage = image //sets scope bar background image as clear
 
        //Buttons & text
        searchBar.placeholder = "Search"
        searchBar.showsCancelButton = false
        searchBar.showsBookmarkButton = false
        searchBar.showsSearchResultsButton = false
        
        self.view.addSubview(searchBar)
    }

    //Search bar functions
    // called whenever text is changed.
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    }
    
    // called when cancel button is clicked
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
    }
    
    // called when search button is clicked
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        self.view.endEditing(true)
    }
    
    var filtersCollectionView: UICollectionView!

    func makeFilterButtons() {
        //Filter title
        filterTitle = UILabel()
        filterTitle.frame = CGRect(x: 8, y: 40, width: screenSize.width, height: 30)
        filterTitle.backgroundColor = UIColor.clear
        filterTitle.font = UIFont(name: "Avenir-Book", size: filterTitle.font.pointSize) //sets label to the font size it already has
        filterTitle.textColor = UIColor.black
        filterTitle.textAlignment = NSTextAlignment.left
        filterTitle.text = "Filters"
        self.view.addSubview(filterTitle)
        
        //Make collection view of filter buttons
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let filtersCollectionView = UICollectionView(frame: CGRect(x: 0, y: 70, width: screenSize.width, height: 60), collectionViewLayout: flowLayout) //height of collectionView=height of collectionCell
        filtersCollectionView.backgroundColor = UIColor.clear
        filtersCollectionView.showsHorizontalScrollIndicator = false //hides horizontal scroll bar
        filtersCollectionView.register(FilterCollectionViewCell.self, forCellWithReuseIdentifier: cellReuseIdentifier)
        filtersCollectionView.delegate = self
        filtersCollectionView.dataSource = self
        self.view.addSubview(filtersCollectionView)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath as IndexPath) as! FilterCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (screenSize.width-leftAndRightPaddings)/numberOfItemsPerRow
        return CGSize(width: width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    }
    
    
}
