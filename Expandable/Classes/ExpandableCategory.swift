//
//  ExpandableCategory.swift
//  Expandable
//
//  Created by Mihai Pantiru on 24/11/2017.
//  Copyright © 2017 mihai. All rights reserved.
//

import Foundation

struct ExpandableCategory {
    let title: String
    var items: [ExpandableItem]
    var isExpanded: Bool {
        didSet {
            if isExpanded == false {
                let newItems = items.map({ExpandableItem(title: $0.title, isExpanded: false)})
                items = newItems
            }
        }
    }
}

struct ExpandableItem {
    let title: String
    var isExpanded: Bool
}
