/*
    Copyright (C) 2015 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information

    Abstract:
    A UITableView class used by SelfSizingTableViewController to demonstrate self sizing table view cells.
*/

import UIKit

class SelfSizingTableViewCell: UITableViewCell {
    // MARK: Properties
    
    static let reuseIdentifier = "TextCell"
    
    @IBOutlet var textView: UITextView!
    
    // MARK: UITableViewCell
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        textView.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        textView.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)
    }
}
