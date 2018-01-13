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
    var filterSections: [FilterSection] = []
    
    override init() {
        super.init()
        
        //Create list of filter section
        filterSections = self.getFilterSections()
    }
    
    private func getFilterSections() -> [FilterSection] {
        //Create array of filterOptionItmes from model filter items
        let majorsItems = majors.map { FilterOptionItem(item: $0, type: FilterType.Majors) }
        let openPosItems = openPositions.map { FilterOptionItem(item: $0, type: FilterType.OpenPositions) }
        let sponsorshipItems = sponsorship.map { FilterOptionItem(item: $0, type: FilterType.Sponsorship) }
        
        //Create sections containing list of filtering options
        let majorsSect = FilterSection(name: "Majors", items: majorsItems)
        let openPosSect = FilterSection(name: "Open Positions", items: openPosItems)
        let sponsorshipSect = FilterSection(name: "Sponsorship", items: sponsorshipItems)
        sponsorshipSect.isAllSelected = false //B/c only has 1 cell
        
        let filterSections = [majorsSect, openPosSect, sponsorshipSect]
        return filterSections
    }
}

extension FilterViewModel: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FilterTableViewCell.identifier) as? FilterTableViewCell else {
            print("Creating custom filter cell error")
            return UITableViewCell()
        }
        let filterSect = filterSections[indexPath.section]
        let filterItems = filterSect.items
        cell.titleLabel?.text = filterItems[indexPath.row].title
        
        //If "All" option selected, highlight "All" option & fade out rest of filter options
        if (filterSect.isAllSelected) {
            if(indexPath.row == 0) {
                cell.checkBtnImageView.image = #imageLiteral(resourceName: "filterCheckmark")
                cell.titleLabel.textColor = UIColor.ecaftBlack
            } else {
                cell.checkBtnImageView.image = #imageLiteral(resourceName: "filterCheckmarkFaded")
                cell.titleLabel.textColor = UIColor.ecaftBlackFaded
            }
        }
        //If "All" option not selected
        else {
            cell.titleLabel.textColor = UIColor.ecaftBlack
            let isSelected = filterItems[indexPath.row].isSelected
            cell.checkBtnImageView.image = isSelected ? #imageLiteral(resourceName: "filterCheckmark") : nil
            
            //If Sponsorship section selected, also toggle label
            if (indexPath.section == 2) {
                cell.titleLabel.text = isSelected ? "Supports Sponsorship" : "Does Not Support Sponsorship" 
            }
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return filterSections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let filterSect = filterSections[section]
        let numRows = filterSect.isExpanded ? filterSect.items.count : 0
        return numRows
    }
    
    // MARK - Custom Header
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterSections[section].isExpanded ? filterSections[section].items.count : 0
    }

}
