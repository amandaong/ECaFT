//
//  CompanyViewController.swift
//  ECaFT
//
//  Created by Logan Allen on 11/22/16.
//  Copyright © 2016 loganallen. All rights reserved.
//

import UIKit

class CompanyViewController: UIViewController, UISearchBarDelegate, UIScrollViewDelegate {
    let screenSize : CGRect = UIScreen.main.bounds
    var searchBar : UISearchBar!
    var scrollFilterView : UIScrollView!
    var filterTitle : UILabel!
    var isFilterDropDown : Bool!
    var tapsOutsideFilterButton : UIButton!
    var scrollView : UIScrollView!
    var arrowIV : UIImageView!
    var checkIV : UIImageView!
    
    //filter collection view variables
    let leftAndRightPaddings: CGFloat = 80.0
    let numberOfItemsPerRow: CGFloat = 2.0
    private let cellReuseIdentifier = "collectionCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.ecaftGray
        
        makeSearchBar()
        //makeFilterButtons()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()

        let filterButton = UIBarButtonItem(image: #imageLiteral(resourceName: "filter"), style: .plain, target: self, action: #selector(filterButtonTapped))
        navigationController?.navigationBar.topItem?.rightBarButtonItem = filterButton
        tapsOutsideFilterButton = UIButton(frame: view.frame)
        setUpFilter()
        isFilterDropDown = false
        
        //Temporary button to pull up company's detail page
        createDetailsButton()
    }
    
