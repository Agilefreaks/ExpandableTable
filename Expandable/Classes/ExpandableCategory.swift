//
//  ExpandableCategory.swift
//  Expandable
//
//  Created by Mihai Pantiru on 24/11/2017.
//  Copyright © 2017 mihai. All rights reserved.
//

import Foundation

class ExpandableCategory {
    let title: String
    var items: [ExpandableItem]
    var isExpanded: Bool {
        didSet {
            if isExpanded == false {
                items.forEach({ (item) in
                    item.isExpanded = false
                })
            }
        }
    }
    
    init(title: String, items: [ExpandableItem], isExpanded: Bool = false) {
        self.title = title
        self.items = items
        self.isExpanded = isExpanded
    }
}

class ExpandableItem {
    let title: String
    var isExpanded: Bool
    
    init(title: String, isExpanded: Bool = false) {
        self.title = title
        self.isExpanded = isExpanded
    }
}
