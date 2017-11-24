//
//  CategoryItemTableViewCell.swift
//  Expandable
//
//  Created by Mihai Pantiru on 24/11/2017.
//  Copyright © 2017 mihai. All rights reserved.
//

import UIKit

extension UIFont {
    static var normalFAQTitleFont: UIFont  { return UIFont(name: "HelveticaNeue", size: 16)! }
    static var selectedFAQTitleFont: UIFont  { return UIFont(name: "HelveticaNeue-Medium", size: 16)!}
}

extension UIColor {
    static var normalFAQItemTextColor: UIColor  { return UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1) }
    static var selectedFAQItemTextColor: UIColor  { return UIColor(red: 244/255, green: 128/255, blue: 36/255, alpha: 1) }
}

enum CategoryItemState {
    case selected
    case normal
}

class CategoryItemTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    var currentState: CategoryItemState = .normal {
        didSet {
            self.setupUI(withState: currentState)
        }
    }
    
    func setupTitle(titleString: String) {
        self.titleLabel.text = titleString
    }
    
    // MARK: - UI setup
    private func setupUI(withState: CategoryItemState) {
        switch currentState {
        case .normal:
            self.titleLabel.textColor = UIColor.normalFAQItemTextColor
            self.titleLabel.font = UIFont.normalFAQTitleFont
        case .selected:
            self.titleLabel.textColor = UIColor.selectedFAQItemTextColor
            self.titleLabel.font = UIFont.selectedFAQTitleFont
        }
    }
}
