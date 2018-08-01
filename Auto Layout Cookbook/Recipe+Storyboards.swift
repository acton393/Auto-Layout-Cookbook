/*
    Copyright (C) 2015 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information

    Abstract:
    An extension on the Recipe struct to provide UIKit related methods and properties.
*/

import UIKit

extension Recipe {

    var segueIdentifier: String {
        return identifier.rawValue
    }
    
    func instantiateViewController() -> UIViewController {
        let storyboard = UIStoryboard(name: identifier.rawValue, bundle: nil)
        return storyboard.instantiateInitialViewController()!
    }
}
