/*
    Copyright (C) 2015 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information

    Abstract:
    A view controller that demonstrates changing the size of elements inside UIStackViews.
*/

import UIKit

class DynamicHeightColumnsViewController: UIViewController {
    // MARK: Properties
    
    @IBOutlet var labels: [UILabel]!
    
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
    @objc func changeFontSizeTimerDidFire(timer:Timer)
    {
        // Toggle the font preference.
        usingLargeFont = !usingLargeFont
        
        // Determine which font should now be used.
        let font = usingLargeFont ? UIFont.systemFont(ofSize: 36.0) : UIFont.systemFont(ofSize: 17.0)
        
        for label in labels {
            label.font = font
        }
    }
}
