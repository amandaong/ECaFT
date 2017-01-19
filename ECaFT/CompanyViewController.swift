//
//  CompanyViewController.swift
//  ECaFT
//
//  Created by Logan Allen on 11/22/16.
//  Copyright © 2016 loganallen. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseDatabase

class CompanyViewController: UIViewController, UISearchBarDelegate, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    let screenSize : CGRect = UIScreen.main.bounds
    var searchBar : UISearchBar!
    var scrollFilterView : UIScrollView!
    var filterTitle : UILabel!
    var isFilterDropDown : Bool!
    var tapsOutsideFilterButton : UIButton!
    var scrollView : UIScrollView!
    var arrowIV : UIImageView!
    var checkIV : UIImageView!
    
    //Filter collection view variables
    let leftAndRightPaddings: CGFloat = 80.0
    let numberOfItemsPerRow: CGFloat = 2.0
    private let cellReuseIdentifier = "collectionCell"
    
    //Company Table View
    var companyTableView = UITableView()
    
    //Information State Controller
    weak var informationStateController: informationStateController?
    
    var databaseRef: FIRDatabaseReference?
    var storageRef: FIRStorageReference?
    var databaseHandle: FIRDatabaseHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.ecaftGray
        
        makeSearchBar()
        makeTableView()
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
        
        //Load data from firebase
        databaseRef = FIRDatabase.database().reference()
        storageRef = FIRStorage.storage().reference(forURL: "gs://ecaft-4a6e7.appspot.com/logos") //reference to logos folder in storage
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.topItem?.title = "Companies"
        UIView.animate(withDuration: 0.0, animations: {
            self.scrollFilterView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
            self.arrowIV.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
        })
    }
    
    func loadData() {
        //Retrive posts and listen for changes
        databaseHandle = databaseRef?.child("companies").observe(.value, with: { (snapshot) in
            for item in snapshot.children.allObjects as! [FIRDataSnapshot] {
                let company = Company()
                company.name = item.childSnapshot(forPath: Property.name.rawValue).value as! String
                company.information = item.childSnapshot(forPath: Property.information.rawValue).value as! String
                company.location = item.childSnapshot(forPath: Property.location.rawValue).value as! String
                
                let majors = item.childSnapshot(forPath: Property.majors.rawValue).value as! String
                company.majors = majors.components(separatedBy: ", ")
                
                let positions = item.childSnapshot(forPath: Property.jobtypes.rawValue).value as! String
                company.positions = positions.components(separatedBy: ", ")
                
                company.website = item.childSnapshot(forPath: Property.website.rawValue).value as! String
                
                print(company)
                print("******************")
                //Get image
                let id = item.childSnapshot(forPath: Property.id.rawValue).value as! String
                let imageName = id + ".png"
                let imageRef = self.storageRef?.child(imageName)
                imageRef?.data(withMaxSize: 1 * 1024 * 1024) { data, error in
                    if let error = error {
                        print((error as Error).localizedDescription)
                    } else if let data = data {
                        // Data for "images/companyid.png" is returned
                        DispatchQueue.main.async {
                            company.image = UIImage(data: data)
                            self.companyTableView.reloadData() //reload data here b/c this is when you know table view cell will have an image
                        }
                    }
                }
                self.informationStateController?.addCompany(company)
            }
            print("************************************")
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
        searchBar.searchBarStyle = UISearchBarStyle.minimal
        searchBar.tintColor = UIColor.ecaftRed
        
        //Buttons & text
        searchBar.placeholder = "Search"
        searchBar.showsCancelButton = false
        searchBar.showsBookmarkButton = false
        searchBar.showsSearchResultsButton = false
        
        view.addSubview(searchBar)
    }

    //Search bar functions
    // called whenever text is changed.
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("Did change text")
        let text = searchText.lowercased()
        if let state = informationStateController {
            state.clearFilter()
            for company in state.companies {
                if company.description.lowercased().range(of: text) != nil {
                    state.addFilteredCompany(company)
                }
            }
        }
        companyTableView.reloadData()
    }
    
    // called when cancel button is clicked
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        if let state = informationStateController {
            state.clearFilter()
        }
    }
    
    // called when search button is clicked
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    // called when keyboard return is pressed
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    //Tableview: Make table view
    func makeTableView() {
        //Total height of nav bar, status bar, tab bar
        let barHeights = (self.navigationController?.navigationBar.frame.size.height)!+UIApplication.shared.statusBarFrame.height + 100
        
        companyTableView = UITableView(frame: CGRect(x: 0, y: searchBar.frame.maxY, width: screenSize.width, height: screenSize.height - barHeights), style: UITableViewStyle.plain) //sets tableview to size of view below status bar and nav bar
        
        companyTableView.dataSource = self
        companyTableView.delegate = self
        
        //Regsiter custom cells and xib files
        companyTableView.register(UINib(nibName: "CompanyTableViewCell", bundle: nil), forCellReuseIdentifier: "CompanyTableViewCell")
        self.view.addSubview(self.companyTableView)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return informationStateController!.numOfSections
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return informationStateController!.sectionTitles[section]
    }
   
    
    //Section: Change font color and background color for section headers
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let screenSize : CGRect = UIScreen.main.bounds
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 28))
        headerView.backgroundColor = UIColor.ecaftLightGray
        
        let label = UILabel(frame: CGRect(x: 0.05*screenSize.width, y: 0, width: screenSize.width, height: 28))
        label.center.y = 0.5*headerView.frame.height
        label.text = informationStateController?.sectionTitles[section]
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.textColor = .ecaftDarkGray
        headerView.addSubview(label)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 70
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection
        section: Int) -> Int {
        var count: Int = 0
        if let state = informationStateController {
            count = searchBar.text == "" ? state.companies.count : state.filteredCompanies.count
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let company: Company = searchBar.text == "" ? informationStateController!.companies[indexPath.row] : informationStateController!.filteredCompanies[indexPath.row]
        let customCell = tableView.dequeueReusableCell(withIdentifier: CompanyTableViewCell.identifier) as! CompanyTableViewCell
        //Stops cell turning grey when click on it
        customCell.selectionStyle = UITableViewCellSelectionStyle.none
        customCell.name = company.name
        customCell.location = company.location
        print("This is the company image: \(company.image)")
        if(company.image != nil) {
            customCell.companyImage.image = company.image
        } else {
            customCell.companyImage.image = #imageLiteral(resourceName: "placeholder")
        }
        return customCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: false)
        let companyDetailsVC = CompanyDetailsViewController()
        companyDetailsVC.company = searchBar.text == "" ? informationStateController?.companies[indexPath.row] : informationStateController?.filteredCompanies[indexPath.row]
        self.show(companyDetailsVC, sender: nil)
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

//Makes constraint errors more readable
extension NSLayoutConstraint {
    
    override open var description: String {
        let id = identifier ?? ""
        return "id: \(id), constant: \(constant)"
    }
}
