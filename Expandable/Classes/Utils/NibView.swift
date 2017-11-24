//
//  NibView.swift
//  Epix
//
//  Created by xcode on 07/06/2017.
//  Copyright © 2017 Epix. All rights reserved.
//

import Foundation
import UIKit

class NibView: UIView {
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewFromNib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViewFromNib()
    }
}
