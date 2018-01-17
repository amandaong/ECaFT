//
//  informationStateController.swift
//  ECaFT
//
//  Created by Amanda Ong on 1/11/17.
//  Copyright © 2017 ECAFT. All rights reserved.
//

import Foundation

// Company View Model - keep track of company data
class informationStateController {
    
    private(set) var filteredCompanies = [Company]() //for filters
    private(set) var searchBarCompanies = [Company]() //for search bar
    
    var displayedCompanies = [Company]() // Companies to display on company table view
    var allCompanies = [Company]() // Keep track of current info about companies (e.g. isFavorite is changed)
    var favoriteCompanies: [Company] = []
    var favoritesString: [String] = [] // Names of company that are favoritaed (isFavorite = true)

    //For Company Table View
    var numOfSections = 1
    var sectionTitles = ["All Companies", "Favorites", "Other Companies"]
    
    func addCompanyToAllCompanies(_ company: Company) {
        allCompanies.append(company)
    }
    
    func addCompanyToDisplayedCompanies(_ company: Company) {
        displayedCompanies.append(company)
    }
    
    func removeCompany(index: Int) {
        allCompanies.remove(at: index)
    }
    
    func clearCompanies() {
        allCompanies = []
    }
  
    /*** -------------------- FILTERING -------------------- ***/
    // Assumption: Filter Section ONLY contains selected Filter Option Items
    func applyFilters(filterSections: [FilterSection]) {
        var filteredCompaniesSet: Set<Company> = Set(allCompanies)
        
        //Get interesection of filtered companies from 3 sections
        for filterSect in filterSections {
            let filterItems = filterSect.items
            //If "All" option selected for majors/positions. Sponsorship's isAllSelected = always false.
            if(!filterSect.isAllSelected) {
                let selectedCompanies = getCompanies(matching: filterSect)
                let selectedCompanySet = Set(selectedCompanies)
                filteredCompaniesSet = filteredCompaniesSet.intersection(selectedCompanySet)
            }
        }
        
        // Update filtered companies
        filteredCompanies = Array(filteredCompaniesSet)
        
        //Return intersectin of companies filtered by filters & companies filtered by search bar
        if (searchBarCompanies.count > 0) {
            let searchBarCompaniesSet: Set<Company> = Set(searchBarCompanies)
            displayedCompanies = Array(filteredCompaniesSet.intersection(searchBarCompaniesSet))
        } else {
            displayedCompanies = Array(filteredCompaniesSet)
        }
      
        //Companies displayed in alphabetical order
        sortDisplayedCompaniesAlphabetically()
    }
    
    private func getCompanies(matching filterSection: FilterSection) -> [Company] {
        var filteredCompanies: Set<Company> = Set<Company> ()
        switch filterSection.type {
            case .Majors:
                for filterOptItem in filterSection.items {
                    let searchValue = filterOptItem.searchValue?.lowercased()
                    for company in allCompanies {
                        //Insensitive case search
                        let isFound = company.majors.contains(where: { $0.caseInsensitiveCompare(searchValue!) == ComparisonResult.orderedSame })
                        if (isFound) {
                            filteredCompanies.insert(company)
                        }
                    }
                }
            case .OpenPositions:
                for filterOptItem in filterSection.items {
                    let searchValue = filterOptItem.searchValue?.lowercased()
                    for company in allCompanies {
                        //Insensitive case search
                        let isFound = company.positions.contains(where: { $0.caseInsensitiveCompare(searchValue!) == ComparisonResult.orderedSame })
                        if (isFound) {
                            filteredCompanies.insert(company)
                        }
                    }
                }
            case .Sponsorship:
                //If sponsorship section is selected (aka filterSection will have 1 sponsorship filter item)
                if (filterSection.items.count == 1 && filterSection.items[0].isSelected) {
                    for company in allCompanies {
                        if (company.sponsor) {
                            filteredCompanies.insert(company)
                        }
                    }
                } else {
                    return allCompanies
                }
        }
        
        let alphabeticalFilteredCompanies = Array(filteredCompanies).sorted {
            return $0.name.lowercased() < $1.name.lowercased()
        }
        return alphabeticalFilteredCompanies
    }
    
    /*** -------------------- SEARCHING -------------------- ***/
    // Update search bar companies & displayed companies to show companies matching search
    func applySearch(searchText: String) {
        clearSearchBarCompanies() // Clear previous search
        let text = searchText.lowercased()
        let companiesToSearch = (filteredCompanies.count > 0) ? filteredCompanies : allCompanies
        for company in companiesToSearch {
            if company.description.lowercased().range(of: text) != nil {
                searchBarCompanies.append(company)
            }
        }
        // Update displayed companies to search bar companies
        displayedCompanies = searchBarCompanies
        sortDisplayedCompaniesAlphabetically()
    }
    
    func clearSearchBarCompanies() {
        searchBarCompanies = []
    }
    
    func resetDisplayedCompanies() {
        displayedCompanies = (filteredCompanies.count > 0) ? filteredCompanies : allCompanies
    }
    
    func sortFavStrings() {
        favoritesString.sort {
            return $0.lowercased() < $1.lowercased()
        }
    }
    
    func sortDisplayedCompaniesAlphabetically() {
        displayedCompanies.sort {
            return $0.name.lowercased() < $1.name.lowercased()
        }
    }
    
    func sortAllCompaniesAlphabetically() {
        allCompanies.sort {
            return $0.name.lowercased() < $1.name.lowercased()
        }
    }

}

