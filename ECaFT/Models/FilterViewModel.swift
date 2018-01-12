//
//  FilterViewModel.swift
//  ECaFT
//
//  Created by Amanda Ong on 1/12/18.
//  Copyright © 2018 ECAFT. All rights reserved.
//

import Foundation
import UIKit

class FilterViewModel: NSObject {
    let majors = [Filter(title:"All Majors"), Filter(title: "CS"), Filter(title: "ECE"), Filter(title: "IS")]
    let openPositions = [Filter(title:"All Positions"), Filter(title: "Co-op"), Filter(title: "Full Time"), Filter(title: "Internship")]
    let sponsorship = [Filter(title: "Required")]
    var filterItems: [(String, [FilterOptionItem])]
    
    override init() {
        //Create array of filterOptionItmes from model filter items
        let majorsItems = majors.map { FilterOptionItem(item: $0, type: FilterType.Majors) }
        let openPositionsItems = openPositions.map { FilterOptionItem(item: $0, type: FilterType.OpenPositions) }
        let sponsorshipItems = sponsorship.map { FilterOptionItem(item: $0, type: FilterType.Sponsorship) }
        
        //Create list associated for each filter section
        filterItems = [("Majors", majorsItems), ("Open Positions", openPositionsItems), ("Sponsorship", sponsorshipItems)]
    }
}

extension FilterViewModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: FilterTableViewCell.identifier) as? FilterTableViewCell else {
            print("Creating custom filter cell error")
            return UITableViewCell()
        }
        let filterOptions = filterItems[indexPath.section].1
        cell.textLabel?.text = filterOptions[indexPath.row].title
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return filterItems.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numRows = filterItems[section].1.count
        return numRows
    }
    
     func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return filterItems[section].0
    }
}
