//
//  ExpandableViewController.swift
//  Expandable
//
//  Created by Mihai Pantiru on 23/11/2017.
//  Copyright © 2017 mihai. All rights reserved.
//

import UIKit

class ExpandableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, FAQSectionHeaderDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    private var categories = [
        ExpandableCategory(title: "Category 1", items:[ExpandableItem(title:"Question 1 Cat 1"), ExpandableItem(title:"Question 2 Cat 1")]),
        ExpandableCategory(title: "Category 2", items:[ExpandableItem(title:"Question 1 Cat 2")]),
        ExpandableCategory(title: "Category 3", items:[ExpandableItem(title:"Question 1 Cat 3")]),
        ExpandableCategory( title: "Category 4", items:[ExpandableItem(title:"Question 1 Cat 4")])
    ]
    
    private let categoryHeaderHeight: CGFloat = 59
    private let cellId = "FAQItemCell"
    
    private weak var selectedCategoryHeader : FAQSectionHeader? {
        willSet {
            selectedCategoryHeader?.currentState = .normal
            
            if let header = selectedCategoryHeader, let _ = newValue {
                categories[header.tag].isExpanded = false
                self.selectedItemCell = nil
                self.handleExpandClose(section: header.tag)
            }
        }
    }
    
    private weak var selectedItemCell : CategoryItemTableViewCell? {
        willSet {
            guard let cell = selectedItemCell else {
                return
            }
            
            guard cell.tag != newValue?.tag else {
                return
            }
            
            cell.currentState = .normal
            
            if let category = selectedCategoryHeader, let _ = newValue {
                self.categories[category.tag].items[cell.tag].isExpanded = false
                self.tableView.reloadRows(at: [IndexPath(row: cell.tag, section: category.tag)], with: .none)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "FAQ"
    
        tableView.register(UINib(nibName:"CategoryItemTableViewCell", bundle: nil), forCellReuseIdentifier: cellId)
    }
    
    // MARK - UITableViewDataSource methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.categories[section].isExpanded == true {
            return self.categories[section].items.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CategoryItemTableViewCell
        let item = categories[indexPath.section].items[indexPath.row]
        cell.tag = indexPath.row
        cell.setupTitle(titleString: item.title)
        cell.currentState = (item.isExpanded == true ? .selected : .normal)
        
        if (item.isExpanded == true) {
            self.selectedItemCell = cell
        }
       
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return categoryHeaderHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = FAQSectionHeader(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: categoryHeaderHeight))
        header.setupTitle(titleString: categories[section].title)
        header.currentState = categories[section].isExpanded ? .selected : .normal
        if (categories[section].isExpanded == true) {
            self.selectedCategoryHeader = header
        }
        
        header.tag = section
        header.delegate = self
        return header
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var item = self.categories[indexPath.section].items[indexPath.row]
        
        let cell = tableView.cellForRow(at: indexPath) as! CategoryItemTableViewCell
        if cell.currentState == .selected {
            item.isExpanded = false
            self.selectedItemCell = nil
        } else {
            item.isExpanded = true
            self.selectedItemCell = cell
        }

        tableView.reloadRows(at: [indexPath], with: .none)
    }
    
    // MARK: - FAQSectionHeaderDelegate
    func didSelectFAQHeader(header: FAQSectionHeader) {
        if header.currentState == .selected {
            self.selectedCategoryHeader = header
            categories[header.tag].isExpanded = true
        } else {
            self.selectedCategoryHeader = nil
            categories[header.tag].isExpanded = false
            self.selectedItemCell = nil
        }
        
        self.handleExpandClose(section: header.tag)
    }
    
    func handleExpandClose(section: Int) {
        var indexPaths = [IndexPath]()
        for row in categories[section].items.indices {
            let indexPath = IndexPath(row: row, section: section)
            indexPaths.append(indexPath)
        }
        
        if categories[section].isExpanded {
            tableView.insertRows(at: indexPaths, with: .fade)
        } else {
            tableView.deleteRows(at: indexPaths, with: .fade)
        }
    }
}
