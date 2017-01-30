//
//  FavoritesViewController.swift
//  ECaFT
//
//  Created by Logan Allen on 11/25/16.
//  Copyright © 2016 loganallen. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource {
    let screenSize : CGRect = UIScreen.main.bounds

    //Information State Controller
    var informationStateController: informationStateController?
    var companyViewController: CompanyViewController?
    var favoritesTableView = UITableView()
    
    var favorites : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blue
        
        if let favs = UserDefaults.standard.object(forKey: Property.favorites.rawValue) as? Data {
            favorites = NSKeyedUnarchiver.unarchiveObject(with: favs) as! [String]
        }
        
        makeTableView()
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.topItem?.title = "Favorites"
        favoritesTableView.reloadData()
        print("num of favorite companies: \((informationStateController?.favoriteCompanies.count)!)")

    }
    
    func makeTableView() {
        //Total height of nav bar, status bar, tab bar (guesstimated pixel height)
        let barHeights = (self.navigationController?.navigationBar.frame.size.height)!+UIApplication.shared.statusBarFrame.height + 49

        favoritesTableView = UITableView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height - barHeights), style: UITableViewStyle.plain) //sets tableview to size of view below status bar and nav bar
        
        favoritesTableView.dataSource = self
        favoritesTableView.delegate = self
        
        //Regsiter custom cells and xib files
        favoritesTableView.register(FavoritesTableViewCell.classForCoder(), forCellReuseIdentifier: "FavoritesTableViewCell")
        self.view.addSubview(self.favoritesTableView)
    }
    
   
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (informationStateController?.favoriteCompanies.count)!
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let company:Company! = informationStateController?.favoriteCompanies[indexPath.row]
        
        let customCell = tableView.dequeueReusableCell(withIdentifier: "FavoritesTableViewCell") as! FavoritesTableViewCell
        
        //Stops cell turning grey when click on it
        customCell.selectionStyle = .none
        customCell.name = company.name
        customCell.location = company.location
        
        if(company.image != nil) {
            customCell.companyImageView.image = company.image
        } else {
            customCell.companyImageView.image = #imageLiteral(resourceName: "placeholder")
        }
        print(company.isFavorite)
        if (company.isFavorite) {
            customCell.favoritesButton.setImage(#imageLiteral(resourceName: "favoritesFilled"), for: .normal)
        } else {
            customCell.favoritesButton.setImage(#imageLiteral(resourceName: "favorites"), for: .normal)
        }
        customCell.favoritesButton.tag = indexPath.row
        customCell.favoritesButton.addTarget(self, action: #selector(companyViewController?.toggleFavorite(sender:)), for: .touchUpInside)
 
        return customCell
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
