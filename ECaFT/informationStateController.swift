//
//  informationStateController.swift
//  ECaFT
//
//  Created by Amanda Ong on 1/11/17.
//  Copyright © 2017 loganallen. All rights reserved.
//

import Foundation

//Controls the state of the app (how data stored/transmitted)
class informationStateController {
    
    private(set) var companies = [Company]()
    private(set) var filteredCompanies = [Company]()
    var favoriteCompanies: [Company] = []

    //For Company Table View
    var numOfSections = 1
    var sectionTitles = ["All Companies", "Favorites", "Other Companies"]
    
    func addCompany(_ company: Company) {
        companies.append(company)
    }
    
    func removeCompany(index: Int) {
        companies.remove(at: index)
    }
    
    func clearCompanies() {
        companies = []
    }

    func sortByCompanyName() {
        companies.sort { $0.name < $1.name }
    }
  
    func addFilteredCompany(_ company: Company) {
        filteredCompanies.append(company)
    }
    
    func clearFilter() {
        print("Clearing filter")
        filteredCompanies = []
    }

    func setCompanies(companies: [Company]) {
        self.companies = companies
    }
    
    func sortCompaniesAlphabetically() {
        companies.sort {
            return $0.name < $1.name
        }
    }
    
    func sortFavoritesAlphabetically() {
        favoriteCompanies.sort {
            return $0.name < $1.name
        }
    }
    
    func saveFavoritedCompany() {
        //call core data controller to add company w/ boolean isFavorite true
    }
    
    func saveNotes() {
        //call core data controller to add company w/ note set to note
    }
    
    //Saves data about favorited company and notes to app
    func save() {
        saveFavoritedCompany()
        saveNotes()
    }
}

