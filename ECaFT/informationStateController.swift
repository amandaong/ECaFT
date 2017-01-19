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
    //For Company Table View
    let numOfSections = 1
    var sectionTitles = ["All Companies", "Favorites", "Other Companies"]
    
    func addCompany(_ company: Company) {
        companies.append(company)
    }
    
    func addFilteredCompany(_ company: Company) {
        filteredCompanies.append(company)
    }
    
    func clearFilter() {
        print("Clearing filter")
        filteredCompanies = []
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

