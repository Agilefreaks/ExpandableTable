//
//  UIView+XibExtension.swift
//  Epix
//
//  Created by xcode on 07/06/2017.
//  Copyright © 2017 Epix. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func setupViewFromNib() {
        let view = viewFromNibForClass()
        view.frame = bounds

        // Auto-layout stuff.
        view.autoresizingMask = [
            UIViewAutoresizing.flexibleWidth,
            UIViewAutoresizing.flexibleHeight,
        ]

        // Show the view.
        addSubview(view)
    }

    func viewFromNibForClass() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return view
    }
}
