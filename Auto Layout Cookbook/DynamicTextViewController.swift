/*
    Copyright (C) 2015 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information

    Abstract:
    A view controller that demonstrates how to respond to the user changing the system text size.
*/

import UIKit

class DynamicTextViewController: UIViewController {
    // MARK: Properties
    
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var bodyTextView: UITextView!
    
    var fontChangeObserver: AnyObject?
    
    // MARK: Initialization
    
    deinit {
        if let observer = fontChangeObserver {
            NotificationCenter.default.removeObserver(observer)
        }
    }

    // MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let application = UIApplication.shared
        let notificationCenter = NotificationCenter.default
        let queue = OperationQueue.main
        
        fontChangeObserver = notificationCenter.addObserver(forName: Notification.Name.UIContentSizeCategoryDidChange, object: application, queue: queue, using: { [unowned self ] _ in
            self.titleLabel.font = UIFont.preferredFont(forTextStyle: .title1)
            self.bodyTextView.font = UIFont.preferredFont(forTextStyle: .body)
        })
    }
}
