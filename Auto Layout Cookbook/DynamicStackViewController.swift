/*
    Copyright (C) 2015 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information

    Abstract:
    A view controller demonstrating how to dynamically add and remove items from a stack view while animating the change.
*/

import UIKit

class DynamicStackViewController: UIViewController {
    // MARK: Properties
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView: UIStackView!
    
    // MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the scrollview.
        let insets = UIEdgeInsets(top: 20, left: 0.0, bottom: 0.0, right: 0.0)
        scrollView.contentInset = insets
        scrollView.scrollIndicatorInsets = insets
    }
    
    // MARK: Interface Builder actions

    @IBAction func addEntry(_: Any) {
        guard let addButtonContainerView = stackView.arrangedSubviews.last else { fatalError("Expected at least one arranged view in the stack view.") }
        let nextEntryIndex = stackView.arrangedSubviews.count - 1
        
        let offset = CGPoint(x: scrollView.contentOffset.x, y: scrollView.contentOffset.y + addButtonContainerView.bounds.size.height)

        let newEntryView = createEntryView()
        newEntryView.isHidden = true;
        stackView.insertArrangedSubview(newEntryView, at: nextEntryIndex)

        UIView.animate(withDuration: 0.25) {
            newEntryView.isHidden = false
            self.scrollView.contentOffset = offset
        }
    }
    
    func deleteStackView(sender: UIButton) {
        guard let entryView = sender.superview else { return }
        
        UIView.animate(withDuration: 0.25, animations: {
            entryView.isHidden = true
        }) { _ in
            entryView.removeFromSuperview()
        }
    }

    // MARK: Convenience
    
    /// Creates a horizontal stack view entry to place within the parent `stackView`.
    private func createEntryView() -> UIView {
        let date = DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .none)
        let number = NSUUID().uuidString
        
        let stack = UIStackView()
        stack.axis = UILayoutConstraintAxis.horizontal
        stack.alignment = .center
        stack.distribution = UIStackViewDistribution.fill
        stack.spacing = 8
        
        let dateLabel = UILabel()
        dateLabel.text = date
        dateLabel.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)
        
        let numberLabel = UILabel()
        numberLabel.text = number
        numberLabel.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline)
        numberLabel.setContentHuggingPriority(UILayoutPriority.defaultLow - 1.0, for: .horizontal)
       numberLabel.setContentCompressionResistancePriority(.defaultHigh - 1.0, for: .horizontal)
        let deleteButton = UIButton.init(type: .roundedRect)
        deleteButton.setTitle("Delete", for: .normal)
        deleteButton.addTarget(self, action: Selector(("deleteStackView")), for: .touchUpInside)
        
        stack.addArrangedSubview(dateLabel)
        stack.addArrangedSubview(numberLabel)
        stack.addArrangedSubview(deleteButton)
        
        return stack
    }
}
