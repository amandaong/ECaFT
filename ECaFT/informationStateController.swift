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
    //For Company Table View
    let numOfSections = 1
    var sectionTitles = ["All Companies", "Favorites", "Other Companies"]
    
    func addCompany(company:Company) {
        companies.append(company)
    }
    
    func removeCompany(index: Int) {
        companies.remove(at: index)
    }
    
    func clearCompanies() {
        companies = []
    }
    
    func setCompanies(companies: [Company]) {
        self.companies = companies
    }
    
    func sortCompaniesAlphabetically() {
        companies.sort {
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

