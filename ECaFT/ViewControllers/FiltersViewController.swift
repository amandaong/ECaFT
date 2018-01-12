//
//  FiltersViewController.swift
//  ECaFT
//
//  Created by Amanda Ong on 11/30/17.
//  Copyright © 2017 ECAFT. All rights reserved.
//
import UIKit

class FiltersViewController: UIViewController, UITableViewDelegate {
    let filterViewModel = FilterViewModel()
    var filtersTableView = UITableView()
    let screenSize : CGRect = UIScreen.main.bounds
    let isDefaultSelected = true //Default option = all major, all positions, sponsorship NOT required
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeTableView()
    }
    
    private func makeTableView() {
        //Total height of nav bar, status bar, tab bar
        let barHeights = (self.navigationController?.navigationBar.frame.size.height)!+UIApplication.shared.statusBarFrame.height + 100
        let frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height - barHeights)
        //Sets tableview to size of view below status bar and nav bar
        filtersTableView = UITableView(frame: frame, style: UITableViewStyle.plain)
        
        filtersTableView.allowsMultipleSelection = true
        filtersTableView.dataSource = filterViewModel
        filtersTableView.delegate = self
        filtersTableView.register(UINib(nibName: "FilterTableViewCell", bundle: nil), forCellReuseIdentifier: "FilterTableViewCell")
        self.view.addSubview(self.filtersTableView)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let filterOptions = filterViewModel.filterItems[indexPath.section].1
        filterOptions[indexPath.row].isSelected = true
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let filterOptions = filterViewModel.filterItems[indexPath.section].1
        filterOptions[indexPath.row].isSelected = false
    }
    
}
