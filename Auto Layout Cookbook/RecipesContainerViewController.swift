/*
    Copyright (C) 2015 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information

    Abstract:
    A view controller hosting the various recipes being demonstrated.
*/

import UIKit

class RecipesContainerViewController: UIViewController {
    // MARK: Properties

    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet var navigationButtons: [UIButton]!

    let recipes = Recipe.loadRecipes()
    
    var currentRecipeIndex = 0
    
    var showInstructionsForFullScreenMode = true
    
    // MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Give the container view a border and layout margins.
        containerView.layer.borderWidth = 1.0
        containerView.layer.borderColor = UIColor.black.cgColor
        containerView.layoutMargins = UIEdgeInsets(top: 8.0, left: 8.0, bottom: 8.0, right: 8.0)
        currentRecipeIndex = recipes.startIndex;
        showRecipe(recipe: recipes[currentRecipeIndex])
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let segueIdentifier = segue.identifier, let identifier = CookbookStoryboardIdentifier(rawValue: segueIdentifier) else {
            return
        }
        switch identifier {
        case .InformationView:
            // Fetch the `InformationViewController` from the presented `UINavigationController`
            guard let navigationController = segue.destination as? UINavigationController, let InformationViewController = navigationController.viewControllers.first as? InformationViewController else {
                return
            }
            let recipe = recipes[currentRecipeIndex]
            InformationViewController.informationText = recipe.description
        default:
            /*
                Add a double tap gesture recognizer to presented recipe view controllers.
                This recognizer will dismiss the presented controller.
             */
            let doubleTapGesture = UITapGestureRecognizer(target: self, action: Selector(("handleDismissPresentedViewControllerGestureRecognizer:")))
            doubleTapGesture.numberOfTapsRequired = 2
            doubleTapGesture.numberOfTouchesRequired = 1
            
            segue.destination.view.addGestureRecognizer(doubleTapGesture)
        }
    }
    
    // MARK: Interface Builder actions

    @IBAction func dismissInformationViewController(_ sender: UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func showPreviousRecipe(_ sender: Any) {
        let count = recipes.count
        let index = (recipes.index(before: currentRecipeIndex) + count) % count;
        let recipe = recipes[index]
        
        showRecipe(recipe: recipe)
        currentRecipeIndex = index
    }

    @IBAction func showNextRecipe(_ sender: Any) {
        let count = recipes.count
        let index = recipes.index(after: currentRecipeIndex) % count
        let recipe = recipes[index]
        
        showRecipe(recipe: recipe)
        currentRecipeIndex = index
    }

    @IBAction func displayFullScreen(_ sender: UIGestureRecognizer) {
        guard sender.state == UIGestureRecognizerState.began else { return }
        
        let recipe = recipes[currentRecipeIndex]
        self.performSegue(withIdentifier: recipe.segueIdentifier, sender: nil);
        
        if showInstructionsForFullScreenMode {
            let alertController = UIAlertController.init(title: "Full Screen Mode", message: "Double-tap to exit full screen mode.", preferredStyle: .alert)
            let dismissAction = UIAlertAction.init(title: "OK", style: .cancel, handler: nil)
            let acceptAction = UIAlertAction.init(title: "Don't Show Again", style: .default) { _ in
                self.showInstructionsForFullScreenMode = false
            }
            
            alertController.addAction(dismissAction)
            alertController.addAction(acceptAction)
            
            presentedViewController?.present(alertController, animated: true, completion: nil)
        }
    }

    // MARK: Gesture recognizer handlers
    
    func handleDismissPresentedViewControllerGestureRecognizer(gestureRecognizer: UITapGestureRecognizer) {
        if gestureRecognizer.state == .recognized {
            presentedViewController?.dismiss(animated: true, completion: nil)
        }
    }

    // MARK: Convenience
    
    private func enableButtons(enabled: Bool = true) {
        for button in navigationButtons {
            button.isEnabled = enabled
        }
    }

    private func showRecipe(recipe: Recipe) {
        titleLabel.text = recipe.title
        enableButtons(enabled: false)
        
        let newViewController = recipe.instantiateViewController()
        let oldViewController = childViewControllers[0]
        
        let newView = newViewController.view
        let containerMargins = containerView.layoutMarginsGuide
        newView?.translatesAutoresizingMaskIntoConstraints = false
        addChildViewController(newViewController)
        
        transition(from:oldViewController, to: newViewController, duration: 0.25, options: [.transitionCrossDissolve], animations: {
            newView?.leadingAnchor.constraint(equalTo: containerMargins.leadingAnchor).isActive = true;
            newView?.trailingAnchor.constraint(equalTo: containerMargins.trailingAnchor).isActive = true
            newView?.topAnchor.constraint(equalTo: containerMargins.topAnchor).isActive = true
            newView?.bottomAnchor.constraint(equalTo: containerMargins.bottomAnchor).isActive = true
        }, completion: { [unowned self] _ in
            oldViewController.removeFromParentViewController()
            self.enableButtons()
        })
    }
}

