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
    let majors = [Filter(title:"All Majors"),
                  Filter(title: "Biological Engineering (BE)", searchValue: "biological engineering"),
                  Filter(title: "Biomedical Engineering (BME)", searchValue: "biomedical engineering"),
                  Filter(title: "Chemical Engineering (ChemE)", searchValue: "chemical engineering"),
                  Filter(title: "Civil Engineering (CE)", searchValue: "civil engineering"),
                  Filter(title: "Computer Science (CS)", searchValue: "computer science"),
                  Filter(title: "Electrical & Computer Engineering (ECE)", searchValue: "electrical and computer engineering"),
                  Filter(title: "Environmental Engineering (EnvE)", searchValue: "environmental engineering"),
                  Filter(title: "Information Science, Systems, And Technology (ISST)", searchValue: "information science systems and technology"),
                  Filter(title: "Materials Science And Engineering (MSE)", searchValue: "materials science"),
                  Filter(title: "Mechanical Engineering (ME)", searchValue: "mechanical engineering"),
                  Filter(title: "Operations Research And Engineering (ORE)", searchValue: "operations research"),
                  Filter(title: "Science of Earth Systems (SES)", searchValue: "science of earth systems")]
    
    let openPositions = [Filter(title:"All Positions"),
                         Filter(title: "Co-op", searchValue: "co op"),
                         Filter(title: "Full Time", searchValue: "full time"),
                         Filter(title: "Internship", searchValue: "internship")]
    
    // Doesn't need a search value bc is either supported or not supported
    let sponsorship = [Filter(title: "Supports Sponorshop")]
    
    // Contains all filtered sections displayed on table view
    var filterSections: [FilterSection] = []
    // Contains filter sections w/ only selected filter option items
    private(set) var selectedFilterSections: [FilterSection] = []
    
    override init() {
        super.init()
        self.filterSections = getDefaultFilterSections()
    }
    
    // Checks if default filter options selected (all Majors, all Positions, may or may not support sponsorship selected)
    func isFiltersOn() -> Bool {
        var allMajors: Bool = false
        var allPositions: Bool = false
        var supportsSponsorship: Bool = false
        
        for filterSect in filterSections {
            switch filterSect.type {
            case .Majors:
                allMajors = filterSect.isAllSelected
            case .OpenPositions:
                allPositions = filterSect.isAllSelected
            case .Sponsorship:
                supportsSponsorship = filterSect.items[0].isSelected
            }
        }
        
        return allMajors && allPositions && !(supportsSponsorship)
    }
    
    /* Returns filter section with containing ONLY selected filter option items
       If "All" option selected, append filter sect */
    func getSelectedFilterSections() -> [FilterSection] {
        var selectedFilterSections: [FilterSection] = []
        for filterSect in filterSections {
            // If select "All" option for majors or positions. Sponsorship's isAllSelected = always false
            if(filterSect.isAllSelected) {
               selectedFilterSections.append(filterSect)
            }
            // If specific filters are selected
            else {
                let selectedItems = getSelectedFilterOptItems(from: filterSect.items)
                let newSect = FilterSection(name: filterSect.name, items: selectedItems, type: filterSect.type, isAllSelected: filterSect.isAllSelected, isExpanded: filterSect.isExpanded)
                selectedFilterSections.append(newSect)
            }
        }
        return selectedFilterSections
    }
    
    // MARK: - Private functions
    private func getSelectedFilterOptItems(from filterOptionItems: [FilterOptionItem]) -> [FilterOptionItem] {
        return filterOptionItems.filter({$0.isSelected})
    }
    
    private func getDefaultFilterSections() -> [FilterSection] {
        // Create array of filterOptionItmes from model filter items
        let majorsItems = majors.map { FilterOptionItem(item: $0, type: FilterType.Majors) }
        let openPosItems = openPositions.map { FilterOptionItem(item: $0, type: FilterType.OpenPositions) }
        let sponsorshipItems = sponsorship.map { FilterOptionItem(item: $0, type: FilterType.Sponsorship, isSelected: false) }
        
        // Create sections containing list of filtering options
        let majorsSect = FilterSection(name: "Majors", items: majorsItems, type: FilterType.Majors)
        let openPosSect = FilterSection(name: "Open Positions", items: openPosItems, type: FilterType.OpenPositions)
        let sponsorshipSect = FilterSection(name: "Sponsorship", items: sponsorshipItems, type: FilterType.Sponsorship)
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
