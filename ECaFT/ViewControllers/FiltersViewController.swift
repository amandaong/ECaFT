//
//  FiltersViewController.swift
//  ECaFT
//
//  Created by Amanda Ong on 11/30/17.
//  Copyright © 2017 ECAFT. All rights reserved.
//
import UIKit

protocol FilterSelectionProtocol {
    func setSelectedFiltersTo(filtersSent: [FilterSection])
}

class FiltersViewController: UIViewController, UITableViewDelegate {
    var filterViewModel: FilterViewModel
    var filtersTableView = UITableView()
    var resetBtn = UIButton()
    let screenSize : CGRect = UIScreen.main.bounds
    
    var filterSelectionDelegate: FilterSelectionProtocol?
    
    init(filterViewModel: FilterViewModel) {
        self.filterViewModel = filterViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("FiltersViewController.swift - init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set navigation bar title
        self.title = "Filters"
        makeTableView()
        makeResetButton()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let selectedFilterSects = filterViewModel.getSelectedFilterSections()
        filterSelectionDelegate?.setSelectedFiltersTo(filtersSent: selectedFilterSects)
    }
    
    /*** -------------------- TABLE VIEW -------------------- ***/
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Get filtering options for specific section (e.g. All Majors, CS, etc)
        let filterSect = filterViewModel.filterSections[indexPath.section]
        let filterOptions = filterSect.items
        // If section is Majors or Open Positions & first cell selected
        if(indexPath.section <= 1 && indexPath.row == 0) {
            let firstRow = indexPath.row
            filterOptions[firstRow].isSelected = !filterOptions[firstRow].isSelected
            filterSect.isAllSelected = !filterSect.isAllSelected
            for index in filterOptions.indices {
                filterOptions[index].isSelected = filterOptions[firstRow].isSelected
            }
        }
        // If section is Majors or Open Positions & any other cell selected
        else if (indexPath.section <= 1 && indexPath.row > 0) {
            filterOptions[indexPath.row].isSelected = !filterOptions[indexPath.row].isSelected
            
            // If all filter cells other than first cell are selected
            if filterOptions.dropFirst().filter({ $0.isSelected }).count == filterOptions.dropFirst().count {
                //Select first cell (the "All" cell)
                filterOptions[0].isSelected = true
                filterSect.isAllSelected = true
            }
            else {
                filterOptions[0].isSelected = false
                filterSect.isAllSelected = false
            }
        }
        // If sponsorship is selected
        else {
            filterOptions[indexPath.row].isSelected = !filterOptions[indexPath.row].isSelected
        }
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return filterViewModel.filterSections[indexPath.section].isExpanded ? UITableViewAutomaticDimension : 0
    }
    
    /*** -------------------- HEADER -------------------- ***/
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let filterSection = filterViewModel.filterSections[section]
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? CollapsibleFilterTableViewHeader ?? CollapsibleFilterTableViewHeader(reuseIdentifier: "header")
        header.backgroundColor = UIColor.ecaftLightGray
        header.titleLabel.textColor = UIColor.ecaftBlack
        header.titleLabel.text = filterViewModel.filterSections[section].name
        header.setExpanded(expanded: filterSection.isExpanded)
        header.section = section
        header.delegate = self
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    /*** -------------------- RESET -------------------- ***/
    @objc func resetButtonTapped() {
        filterViewModel.resetFiltersToDefault()
        filtersTableView.reloadData()
    }
    
    /*** -------------------- PRIVATE FUNCTIONS -------------------- ***/
    private func makeTableView() {
        // Total height of nav bar, status bar, tab bar
        let barHeights = (self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + 50
        let frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height - barHeights)
        
        // Sets tableview to size of view below status bar and nav bar
        filtersTableView = UITableView(frame: frame, style: UITableViewStyle.plain)
        
        filtersTableView.allowsMultipleSelection = true
        filtersTableView.dataSource = filterViewModel
        filtersTableView.delegate = self
        filtersTableView.register(UINib(nibName: "FilterTableViewCell", bundle: nil), forCellReuseIdentifier: "FilterTableViewCell")
        
        // Auto resizing the height of the cell for collapsible sections
        filtersTableView.estimatedRowHeight = 44.0
        filtersTableView.rowHeight = UITableViewAutomaticDimension
        self.view.addSubview(self.filtersTableView)
    }
    
    private func makeResetButton() {
        resetBtn = UIButton(frame: CGRect(x: 0, y: filtersTableView.frame.maxY, width: screenSize.width, height: 50))
        resetBtn.setBackgroundImage(UIImage.imageWithColor(color: UIColor.ecaftRed), for: .normal)
        resetBtn.setBackgroundImage(UIImage.imageWithColor(color: UIColor.ecaftRedLight), for: UIControlState.highlighted)
        resetBtn.tintColor = UIColor.white
        resetBtn.setTitle("Reset", for: .normal)
        resetBtn.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
        self.view.addSubview(resetBtn)
    }

}

extension FiltersViewController: CollapsibleFilterTableViewHeaderDelegate {
    
    func toggleSection(header: CollapsibleFilterTableViewHeader, section: Int) {
        let filterSection = filterViewModel.filterSections[section]
        let isExpanded = !filterSection.isExpanded
        
        // Toggle isExpanded
        filterSection.isExpanded = isExpanded
        header.setExpanded(expanded: isExpanded)
        
        filtersTableView.reloadSections(NSIndexSet(index: section) as IndexSet, with: .automatic)
    }
    
}
