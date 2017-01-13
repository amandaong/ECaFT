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
    
    
    
    //For Company Table View
    let numOfSections = 1
    var sectionTitles = ["All Companies", "Favorites", "Other Companies"]
    
    
    func listenForNewData() {
        //Set firebase database reference
        /*
        let recentPostsQuery = ref.child("companies").queryLimited(toFirst: 100) //returns references to each company, limited to first 100 companies
        recentPostsQuery.observe(.childAdded, with: { (snapshot) in
            let company = Company()
            company.name = snapshot.childSnapshot(forPath: Property.name.rawValue).value as! String
            company.location = snapshot.childSnapshot(forPath: Property.location.rawValue).value as! String
            self.companies.append(company)
        })*/
    }
    
    //Returns company object w/ all details filled out
    func getCompanyDetail() {
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

