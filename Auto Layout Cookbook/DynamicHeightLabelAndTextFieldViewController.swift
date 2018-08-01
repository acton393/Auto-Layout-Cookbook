/*
    Copyright (C) 2015 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information

    Abstract:
    A view controller that demonstrates changing the size of elements inside UIStackViews.
*/

import UIKit

class DynamicHeightLabelAndTextFieldViewController: UIViewController {
    // MARK: Properties
    
    @IBOutlet weak var nameLabel: UILabel!
    
    var usingLargeFont = false
    
    var timer: Timer?
    
    // MARK: UIViewController
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(changeFontSizeTimerDidFire(timer:)), userInfo: nil, repeats: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        timer?.invalidate()
        timer = nil
    }
    
    // MARK: Timer

    @objc func changeFontSizeTimerDidFire(timer:Timer){
        // Toggle the font preference.
        usingLargeFont = !usingLargeFont
        // Set the `nameLabel`'s font for the appropriate size.
        nameLabel.font = usingLargeFont ? UIFont.systemFont(ofSize: 32) : UIFont.systemFont(ofSize:17.0)
    }
}
