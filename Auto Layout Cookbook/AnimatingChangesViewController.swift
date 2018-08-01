/*
    Copyright (C) 2015 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information

    Abstract:
    A view controller that demonstrates animating changes to Auto Layout constraints.
*/

import UIKit

class AnimatingChangesViewController: UIViewController {
    // MARK: Properties 
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var spaceBetweenViewsConstraints: NSLayoutConstraint!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    
    @IBOutlet var topView: UIView!
    @IBOutlet var bottomView: UIView!

    @IBOutlet var offscreenViews: [UIView]!
    
    var timer: Timer?
    
    // MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for view in offscreenViews {
            view.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: Selector.init(("updateViews:")), userInfo: nil, repeats: false)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        timer?.invalidate()
        timer = nil
    }
    
    // MARK: Convenience
    
    func updateViews(timer: Timer) {
        let margins = view.layoutMarginsGuide
        
        let leaving = bottomView
        let entering = cycleViews(current: leaving!)
        
        // Entering view should not have any constraints.
        assert(entering.constraintsAffectingLayout(for: .vertical).count == 0)
        assert(entering.constraintsAffectingLayout(for: .horizontal).count == 0)
        
        view.addSubview(entering)
        
        // Set the initial size and location.
        entering.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        entering.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        entering.heightAnchor.constraint(equalTo: topView.heightAnchor).isActive = true
        
        let newSpaceBetweenViews = topView.topAnchor.constraint(equalTo:entering.bottomAnchor, constant: 20.0)
        newSpaceBetweenViews.isActive = true
        
        // Layout the subviews.
        view.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.25, animations: { [unowned self] in
            // Update the positions.
            self.topConstraint.isActive = false
            self.bottomConstraint.isActive = false
            
            /*
                As the views move into the center of the screen, the space 
                between them should shrink to 8.0 points.
            */
            newSpaceBetweenViews.constant = 8.0
            
            /*
                As the lower view moves off the screen, the space between views 
                should expand back to 20.0 points, pushing it completely off 
                the screen.
            */
            self.spaceBetweenViewsConstraints.constant = 20.0
            
            self.topConstraint = entering.topAnchor.constraint(equalTo:self.topLayoutGuide.bottomAnchor, constant: 20.0)
            self.topConstraint.isActive = true
            
            self.bottomConstraint = self.bottomLayoutGuide.topAnchor.constraint(equalTo: self.topView.bottomAnchor, constant: 20.0)
            self.bottomConstraint.isActive = true
            
            self.view.layoutIfNeeded()
            
            }, completion: { _ in
                
                // All constraints are removed when the view is removed from the view hierarchy.
                self.bottomView.removeFromSuperview()
                
                // Update instance variables.
                self.bottomView = self.topView
                self.topView = entering
                self.spaceBetweenViewsConstraints = newSpaceBetweenViews
                
                // Schedule the next update.
                Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: Selector(("updateViews:")), userInfo: nil, repeats: false)
        })
    }
    
    private func cycleViews(current: UIView) -> UIView {
        let nextView = offscreenViews.removeLast()
        offscreenViews.insert(current, at: 0)
        
        return nextView
    }
}
