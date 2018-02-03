//
//  ListViewModel.swift
//  ECaFT
//
//  Created by Amanda Ong on 1/27/18.
//  Copyright © 2018 ECAFT. All rights reserved.
//

import Foundation
import UIKit

class ListViewModel: NSObject {
    var userLists : [List] = [List(title: "Favorites (Unvisited)", items: [ ListItem(companyName: "Hi", booth: "B12", isSelected: true)], isSelected: true), List(title: "Startups", items: [], isSelected: false)]
    
    var selectedList: List = List() {
        // When set a new selected list, update user list so only 1 list is selected
        willSet(newList) {
            userLists = userLists.map({
                $0.isSelected = ($0.title == newList.title) ? true : false
                return $0
            })
        }
    }
    
    // File Path to saved Lists
    var listsFilePath: String {
        let manager = FileManager.default
        let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first
        print("this is the url path in the documentDirectory \(String(describing: url))")
        return (url!.appendingPathComponent("listsData").path)
    }
    
    override init() {
        super.init()
        if let userLists = NSKeyedUnarchiver.unarchiveObject(withFile: listsFilePath) as? [List] {
            self.userLists = userLists
        }
        self.selectedList = getSelectedList()
    }
    
    private func getSelectedList() -> List {
        guard let selectedList = userLists.filter({$0.isSelected}).first else {
            return List()
        }
        return selectedList
    }

}


