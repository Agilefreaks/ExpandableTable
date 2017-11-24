//
//  FAQSectionHeader.swift
//  Expandable
//
//  Created by Mihai Pantiru on 23/11/2017.
//  Copyright © 2017 mihai. All rights reserved.
//

import UIKit

extension UIColor {
    static var normalFAQSectionColor: UIColor  { return UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1) }
    static var selectedFAQSectionColor: UIColor  { return UIColor(red: 105/255, green: 105/255, blue: 105/255, alpha: 1) }
}

enum FAQHeaderState {
    case selected
    case normal
}

protocol FAQSectionHeaderDelegate: class {
    func didSelectFAQHeader(header: FAQSectionHeader)
}

class FAQSectionHeader: NibView {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var arrowImageView: UIImageView!
    
    var currentState: FAQHeaderState = .normal {
        didSet {
            self.setupUI(withState: currentState)
        }
    }
    
    weak var delegate: FAQSectionHeaderDelegate?
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI(withState: currentState)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Setup methods
    func setupUI(withState state: FAQHeaderState = .normal) {
        switch state {
        case .normal:
            self.backgroundColor = UIColor.normalFAQSectionColor
            UIView.animate(withDuration: 0.5, animations: {
                self.arrowImageView.transform = CGAffineTransform.identity
            })
        case .selected:
            self.backgroundColor = UIColor.selectedFAQSectionColor
            UIView.animate(withDuration: 0.7, animations: {
                self.arrowImageView.transform = CGAffineTransform.init(rotationAngle: CGFloat(Double.pi))
            })
        }
    }
    
    func setupTitle(titleString: String) {
        self.titleLabel.text = titleString
    }
    
    // MARK: - Actions
    @IBAction func selectAction(_ sender: UIButton) {
        switch self.currentState {
        case .normal:
            self.currentState = .selected
        case .selected:
            self.currentState = .normal
        }
        self.delegate?.didSelectFAQHeader(header: self)
    }
}
