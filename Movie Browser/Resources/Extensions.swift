//
//  Extensions.swift
//  Movie Browser
//
//  Created by Mauro Worobiej on 28/09/2020.
//  Copyright © 2020 Mauro Worobiej. All rights reserved.
//

import Foundation
import UIKit

// MARK:- UIView

extension UIView {
    /// Add serverals subviews by using variadic parameters (...)
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}

