//
//  FavoritesViewController.swift
//  ECaFT
//
//  Created by Logan Allen on 11/25/16.
//  Copyright © 2016 loganallen. All rights reserved.
//

import UIKit
import Firebase

class FavoritesViewController: UITableViewController, FavoritesProtocol {
    var databaseRef: FIRDatabaseReference?
    var storageRef: FIRStorageReference?
    var databaseHandle: FIRDatabaseHandle?
    
    var favorites: [String] = []
    var checks: [Bool]!
    var companies: [Company] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.register(UINib(nibName: "FavoritesTableViewCell", bundle: nil), forCellReuseIdentifier: "FavoritesCell")
        
        databaseRef = FIRDatabase.database().reference()
        storageRef = FIRStorage.storage().reference(forURL: "gs://ecaft-4a6e7.appspot.com/logos")
        DispatchQueue.main.async {
            self.loadCompanyObjects()
            self.companies.sort { $0.name < $1.name }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.topItem?.title = "Favorites"
        
        if let check = UserDefaults.standard.object(forKey: Property.isChecked.rawValue) as? Data {
            checks = NSKeyedUnarchiver.unarchiveObject(with: check) as! [Bool]
            print("finished fetching saved data")
        } else {
            checks = [Bool](repeating: false, count: favorites.count)
            print("error fetching, all false insetead")
        }
        
        if let temp = UserDefaults.standard.object(forKey: Property.favorites.rawValue) as? Data {
            let newOnes = NSKeyedUnarchiver.unarchiveObject(with: temp) as! [String]
            
            if (favorites.count == 0) { //favorites tabbed has not been access yet
                favorites = newOnes
                checks = [Bool](repeatElement(false, count: favorites.count))
            }
            
            else if (newOnes.count > favorites.count) { //added a favorite on the main page
                for i in 0..<newOnes.count {
                    if (i >= favorites.count) {
                        favorites.append(newOnes[i])
                        checks.append(false)
                    }
                    else if (favorites[i] != newOnes[i]) {
                        favorites.insert(newOnes[i], at: i)
                        checks.insert(false, at: i)
                    }
                }
            }
            
            else if (newOnes.count < favorites.count) { //removing a favorite on the main page
                var i = 0
                while (i < favorites.count) {
                    if (i >= newOnes.count) {
                        favorites.remove(at: i)
                        checks.remove(at: i)
                    }
                    else if (newOnes[i] == favorites[i]) {
                        i += 1
                    } else {
                        favorites.remove(at: i)
                        checks.remove(at: i)
                    }
                }
            }
            
            else { //no changes
                return
            }
            
            DispatchQueue.main.async {
                self.loadCompanyObjects()
                self.companies.sort { $0.name < $1.name }
                self.saveChecks()
            }
            tableView.reloadData()
        } else {
            checks = [Bool](repeatElement(false, count: favorites.count))
        }
    }
    
    func changeFavorites(status: Int, name: String) {
        if (status == 2) {
            if let index = favorites.index(of: name) {
                favorites.remove(at: index)
                companies.remove(at: index)
                checks.remove(at: index)
                tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .none)
                UserDefaults.standard.removeObject(forKey: Property.favorites.rawValue)
                let savedData = NSKeyedArchiver.archivedData(withRootObject: favorites)
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
                if (!(self.favorites.contains(company.name))) {
                    continue
                }
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
                self.companies.append(company)
            }
        })
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoritesCell") as! FavoritesTableViewCell
        cell.companyLabel.text = favorites[indexPath.row]
        cell.checkButton.tag = indexPath.row
        cell.checkButton.addTarget(self, action: #selector(toggleCheck(sender:)), for: .touchUpInside)
        if (checks[indexPath.row]) {
            cell.checkButton.setImage(#imageLiteral(resourceName: "check_favorites"), for: .normal)
        } else {
            cell.checkButton.setImage(#imageLiteral(resourceName: "uncheck"), for: .normal)
        }
        
        return cell
    }
    
    func toggleCheck(sender: UIButton) {
        let touchPoint = sender.convert(CGPoint(x: 0, y: 0), to: tableView)
        let indexPath = tableView.indexPathForRow(at: touchPoint)!

        if (checks[indexPath.row]) {
            checks[indexPath.row] = false
            sender.setImage(#imageLiteral(resourceName: "uncheck"), for: .normal)
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
        let detailVC = CompanyDetailsViewController()
        detailVC.company = companies[indexPath.row]
        detailVC.isFavorite = true
        detailVC.delegate = self
        show(detailVC, sender: nil)
        
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
