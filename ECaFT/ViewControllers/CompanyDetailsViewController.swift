//
//  CompanyDetailsViewController.swift
//  ECaFT
//
//  Created by Amanda Ong on 1/6/17.
//  Copyright © 2017 ECAFT. All rights reserved.
//

import UIKit


class CompanyDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let screenSize : CGRect = UIScreen.main.bounds
    var tableView = UITableView()
    var headerView = UIView()
    var company: Company!
    
    var infoSC = informationStateController()
    
    //Table view properties
    var name = UILabel() //company name
    var isFavorite : Bool = false
    var location = UILabel() //company booth location
    
    var favoritesButton = UIButton()
    let sectionTitles : [String] = ["Company Information", "Open Positions", "Majors of Interest", "Sponsorship", "OPT/CPT","Notes"]
    var numOfSections = 6 //number of sections
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let navBarAndStatusBarHeight = (self.navigationController?.navigationBar.frame.size.height)!+UIApplication.shared.statusBarFrame.height
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height - navBarAndStatusBarHeight), style: UITableViewStyle.plain) //sets tableview to size of view below status bar and nav bar
        tableView.delegate      =   self
        tableView.dataSource    =   self
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none //removes cell lines
        
        //Regsiter custom cells and xib files
        tableView.register(CompanyInfoTableViewCell.self, forCellReuseIdentifier: "CompanyInfoTableViewCell")
        //tableView.register(ListTableViewCell.self, forCellReuseIdentifier: "ListTableViewCell")
        tableView.register(UINib(nibName: "ListTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "ListTableViewCell")
        tableView.register(textViewTableViewCell.self, forCellReuseIdentifier: "textViewTableViewCell")
        tableView.register(UINib(nibName: "NotesTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "NotesTableViewCell")

        //Register notification observer for when keyboard shows & hides
        NotificationCenter.default.addObserver(self, selector: #selector(CompanyDetailsViewController.keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(CompanyDetailsViewController.keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardDidHide, object: nil)
        
        self.view.addSubview(self.tableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        createHeaderView() //put method in viewWillAppear so information updated depending on what company is tapped
        if let favs = UserDefaults.standard.object(forKey: Property.favorites.rawValue) as? Data {
            infoSC.favoritesString = NSKeyedUnarchiver.unarchiveObject(with: favs) as! [String]
        }
    }
  
    func createHeaderView() {
        headerView = UIView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 150))
        headerView.backgroundColor = UIColor.white
        tableView.tableHeaderView = headerView
        
        //Add image view
        let imageView = UIImageView(frame: CGRect(x:0, y:0, width:110, height:110))
        imageView.center.y = 0.48*(self.tableView.tableHeaderView?.frame.height)!
        imageView.center.x = 0.2*self.screenSize.width
        imageView.image = company.image
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        self.tableView.tableHeaderView?.addSubview(imageView)
        
        //Create name label
        name = UILabel(frame: CGRect(x: 0.43*screenSize.width, y: 0, width: screenSize.width*0.58, height: 21)) //same x value as location so name & location label are aligned
        name.center.y = 0.18*(self.tableView.tableHeaderView?.frame.height)!
        name.textAlignment = NSTextAlignment.left
        name.text = company.name
        name.font = UIFont.boldSystemFont(ofSize: 20)
        
        //Make name into go into another line if necessary
        name.numberOfLines = 0 //set num of lines to infinity
        name.lineBreakMode = .byWordWrapping
        name.sizeToFit()
        self.tableView.tableHeaderView?.addSubview(name)
        
        //Create booth location label
        location = UILabel(frame: CGRect(x: 0.43*screenSize.width, y: 0, width: screenSize.width*0.75, height: 21))
        location.textAlignment = NSTextAlignment.left
        location.font = UIFont.systemFont(ofSize: 18)
        location.textColor = UIColor.ecaftDarkGray
        location.text = "Booth " + company.location
        self.tableView.tableHeaderView?.addSubview(location)


        //Create favorites button
        favoritesButton.setTitleColor(UIColor.ecaftGold, for: .normal)
        favoritesButton.frame = CGRect(x: 0.38*screenSize.width, y: 0, width: 0.5*screenSize.width, height: 50)
        if(screenSize.height < 667.0) { //iPhone 5s & below
            favoritesButton.frame = CGRect(x: 0.41*screenSize.width, y: 0, width: 0.5*screenSize.width, height: 50)
        }
        favoritesButton.addTarget(self, action: #selector(CompanyDetailsViewController.favoritesButtonPressed(button:)), for: .touchUpInside)
        
        //Move text to left of button image
        favoritesButton.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        favoritesButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        favoritesButton.titleLabel?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        favoritesButton.imageView?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        favoritesButton.centerTextAndImage(spacing: 10)
        
        if (isFavorite) { setUpFavorite() }
        else { setUpNotFavorite() }
        
        self.tableView.tableHeaderView?.addSubview(favoritesButton)
        
        //Calculate num of lines for company name label & adjust booth location label accordingly
        let numLines = Int(name.frame.size.height/name.font.ascender) //Divide height of multiline label by line height of UILabel's font (from text to top of label's frame)
        if (numLines < 2) {
            location.center.y = 0.38*(self.tableView.tableHeaderView?.frame.height)!
            favoritesButton.center.y = 0.57*(self.tableView.tableHeaderView?.frame.height)!
        } else if (numLines == 2){
            location.center.y = 0.53*(self.tableView.tableHeaderView?.frame.height)!
            favoritesButton.center.y = 0.69*(self.tableView.tableHeaderView?.frame.height)!
        } else { //numLines is 3
            location.center.y = 0.66*(self.tableView.tableHeaderView?.frame.height)!
            favoritesButton.center.y = 0.83*(self.tableView.tableHeaderView?.frame.height)!
        }
    }
    
    @objc func favoritesButtonPressed(button: UIButton!) {
        //Add to favorites data list and change uibutton image to filled in star
         if (!isFavorite) { //wants to add company
            setUpFavorite()
            infoSC.favoritesString.append(name.text!)
            isFavorite = true
         }
         else { //wants to remove company
            setUpNotFavorite()
            if let i = infoSC.favoritesString.index(of: name.text!) {
                infoSC.favoritesString.remove(at: i)
            }
            isFavorite = false
         }
        
        UserDefaults.standard.removeObject(forKey: Property.favorites.rawValue)
        let savedData = NSKeyedArchiver.archivedData(withRootObject: infoSC.favoritesString)
        UserDefaults.standard.set(savedData, forKey: Property.favorites.rawValue)
    }
    
    func setUpFavorite() {
        favoritesButton.setImage(#imageLiteral(resourceName: "favoritesFilled"), for: .normal)
        favoritesButton.setTitle("Remove favorites", for: .normal)
    }
    
    func setUpNotFavorite() {
        favoritesButton.setImage(#imageLiteral(resourceName: "favorites"), for: .normal)
        favoritesButton.setTitle("Add to favorites", for: .normal)
    }
    
    /*****-------KEYBOARD: Prevent keyboard from hiding notes text view-----*****/
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardHeight = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height {
            tableView.contentInset = UIEdgeInsetsMake(0, 0, keyboardHeight, 0)
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.2, animations: {
            // For some reason adding inset in keyboardWillShow is animated by itself but removing is not, that's why we have to use animateWithDuration here
            self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        })
    }
    
    /*****------------------------------TABLE VIEW METHODS------------------------------*****/
    //Section: Set number of sections and section headers
    func numberOfSections(in tableView: UITableView) -> Int {
        return numOfSections
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }

    //Section: Change font color and background color for section headers
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let returnedView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 25))
        returnedView.backgroundColor = UIColor.ecaftLightGray
        
        let label = UILabel(frame: CGRect(x: 0.05*screenSize.width, y: 0, width: screenSize.width, height: 25))
        label.center.y = 0.5*label.frame.height
        label.text = self.sectionTitles[section]
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.textColor = .ecaftDarkGray
        returnedView.addSubview(label)
        
        return returnedView
    }

    //Rows: Set num of rows per section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if(section == 0) { //Company information sect
            return 1
        }
        else if (section == 1) { //Open positions sect
            return company.positions.count + 2
        }
        else if (section == 2) { //Majors sect
            return company.majors.count + 2
        } else { //Sponsorship sect, OPT/CPT sect
            return 1
        }
    }
    
    //Rows: Set height for each row    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        var height:CGFloat = 120.0
        if(indexPath.section == 0) { //header section
            height = 200.0
        } else if(indexPath.section == 1) { //open positions section
            if(indexPath.row==0 || indexPath.row==company.positions.count+1) {
                height = 5.0
            } else {
                height = 40.0
            }
        } else if(indexPath.section == 2) { //majors of interest section
            if(indexPath.row==0 || indexPath.row==company.majors.count+1) {
                height = 5.0
            } else {
                height = 40.0
            }
        } else if (indexPath.section == 3) { //sponsorship section (3)
            height = 60.0
        } else if (indexPath.section == 4) { //OPT/CPT section (4)
            height = 40.0
        }
        else { //notes section
            height = 310.0
        }
        return height
    }
    
    //Table: Load in custom cells
    let customCellIdentifier = [0: "CompanyInfoTableViewCell", 1 : "ListTableViewCell", 2 : "ListTableViewCell", 3 : "textViewTableViewCell", 4 : "textViewTableViewCell", 5 : "NotesTableViewCell"]
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let identifier = customCellIdentifier[indexPath.section]
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier!, for: indexPath)
        
        //Remove left indent for text in cell
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        
        //Removes grey highlight over cells
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        if identifier == customCellIdentifier[0] {
            let customCell = cell as! CompanyInfoTableViewCell
            customCell.information = company.information
            customCell.websiteLink = company.website
            return customCell
        } else if identifier == customCellIdentifier[1] {
            let customCell = cell as! ListTableViewCell
            if(indexPath.section == 1) {
                if(indexPath.row > 0 && indexPath.row < company.positions.count+1){
                    customCell.itemLabel.text = company.positions[indexPath.row-1]
                }
            }
            if(indexPath.section == 2) {
                if(indexPath.row > 0 && indexPath.row < company.majors.count+1){
                    customCell.itemLabel.text = company.majors[indexPath.row-1]
                }
            }
            return customCell
        } else if (identifier == customCellIdentifier[3] || identifier == customCellIdentifier[4]) {
            let customCell = cell as! textViewTableViewCell
            if(indexPath.section == 3) {
                print("does sponsor: \(company.sponsor)")
                if(company.sponsor) {
                    customCell.bodyTextView.text = "The company can sponsor the candidate"
                } else {
                    customCell.bodyTextView.text = "The company cannot sponsor the candidate"
                }
            } else if (indexPath.section == 4) {
                if(company.optcpt) {
                    customCell.bodyTextView.text = "The company accepts opt/cpt"
                } else {
                    customCell.bodyTextView.text = "The company does not accept opt/cpt"
                }
            }
            return customCell
        }
        else {
            let customCell = cell as! NotesTableViewCell
            customCell.companyName = company.name
            customCell.notesTextView.tag = indexPath.row
            customCell.placeholderText = "Takes notes about \(company.name) here"
            
            if let savedNote = UserDefaults.standard.string(forKey: company.name) {
                customCell.notesTextView.text = savedNote
            }
            if (customCell.notesTextView.text == "") {
                customCell.applyPlaceholderStyle(customCell.notesTextView, placeholderText: customCell.placeholderText)
            }
            //set up cell & return cell
            return customCell
        }
    }
    
    
    //Table: Stop table cell turning grey when click on cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
    }
    
}

