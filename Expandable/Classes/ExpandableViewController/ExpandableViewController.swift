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
    
    private let categories = ["Category 1", "Category 2", "Category 3", "Category 4"]
    private let categoryHeaderHeight: CGFloat = 59
    
    private weak var selectedCategoryHeader : FAQSectionHeader? {
        willSet {
            selectedCategoryHeader?.currentState = .normal
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "FAQ"
    }

    // MARK - UITableViewDataSource methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FAQItemCell", for: indexPath)
        cell.textLabel?.text = categories[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return categoryHeaderHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = FAQSectionHeader(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: categoryHeaderHeight))
        header.setupTitle(titleString: categories[section])
        header.delegate = self
        return header
    }
    
    // MARK: - FAQSectionHeaderDelegate
    func didSelectFAQHeader(header: FAQSectionHeader) {
        if header.currentState == .selected {
            self.selectedCategoryHeader = header
        } else {
            self.selectedCategoryHeader = nil
        }
    }
}

