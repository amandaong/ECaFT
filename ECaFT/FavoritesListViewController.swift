//
//  FavoritesListViewController.swift
//  ECaFT
//
//  Created by Sungmin Kim on 10/18/19.
//  Copyright © 2019 ECAFT. All rights reserved.
//
import UIKit
import SnapKit
import Firebase
import FirebaseDatabase

class FavoritesListViewController: UIViewController, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource, AddRemoveDelegate {
    
    func unstar(company: Company) {
        makeFavoriteList()
        companyTableView.reloadData()
    }
    
    //never called
    func star(company: Company) {
        companyTableView.reloadData()
    }

    //variables
    let screenSize : CGRect = UIScreen.main.bounds
    var companyViewModel: CompanyViewModel!
    var companyTableView = UITableView()
    var favoriteList: [Company] = []
    var noListLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Favorites"
        self.view.backgroundColor = UIColor.backgroundGray
        makeFavoriteList()
        makeTableView()
        noListLabel = UILabel()
        if (favoriteList.count==0) {
            noListLabel.text = "Star a company to favorite it"
        } else {
            noListLabel.text = ""
        }
        noListLabel.textColor = UIColor.gray
        noListLabel.font = UIFont.systemFont(ofSize: 18)
        noListLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(noListLabel)
        if #available(iOS 11.0, *) {
            NSLayoutConstraint.activate([
                //noListLabel.leadingAnchor.constraint(equalTo: noListLabel.trailingAnchor, constant: 32),
                //noListLabel.centerXAnchor.constraint(equalTo: companyTableView.topAnchor, constant: -8),
                noListLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
                noListLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8)
            ])
        } else {
            // Fallback on earlier versions
        }

    }
    
    func viewLoadSetup() {
        makeFavoriteList()
        makeTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        viewLoadSetup()
    }
    
    private func makeFavoriteList() {
        favoriteList = []
        for company in companyViewModel.allCompanies {
            if company.isFavorite {
                favoriteList.append(company)
            }
        }
        companyViewModel.favoriteCompanies = favoriteList
    }
    
    /***------------------------TABLE VIEW---------------------------***/
    private func makeTableView() {
        //Total height of nav bar, status bar, tab bar
        //let barHeights = (self.navigationController?.navigationBar.frame.size.height)!+UIApplication.shared.statusBarFrame.height + 100
        
        //edited CGRect to make margins and center it
        companyTableView = UITableView(frame: CGRect(x: 0, y: 45, width: screenSize.width-28, height: screenSize.height - (45)), style: UITableViewStyle.plain) //sets tableview to size of view below status bar and nav bar
        
        // UI
        companyTableView.backgroundColor = UIColor.backgroundGray
        companyTableView.separatorStyle = UITableViewCellSeparatorStyle.none // Removes bottom border for cells
        //companyTableView.contentInset = UIEdgeInsetsMake(-27, 0, 0, 0) // Removes padding above first cell
        
        //Remove vertical scroll bar
        companyTableView.showsVerticalScrollIndicator = true;
        
        companyTableView.dataSource = self
        companyTableView.delegate = self
        
        //Regsiter custom cells and xib files
        companyTableView.register(UINib(nibName: "CompanyTableViewCell", bundle: nil), forCellReuseIdentifier: "CompanyTableViewCell")
        
        //layout
        companyTableView.center.x = view.center.x
        
        view.addSubview(companyTableView)
        
        /*
         companyTableView.snp.makeConstraints{(make) -> Void in
         //make.left.equalTo(segControl).offset(8)
         //make.right.equalTo(segControl).offset(-8)
         make.top.equalTo(segControl.snp.bottom).offset(16)
         make.bottom.equalTo(view)
         make.centerX.equalTo(segControl)
         }*/
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    /*
     //Section: Change font color and background color for section headers
     func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
     
     let screenSize : CGRect = UIScreen.main.bounds
     let headerView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
     //headerView.backgroundColor = UIColor.ecaftLightGray
     
     let label = UILabel(frame: CGRect(x: 0.05*screenSize.width, y: 0, width: screenSize.width, height: 0))
     label.center.y = 0.5*headerView.frame.height
     //label.text = companyViewModel?.sectionTitles[section]
     label.font = UIFont.boldSystemFont(ofSize: 16.0)
     //label.textColor = UIColor.ecaftBlack
     
     headerView.addSubview(label)
     
     return nil
     }
     */
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 120
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection
        section: Int) -> Int {
        /*
         guard let companyViewModel = companyViewModel else {
         return 0
         }
         return companyViewModel.displayedCompanies.count
         */
        return favoriteList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        /*
         guard let company = companyViewModel?.displayedCompanies[indexPath.row],
         let customCell: CompanyTableViewCell = tableView.dequeueReusableCell(withIdentifier: CompanyTableViewCell.identifier) as? CompanyTableViewCell else {
         print("BrowseViewController.swift - cellForRowAt method:  Company Table View dequeuing cell error")
         return UITableViewCell()
         }
         */
        
        guard let customCell: CompanyTableViewCell = tableView.dequeueReusableCell(withIdentifier: CompanyTableViewCell.identifier) as? CompanyTableViewCell else {
            print("BrowseViewController.swift - cellForRowAt method:  Company Table View dequeuing cell error")
            return UITableViewCell()
        }
        
        //Stops cell turning grey when click on it
        customCell.delegate = self
        customCell.selectionStyle = .none
        let company = favoriteList[indexPath.row]
        customCell.companyForThisCell = company
        customCell.name = company.name
//        customCell.table = company.table
        customCell.img = #imageLiteral(resourceName: "starFilled")
        
        /*
         customCell.name = company.name
         customCell.department = company.department
         */
        
        customCell.backgroundColor = UIColor.white
        
        //set cell borders
        customCell.contentView.layer.borderWidth = 2
        
        let myColor : UIColor = UIColor(red:0.61, green:0.15, blue:0.12, alpha:1.0)
        customCell.contentView.layer.borderColor = myColor.cgColor
        
        return customCell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: false)
        let companyDetailVC = CompanyDetailsViewController()
        let company = favoriteList[indexPath.row]
        companyDetailVC.company = company
        self.show(companyDetailVC, sender: nil)
        
        print("Selected table row \(indexPath.row)")
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
