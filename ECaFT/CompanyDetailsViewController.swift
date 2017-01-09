//
//  CompanyDetailsViewController.swift
//  ECaFT
//
//  Created by Amanda Ong on 1/6/17.
//  Copyright © 2017 loganallen. All rights reserved.
//

import UIKit

class CompanyDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let screenSize : CGRect = UIScreen.main.bounds //DATA LOADING: change let name, location, button to var
    var tableView: UITableView  =   UITableView()
    var headerView = UIView()
    var company: Company!
    var imageUrl:URL = URL(string: "https://s-media-cache-ak0.pinimg.com/originals/cc/77/ef/cc77efac50fd7637763ba7115bc4f17a.png")! //company image
    var name = UILabel() //company name
    var location = UILabel() //company booth location
    
    //favorites button
    var favoritesButton = UIButton()
    let tintedImage = #imageLiteral(resourceName: "favorites").withRenderingMode(UIImageRenderingMode.alwaysTemplate)
    let tintedImageFilled = #imageLiteral(resourceName: "favoritesSelected").withRenderingMode(UIImageRenderingMode.alwaysTemplate)
    
    let titles : [String] = ["Company Information", "Open Positions", "Majors of Interest", "Notes"]
    var numOfSections = 4 //number of sections
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let navBarAndStatusBarHeight = (self.navigationController?.navigationBar.frame.size.height)!+UIApplication.shared.statusBarFrame.height
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height - navBarAndStatusBarHeight), style: UITableViewStyle.plain) //sets tableview to size of view below status bar and nav bar
        tableView.delegate      =   self
        tableView.dataSource    =   self
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none //removes cell lines
        
        //Regsiter custom cells and xib files
        tableView.register(CompanyInfoTableViewCell.classForCoder(), forCellReuseIdentifier: "CompanyInfoTableViewCell")
        tableView.register(ListTableViewCell.classForCoder(), forCellReuseIdentifier: "ListTableViewCell")
        tableView.register(NotesTableViewCell.classForCoder(), forCellReuseIdentifier: "NotesTableViewCell")
        tableView.register(UINib(nibName: "ListTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "ListTableViewCell")
        tableView.register(UINib(nibName: "NotesTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "NotesTableViewCell")

       /* tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
       self.tableView.setNeedsLayout()
        self.tableView.layoutIfNeeded()*/
        self.view.addSubview(self.tableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        createHeaderView()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    func createHeaderView() {
        headerView = UIView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 150))
        headerView.backgroundColor = UIColor.white
        tableView.tableHeaderView = headerView
        
        //Create image view
        // Start background thread so that image loading does not make app unresponsive
        DispatchQueue.global(qos: .userInitiated).async {
            
            let imageData:NSData = NSData(contentsOf: self.imageUrl)!
            let imageView = UIImageView(frame: CGRect(x:0, y:0, width:125, height:125))
            imageView.center.y = 0.5*(self.tableView.tableHeaderView?.frame.height)!
            imageView.center.x = 0.2*self.screenSize.width
            
            // When from background thread, UI needs to be updated on main_queue
            DispatchQueue.main.async {
                let image = UIImage(data: imageData as Data)
                imageView.image = image
                imageView.contentMode = UIViewContentMode.scaleAspectFit
                self.tableView.tableHeaderView?.addSubview(imageView)
            }
        }
        
        //Create name label
        name = UILabel(frame: CGRect(x: 0.39*screenSize.width, y: 0, width: screenSize.width*0.6, height: 21)) //same x value as location so name & location label are aligned
        name.center.y = 0.28*(self.tableView.tableHeaderView?.frame.height)!
        name.textAlignment = NSTextAlignment.left
        name.text = "Amazon Web Services" //DATA LOADING: company.name
        name.font = UIFont.boldSystemFont(ofSize: 20)
        self.tableView.tableHeaderView?.addSubview(name)
        
        //Create booth location label
        location = UILabel(frame: CGRect(x: 0.39*screenSize.width, y: 0, width: screenSize.width*0.75, height: 21))
        location.center.y = 0.48*(self.tableView.tableHeaderView?.frame.height)!
        location.textAlignment = NSTextAlignment.left
        location.font = UIFont.systemFont(ofSize: 18)
        location.textColor = UIColor.ecaftDarkGray
        location.text = "Booth " + "A3-A4" //DATA LOADING: delete "A3-A4" and then uncomment for loop below
        /*for i in 0..<company.locations.count {
            if (i == 0) {
                location.text = location.text! + company.locations[0]
            }
            else {
                location.text = location.text! + "," + company.locations[i] //QUESTION: Using , or - for booth label?
            }
        }*/
        self.tableView.tableHeaderView?.addSubview(location)
        
        //Create favorites button
        favoritesButton.setTitle("Add to favorites", for: .normal)
        favoritesButton.setTitleColor(UIColor.ecaftGold, for: .normal)
        favoritesButton.frame = CGRect(x: 0.47*screenSize.width, y: 0, width: 0.5*screenSize.width, height: 50)
        favoritesButton.center.y = 0.75*(self.tableView.tableHeaderView?.frame.height)!
        favoritesButton.addTarget(self, action: #selector(CompanyDetailsViewController.favoritesButtonPressed(button:)), for: .touchUpInside)
        
        //Tint image gold
        favoritesButton.tintColor = UIColor.ecaftGold
        favoritesButton.setImage(tintedImage, for: .normal)
        
        //Move text to left of button image
        favoritesButton.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        favoritesButton.titleLabel?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        favoritesButton.imageView?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        favoritesButton.centerTextAndImage(spacing: 10)
        
        self.tableView.tableHeaderView?.addSubview(favoritesButton)
    }
    
    func favoritesButtonPressed(button: UIButton!) {
        print("favorites Btn pressed")
        //Add to favorites data list and change uibutton image to filled in star
        /** i.e.
         //wants to add comapny
         if favoritesButton.imageView?.image == tintedImage
         {
           setFilledImage()
           saveCompanies.append(company)
         }
         else //wants to remove company
         {
            setUnfilledImage()
         
         if isCompanySaved(company) {
            removeCompany(company)
         }
         }
         save()
         **/
    }
    
    func setFilledImage() {
        favoritesButton.setImage(tintedImage, for: .normal)
    }
    
    func setUnfilledImage() {
        favoritesButton.setImage(tintedImageFilled, for: .normal)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return numOfSections
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return titles[section]
    }

    
    //Customize font color and background color for each header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let returnedView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 25))
        returnedView.backgroundColor = UIColor(red: 243/255, green: 243/255, blue: 243/255, alpha: 1)
        
        let label = UILabel(frame: CGRect(x: 0.05*screenSize.width, y: 0, width: screenSize.width, height: 25))
        label.center.y = 0.5*label.frame.height
        label.text = self.titles[section]
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.textColor = .ecaftDarkGray
        returnedView.addSubview(label)
        
        return returnedView
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if(section == 0) {
            return 1
        }
        else if (section == 1) {
            return 3+2 //DATA LOADING: company.positions.count + 2 (for 2 blank cells)
        }
        else if (section == 2) {
            return 5+2 //DATA LOADING: company.majors.count + 2 (for 2 blank cells)
        } else {
            return 1
        }
    }
    
    let positions = ["Full-time", "Internships", "Co-op"]
    let majors = ["Computer Science", "Electrical and Computer Engineering", "Information Science", "Mechanical Engineering", "Operations Research"]
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        var height:CGFloat = 120.0
        if(indexPath.section == 0 || indexPath.section == 3) {
            height = 110.0
        } else if(indexPath.section == 1) {
            if (indexPath.row == 0 || indexPath.row == positions.count+1){
                height = 5.0
            }else{
                height = 40.0
            }
        } else if(indexPath.section == 2) {
            if (indexPath.row == 0 || indexPath.row == majors.count+1){
                height = 5.0
            }else{
                height = 40.0
            }
        }
        return height
    }
    
    let customCellIdentifier = [0: "CompanyInfoTableViewCell", 1 : "ListTableViewCell", 2 : "ListTableViewCell", 3 : "NotesTableViewCell"]
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var identifier = customCellIdentifier[indexPath.section]
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier!, for: indexPath)
        //Remove left indent for text in cell
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        if identifier == customCellIdentifier[0] {
            var customCell = cell as! CompanyInfoTableViewCell
            customCell.loadInfo(industry: "Technology", hq: "Seattle, WA")
            //DATA LOADING: company.industry and company.hq
            return customCell
        } else if identifier == customCellIdentifier[1] {
            var customCell = cell as! ListTableViewCell
            if(indexPath.section == 1) {
                if(indexPath.row != 0 && indexPath.row != positions.count+1) {
                    customCell.itemLabel.text = positions[indexPath.row-1] //DATA LOADING: company.positions

                }
            }
            if(indexPath.section == 2) {
                if(indexPath.row != 0 && indexPath.row != majors.count+1) {
                    customCell.itemLabel.text = majors[indexPath.row-1] //DATA LOADING: company.majors
                }
            }
            return customCell
        } else {
            var customCell = cell as! NotesTableViewCell
            customCell.notesTextView.text = ""
            //set up cell & return cell
            return customCell
        }
    }
    
    //Stop table cell turning grey when click on cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
    }
    
}

extension UIButton {
    func centerTextAndImage(spacing: CGFloat) { //adds spacing around button's image & text so they're evenly spaced out
        let insetAmount = spacing / 2
        imageEdgeInsets = UIEdgeInsets(top: 0, left: -insetAmount, bottom: 0, right: insetAmount)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: -insetAmount)
        contentEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: insetAmount)
    }
}
