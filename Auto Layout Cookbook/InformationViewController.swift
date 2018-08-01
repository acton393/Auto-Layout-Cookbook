/*
    Copyright (C) 2015 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information

    Abstract:
    A view controller for modal presentation of the information about what is being demonstrated.
*/

import UIKit

class InformationViewController: UIViewController {
    // MARK: Properties 
    
    @IBOutlet weak var informationTextView: UITextView!
    
    /// Info supplied by the presenting `RecipiesContainerViewController`.
    var informationText: String?
    
    // MARK: UIViewController
    
    override func viewDidLayoutSubviews() {
        guard let informationText = informationText, !informationText.isEmpty else { fatalError("No information text has been set.") }
        
        
        informationTextView.text = informationText
    }
}