    func createDetailsButton () {
        let button = UIButton();
        button.setTitle("Company Detail's Page", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        button.frame = CGRect(x: 0.5*screenSize.width, y: 0.5*screenSize.height, width: 100, height: 30)
        button.addTarget(self, action: #selector(CompanyViewController.detailsButtonTapped(button:)), for: .touchUpInside)
        self.view.addSubview(button)
    }
    
    func detailsButtonTapped(button: UIButton!) {
        let companyDetailsViewController = CompanyDetailsViewController()
        self.navigationController?.pushViewController(companyDetailsViewController, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.topItem?.title = "Companies"
        UIView.animate(withDuration: 0.0, animations: {
            self.scrollFilterView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
            self.arrowIV.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
        })
    }
    
    func filterButtonTapped() {
        let transform: CGFloat = isFilterDropDown! ? 0.001 : 1
        UIView.animate(withDuration: 0.2, animations: {
            self.scrollFilterView.transform = CGAffineTransform(scaleX: transform, y: transform)
            self.arrowIV.transform = CGAffineTransform(scaleX: transform, y: transform)
        })
        
        tapsOutsideFilterButton.isHidden = isFilterDropDown
        isFilterDropDown = !isFilterDropDown
    }
    
    func setUpFilter() {
        let filterOptions = ["Biological Engineering", "Chemical Engineering", "Civil Engineering", "Computer Science",
            "Electrical and Computer Engineering", "Engineering Physics", "Environmental Engineering",
            "Information Science, Systems and Technology", "Materials Science and Engineering", "Mechanical Engineering",
            "Operations Research and Engineering", "Science of Earth System"]
        let buttonHeight: CGFloat = UIScreen.main.bounds.height / 15
        let contentWidth: CGFloat = UIScreen.main.bounds.width / 2
        let contentHeight: CGFloat = CGFloat(filterOptions.count) * buttonHeight
        
        //create arrow for drop-down menu
        let filterBarButton = navigationController?.navigationBar.topItem?.rightBarButtonItem
        let x = (filterBarButton?.value(forKey: "view")! as AnyObject).frame.minX + ((filterBarButton?.value(forKey: "view")! as AnyObject).size.width / 2) - 5
        arrowIV = UIImageView(frame: CGRect(x: x, y: (navigationController?.navigationBar.frame.height)! + UIApplication.shared.statusBarFrame.height - 10, width: 10, height: 10))
        arrowIV.image = #imageLiteral(resourceName: "arrow")
        setAnchorPoint(CGPoint(x: 0.5, y: 1.0), forView: arrowIV)
        UIApplication.shared.keyWindow?.addSubview(arrowIV)
        
        //closes filter when user taps anywhere on screen
        tapsOutsideFilterButton.backgroundColor = .clear
        tapsOutsideFilterButton.addTarget(self, action: #selector(filterButtonTapped), for: .touchUpInside)
        view.addSubview(tapsOutsideFilterButton)
        
        //enable scrolling
        scrollFilterView =  UIScrollView(frame: CGRect(x: contentWidth, y: 0, width: contentWidth, height: UIScreen.main.bounds.height / 2.0))
        scrollFilterView.delegate = self
        scrollFilterView.contentSize = CGSize(width: contentWidth, height: contentHeight)
        
        //create options button
        for (index, title) in filterOptions.enumerated() {
            let button = UIButton(type: .custom)
            button.backgroundColor = .white
            button.frame = CGRect(x: 0, y: buttonHeight * CGFloat(index), width: contentWidth, height: buttonHeight)
            button.layer.borderWidth = 0.5
            button.layer.borderColor = UIColor(red: 203/255.0, green: 208/255.0, blue: 216/255.0, alpha: 1.0).cgColor
            button.setImage(#imageLiteral(resourceName: "check_transparent"), for: .normal)
            button.tag = 0
            button.imageEdgeInsets = UIEdgeInsets(top: 15, left: contentWidth - contentWidth / 7, bottom: 15, right: contentWidth / 20)
            button.setTitleColor(.ecaftRed, for: .normal)
            button.setTitle(title, for: .normal)
            button.titleLabel?.font = UIFont(name: "Helvetica", size: UIScreen.main.bounds.height > 568 ? 12.0 : 10.0)
            button.titleLabel?.numberOfLines = 0
            button.contentHorizontalAlignment = .left
            button.titleEdgeInsets = UIEdgeInsets(top: 0, left: -(contentWidth / 9), bottom: 0, right: (button.currentImage?.size.width)!)
            button.addTarget(self, action: #selector(filterOptionTapped(_:)), for: .touchUpInside)
            scrollFilterView.addSubview(button)
        }

        // make the drop-down menu open/close from the arrow
        let anchorPoint = CGPoint(x: 1 - (filterBarButton?.value(forKey: "view") as! UIView).frame.size.width / 2 / contentWidth, y: 0)
        setAnchorPoint(anchorPoint, forView: scrollFilterView)
        
        view.addSubview(scrollFilterView)
    }
    
    func filterOptionTapped(_ sender: UIButton) {
        let checkImage = sender.tag != 0 ? #imageLiteral(resourceName: "check_transparent") : #imageLiteral(resourceName: "check")
        sender.setImage(checkImage, for: .normal)
        sender.tag = sender.tag == 0 ? 1 : 0
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
    
//    var filtersCollectionView: UICollectionView!
//
//    func makeFilterButtons() {
//        //Filter title
//        filterTitle = UILabel()
//        filterTitle.frame = CGRect(x: 8, y: 40, width: screenSize.width, height: 30)
//        filterTitle.backgroundColor = UIColor.clear
//        filterTitle.font = UIFont(name: "Avenir-Book", size: filterTitle.font.pointSize) //sets label to the font size it already has
//        filterTitle.textColor = UIColor.black
//        filterTitle.textAlignment = NSTextAlignment.left
//        filterTitle.text = "Filters"
//        self.view.addSubview(filterTitle)
//        
//        //Make collection view of filter buttons
//        let flowLayout = UICollectionViewFlowLayout()
//        flowLayout.scrollDirection = .horizontal
//        let filtersCollectionView = UICollectionView(frame: CGRect(x: 0, y: 70, width: screenSize.width, height: 60), collectionViewLayout: flowLayout) //height of collectionView=height of collectionCell
//        filtersCollectionView.backgroundColor = UIColor.clear
//        filtersCollectionView.showsHorizontalScrollIndicator = false //hides horizontal scroll bar
//        filtersCollectionView.register(FilterCollectionViewCell.self, forCellWithReuseIdentifier: cellReuseIdentifier)
//        filtersCollectionView.delegate = self
//        filtersCollectionView.dataSource = self
//        self.view.addSubview(filtersCollectionView)
//        
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 3
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath as IndexPath) as! FilterCollectionViewCell
//        return cell
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width = (screenSize.width-leftAndRightPaddings)/numberOfItemsPerRow
//        return CGSize(width: width, height: collectionView.frame.height)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
//    }
    
    func setAnchorPoint(_ anchorPoint: CGPoint, forView view: UIView) {
        var newPoint = CGPoint(x: view.bounds.size.width * anchorPoint.x, y: view.bounds.size.height * anchorPoint.y)
        var oldPoint = CGPoint(x: view.bounds.size.width * view.layer.anchorPoint.x, y: view.bounds.size.height * view.layer.anchorPoint.y)
        
        newPoint = newPoint.applying(view.transform)
        oldPoint = oldPoint.applying(view.transform)
        
        var position = view.layer.position
        position.x -= oldPoint.x
        position.x += newPoint.x
        
        position.y -= oldPoint.y
        position.y += newPoint.y
        
        view.layer.position = position
        view.layer.anchorPoint = anchorPoint
    }
}
