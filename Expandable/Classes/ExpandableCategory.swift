//
//  ExpandableCategory.swift
//  Expandable
//
//  Created by Mihai Pantiru on 24/11/2017.
//  Copyright © 2017 mihai. All rights reserved.
//

import Foundation

struct ExpandableCategory {
    var isExpanded: Bool
    var title: String
    let items: [ExpandableItem]
}

struct ExpandableItem {
    var title: String
}
