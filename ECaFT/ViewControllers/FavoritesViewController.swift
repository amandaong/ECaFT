//
//  FavoritesViewController.swift
//  ECaFT
//
//  Created by Logan Allen on 11/25/16.
//  Copyright © 2016 ECAFT. All rights reserved.
//

import UIKit
import Firebase

class FavoritesViewController: UITableViewController {
    var databaseRef: FIRDatabaseReference?
    var storageRef: FIRStorageReference?
    var databaseHandle: FIRDatabaseHandle?
    
    var infoSC: informationStateController = informationStateController()
    var checks: [Bool]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.register(UINib(nibName: "FavoritesTableViewCell", bundle: nil), forCellReuseIdentifier: "FavoritesCell")
        
        databaseRef = FIRDatabase.database().reference()
        storageRef = FIRStorage.storage().reference(forURL: "gs://ecaft-4a6e7.appspot.com/logos")
        DispatchQueue.main.async {
            self.loadCompanyObjects()
            self.infoSC.sortAllCompaniesAlphabetically()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.topItem?.title = "Favorites"
        
        if let check = UserDefaults.standard.object(forKey: Property.isChecked.rawValue) as? Data {
            checks = NSKeyedUnarchiver.unarchiveObject(with: check) as! [Bool]
            print("finished fetching saved data")
        } else {
            checks = [Bool](repeating: false, count: infoSC.favoritesString.count)
            print("error fetching, all false insetead")
        }
        
        if let temp = UserDefaults.standard.object(forKey: Property.favorites.rawValue) as? Data {
            let newOnes = NSKeyedUnarchiver.unarchiveObject(with: temp) as! [String]
            
            if (infoSC.favoritesString.count == 0) { //favorites tabbed has not been access yet
                infoSC.favoritesString = newOnes
                if (!(checks.contains(true))) {
                    checks = [Bool](repeating: false, count: infoSC.favoritesString.count)
                }
            }
            
            else if (newOnes.count > infoSC.favoritesString.count) { //added a favorite on the main page
                for i in 0..<newOnes.count {
                    if (i >= infoSC.favoritesString.count) {
                        infoSC.favoritesString.append(newOnes[i])
                        checks.append(false)
                    }
                    else if (infoSC.favoritesString[i] != newOnes[i]) {
                        infoSC.favoritesString.insert(newOnes[i], at: i)
                        checks.insert(false, at: i)
                    }
                }
            }
            
            else if (newOnes.count < infoSC.favoritesString.count) { //removing a favorite on the main page
                var i = 0
                while (i < infoSC.favoritesString.count) {
                    if (i >= newOnes.count) {
                        infoSC.favoritesString.remove(at: i)
                        checks.remove(at: i)
                    }
                    else if (newOnes[i] == infoSC.favoritesString[i]) {
                        i += 1
                    } else {
                        infoSC.favoritesString.remove(at: i)
                        checks.remove(at: i)
                    }
                }
            }
            
            else { //no changes
                return
            }
            
            DispatchQueue.main.async {
                self.infoSC.favoritesString.sort()
                self.infoSC.clearCompanies()
                self.loadCompanyObjects()
                self.infoSC.sortAllCompaniesAlphabetically()
                self.saveChecks()
            }
            tableView.reloadData()
        } else {
            checks = [Bool](repeatElement(false, count: infoSC.favoritesString.count))
        }
    }
    
    func changeFavorites(status: Int, name: String) {
        if (status == 2) {
            if let index = infoSC.favoritesString.index(of: name) {
                infoSC.favoritesString.remove(at: index)
                self.infoSC.removeCompany(index: index)
                checks.remove(at: index)
                tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .none)
                UserDefaults.standard.removeObject(forKey: Property.favorites.rawValue)
                let savedData = NSKeyedArchiver.archivedData(withRootObject: infoSC.favoritesString)
                UserDefaults.standard.set(savedData, forKey: Property.favorites.rawValue)
            }
        }
    }
    
    func loadCompanyObjects() {
        //Retrive posts and listen for changes
        databaseHandle = databaseRef?.child("companies").observe(.value, with: { (snapshot) in
            for item in snapshot.children.allObjects as! [FIRDataSnapshot] {
                let company = Company()
                company.name = item.childSnapshot(forPath: Property.name.rawValue).value as! String
                let isFavCompany = self.infoSC.favoritesString.contains(company.name)
                if (!isFavCompany) {
                    continue
                }
                print("\(company.name) is good")
                company.information = item.childSnapshot(forPath: Property.information.rawValue).value as! String
                company.location = item.childSnapshot(forPath: Property.location.rawValue).value as! String
                
                let majors = item.childSnapshot(forPath: Property.majors.rawValue).value as! String
                company.majors = majors.components(separatedBy: ", ")
                
                let positions = item.childSnapshot(forPath: Property.jobtypes.rawValue).value as! String
                company.positions = positions.components(separatedBy: ", ")
                
                company.website = item.childSnapshot(forPath: Property.website.rawValue).value as! String
                
                let id = item.childSnapshot(forPath: Property.id.rawValue).value as! String
                let imageName = id + ".png"
                let imageRef = self.storageRef?.child(imageName)
                imageRef?.data(withMaxSize: 1 * 1024 * 1024) { data, error in
                    if let error = error {
                        print((error as Error).localizedDescription)
                    } else if let data = data {
                        // Data for "images/companyid.png" is returned
                        company.image = UIImage(data: data)
                        
                    }
                }
                self.infoSC.addCompany(company)
                
            }
        })
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return infoSC.favoritesString.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoritesCell") as! FavoritesTableViewCell
        cell.companyLabel.text = infoSC.favoritesString[indexPath.row]
        cell.checkButton.tag = indexPath.row
        cell.checkButton.addTarget(self, action: #selector(toggleCheck(sender:)), for: .touchUpInside)
        if (checks[indexPath.row]) {
            cell.checkButton.setImage(#imageLiteral(resourceName: "check_favorites"), for: .normal)
        } else {
            cell.checkButton.setImage(#imageLiteral(resourceName: "uncheck_favorites"), for: .normal)
        }
        
        return cell
    }
    
    @objc func toggleCheck(sender: UIButton) {
        let touchPoint = sender.convert(CGPoint(x: 0, y: 0), to: tableView)
        let indexPath = tableView.indexPathForRow(at: touchPoint)!

        if (checks[indexPath.row]) {
            checks[indexPath.row] = false
            sender.setImage(#imageLiteral(resourceName: "uncheck_favorites"), for: .normal)
        } else {
            checks[indexPath.row] = true
            sender.setImage(#imageLiteral(resourceName: "check_favorites"), for: .normal)
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.saveChecks()
        }
    }
    
    func saveChecks() {
        UserDefaults.standard.removeObject(forKey: Property.isChecked.rawValue)
        let savedData = NSKeyedArchiver.archivedData(withRootObject: checks)
        UserDefaults.standard.set(savedData, forKey: Property.isChecked.rawValue)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("row: \(indexPath.row)\n")
        for company in infoSC.allCompanies {
            print("\(company.name), ")
        }
        let detailVC = CompanyDetailsViewController()
        detailVC.company = infoSC.allCompanies[indexPath.row]
        detailVC.isFavorite = true
        show(detailVC, sender: nil)
    }
}
