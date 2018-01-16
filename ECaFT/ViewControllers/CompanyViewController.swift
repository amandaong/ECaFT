//
//  CompanyViewController.swift
//  ECaFT
//
//  Created by Logan Allen on 11/22/16.
//  Copyright © 2016 ECAFT. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseDatabase

class CompanyViewController: UIViewController, UISearchBarDelegate, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource, FilterSelectionProtocol {
    let screenSize : CGRect = UIScreen.main.bounds
    var searchBar : UISearchBar!
    
    // Favorites
    var favoriteUpdateStatus : (Int, String) = (0, "")
    
    // Company Table View
    var companyTableView = UITableView()
    
    // View Models
    var informationStateController: informationStateController?
    var filterViewModel: FilterViewModel?
    
    // Filtering
    // Value sent from Filters VC. Holds filter section w/ selected filter options
    var selectedFilterSects: [FilterSection]?
    
    //Database variables
    var databaseRef: FIRDatabaseReference?
    var storageRef: FIRStorageReference?
    var databaseHandle: FIRDatabaseHandle?
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red:0.97, green:0.97, blue:0.97, alpha:1.0)
        
        makeSearchBar()
        makeFilterButton()
        makeTableView()
        
        // Load data from firebase
        databaseRef = FIRDatabase.database().reference()
        // Reference to logos folder in storage
        storageRef = FIRStorage.storage().reference(forURL: "gs://ecaft-4a6e7.appspot.com/logos")
        
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.topItem?.title = "Companies"
        
        if let favs = UserDefaults.standard.object(forKey: Property.favorites.rawValue) as? Data {
            let temp = NSKeyedUnarchiver.unarchiveObject(with: favs) as! [String]
            if (isViewLoaded) {
                if (temp.count != informationStateController?.favoritesString.count) {
                    informationStateController?.favoritesString = temp
                    companyTableView.reloadData()
                }
            }
        }
        if let selectedFilterSects = selectedFilterSects {
            informationStateController?.applyFilters(filterSections: selectedFilterSects)
            companyTableView.reloadData()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        view.endEditing(true)
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

                company.sponsor = item.childSnapshot(forPath: Property.sponsor.rawValue).value as! Bool
                company.optcpt = item.childSnapshot(forPath: Property.optcpt.rawValue).value as! Bool

                //Get image
                let id = item.childSnapshot(forPath: Property.id.rawValue).value as! String
                let imageName = id + ".png"
                let imageRef = self.storageRef?.child(imageName)
                imageRef?.data(withMaxSize: 1 * 1024 * 1024) { data, error in
                    if let error = error {
                        print((error as Error).localizedDescription)
                    } else if let data = data {
                        // Data for "images/companyid.png" is returned
                        DispatchQueue.main.async { [weak self] in
                            company.image = UIImage(data: data)
                            self?.companyTableView.reloadData() //reload data here b/c this is when you know table view cell will have an image
                        }
                    }
                }
                self.informationStateController?.addCompanyToAllCompanies(company)
                self.informationStateController?.addCompanyToDisplayedCompanies(company)
            }
        })
    }

    /*** -------------------- FILTERING -------------------- ***/
    @objc func filterButtonTapped() {
        var filterViewModel: FilterViewModel
        if (self.filterViewModel != nil) {
            filterViewModel = self.filterViewModel!
        }
        else {
            self.filterViewModel = FilterViewModel()
            filterViewModel = self.filterViewModel!
        }
        let filtersVC = FiltersViewController(filterViewModel: filterViewModel)
        filtersVC.filterSelectionDelegate = self
        self.navigationController?.pushViewController(filtersVC, animated: true)
        
    }
    
    // Set selected filters to filters selected from Filters VC
    func setSelectedFiltersTo(filtersSent: [FilterSection]) {
        self.selectedFilterSects = filtersSent
    }
    
    private func makeFilterButton() {
        let filterButton = UIButton()
        filterButton.setTitle("Filter", for: .normal)
        filterButton.setTitleColor(UIColor.black, for: .normal)
        filterButton.frame = CGRect(x: searchBar.frame.maxX + 9, y: 0, width: screenSize.width*0.2, height: 50)
        filterButton.center.y = searchBar.center.y
        filterButton.addTarget(self, action: #selector(filterButtonTapped), for: .touchUpInside)
        self.view.addSubview(filterButton)
    }
    
    /*** -------------------- SEARCH BAR -------------------- ***/
    // Called whenever text is changed.
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let text = searchText.lowercased()
        if let state = informationStateController {
            state.clearFilter()
            for company in state.allCompanies {
                if company.description.lowercased().range(of: text) != nil {
                    state.addFilteredCompany(company)
                }
            }
        }
        companyTableView.reloadData()
    }
    
    // Called when cancel button is clicked
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        if let state = informationStateController {
            state.clearFilter()
        }
    }
    
    // Called when search button is clicked
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    // Called when keyboard return is pressed
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    private func makeSearchBar() {
        // Make UISearchBar instance
        searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.frame = CGRect(x: 0, y: 0, width: screenSize.width-80, height: 50)
        
        // Style & color
        searchBar.searchBarStyle = UISearchBarStyle.minimal
        searchBar.tintColor = UIColor.ecaftRed
        
        // Buttons & text
        searchBar.returnKeyType = .done
        searchBar.enablesReturnKeyAutomatically = false
        searchBar.placeholder = "company name"
        searchBar.showsCancelButton = false
        searchBar.showsBookmarkButton = false
        searchBar.showsSearchResultsButton = false
        
        view.addSubview(searchBar)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // Disable top bounce on filterView
        scrollView.bounces = scrollView.contentOffset.y > 0
    }
    
    /*** -------------------- TABLE VIEW -------------------- ***/
    private func makeTableView() {
        //Total height of nav bar, status bar, tab bar
        let barHeights = (self.navigationController?.navigationBar.frame.size.height)!+UIApplication.shared.statusBarFrame.height + 100
        
        //edited CGRect to make margins and center it
        companyTableView = UITableView(frame: CGRect(x: 25, y: searchBar.frame.maxY, width: screenSize.width-50, height: screenSize.height - barHeights), style: UITableViewStyle.plain) //sets tableview to size of view below status bar and nav bar
        
        companyTableView.dataSource = self
        companyTableView.delegate = self
        
        //Regsiter custom cells and xib files
        companyTableView.register(UINib(nibName: "CompanyTableViewCell", bundle: nil), forCellReuseIdentifier: "CompanyTableViewCell")
        self.view.addSubview(self.companyTableView)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
   
    //Section: Change font color and background color for section headers
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let screenSize : CGRect = UIScreen.main.bounds
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        headerView.backgroundColor = UIColor.ecaftLightGray
        
        
        let label = UILabel(frame: CGRect(x: 0.05*screenSize.width, y: 0, width: screenSize.width, height: 0))
        label.center.y = 0.5*headerView.frame.height
        label.text = informationStateController?.sectionTitles[section]
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.textColor = .ecaftDarkGray
 
        headerView.addSubview(label)
        
        return nil
    }
 
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 120
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection
        section: Int) -> Int {
        guard let companyViewModel = informationStateController else {
            return 0
        }
        return companyViewModel.displayedCompanies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        guard let company = informationStateController?.displayedCompanies[indexPath.row],
            let customCell: CompanyTableViewCell = tableView.dequeueReusableCell(withIdentifier: CompanyTableViewCell.identifier) as? CompanyTableViewCell else {
                print("CompanyViewController.swift - cellForRowAt method:  Company Table View dequeuing cell error")
                return UITableViewCell()
        }
        
        //Stops cell turning grey when click on it
        customCell.selectionStyle = .none
        customCell.name = company.name
        customCell.location = company.location
        
        //set cell font, color, and size
        customCell.nameLabel.textColor = UIColor.white
        customCell.nameLabel.font = UIFont(name: "Verdana", size: 25)
        customCell.locationLabel.textColor = UIColor.white
        customCell.locationLabel.font = UIFont(name: "Verdana", size: 20)
        
        //set cell borders
        customCell.contentView.layer.borderWidth = 2
        
        let myColor : UIColor = UIColor(red:0.61, green:0.15, blue:0.12, alpha:1.0)
        customCell.contentView.layer.borderColor = myColor.cgColor

        if(company.image != nil) {
            customCell.companyImage.image = company.image
        } else {
            customCell.companyImage.image = #imageLiteral(resourceName: "placeholder")
        }
        
        //added section for background image
        if(company.background != nil) {
            customCell.companyBack.image = company.background
        } else {
            customCell.companyBack.image = #imageLiteral(resourceName: "sample")
        }

        if (informationStateController?.favoritesString.contains(company.name))! {
            company.isFavorite = true
            customCell.favoritesButton.setImage(#imageLiteral(resourceName: "favoritesFilled"), for: .normal)
        } else {
            company.isFavorite = false
            customCell.favoritesButton.setImage(#imageLiteral(resourceName: "favorites"), for: .normal)
        }
        customCell.favoritesButton.tag = indexPath.row
        customCell.favoritesButton.addTarget(self, action: #selector(toggleFavorite(sender:)), for: .touchUpInside)
        
        return customCell
    }
    
    @objc func toggleFavorite(sender: UIButton) {
        let touchPoint = sender.convert(CGPoint(x: 0, y: 0), to: companyTableView)
        let indexPath = companyTableView.indexPathForRow(at: touchPoint)
        var company: Company!
        company = informationStateController?.allCompanies[(indexPath?.row)!]
        
        if (!((informationStateController?.favoritesString.contains((company?.name)!))!)) { //not in favorites
            company.isFavorite = true
            informationStateController?.favoritesString.append((company?.name)!)
            sender.setImage(#imageLiteral(resourceName: "favoritesFilled"), for: .normal)
            informationStateController?.sortFavStrings()
        } else {
            if let index = informationStateController?.favoritesString.index(of: (company?.name)!) { //get index of the company in favorites
                company.isFavorite = false
                informationStateController?.favoritesString.remove(at: index) //remove it
                sender.setImage(#imageLiteral(resourceName: "favorites"), for: .normal)
            }
        }
        
        DispatchQueue.main.async {
            UserDefaults.standard.removeObject(forKey: Property.favorites.rawValue)
            let savedData = NSKeyedArchiver.archivedData(withRootObject: self.informationStateController?.favoritesString)
            UserDefaults.standard.set(savedData, forKey: Property.favorites.rawValue)
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: false)
        let companyDetailsVC = CompanyDetailsViewController()
        companyDetailsVC.company = informationStateController?.displayedCompanies[indexPath.row]
        companyDetailsVC.isFavorite = (informationStateController?.displayedCompanies[indexPath.row].isFavorite)!
        self.show(companyDetailsVC, sender: nil)
    }

}

//Makes constraint errors more readable
extension NSLayoutConstraint {
    
    override open var description: String {
        let id = identifier ?? ""
        return "id: \(id), constant: \(constant)"
    }
}
