/*
    Copyright (C) 2015 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information

    Abstract:
    A view controller that demonstrates how to use UIKit Dynamics in an Auto Layout environment.
*/

import UIKit

class UIKitDynamicsViewController: UIViewController {
    // MARK: Properties
    
    @IBOutlet var dynamicView: UIView!
    
    var animator: UIDynamicAnimator!
    
    var gravity: UIGravityBehavior!
    
    var collision: UICollisionBehavior!
    
    // MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animator = UIDynamicAnimator(referenceView: view)
        
        dynamicView.alpha = 0.0
        view.addSubview(dynamicView)
        
        gravity = UIGravityBehavior(items: [dynamicView])
        
        collision = UICollisionBehavior(items: [dynamicView])
        
        let boundaryInsets = UIEdgeInsets(top: -200.0, left: -20.0, bottom: 20.0, right: 20.0)
        collision.setTranslatesReferenceBoundsIntoBoundary(with: boundaryInsets)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        setOffscreenPosition()
        dropView()
    }
    
    // MARK: Convenience
    
    private func setOffscreenPosition() {
        var center = view.center
        center.y = -dynamicView.frame.height / 2.0
        dynamicView.center = center
        
        animator.removeAllBehaviors()
    }
    
    private func dropView() {
        dynamicView.alpha = 1.0
        animator.addBehavior(gravity)
        animator.addBehavior(collision)
    }
}
