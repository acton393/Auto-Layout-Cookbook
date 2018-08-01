/*
    Copyright (C) 2015 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information

    Abstract:
    A class that defines tests to assert that recipes are loaded as expected.
*/

import XCTest

class RecipeTests: XCTestCase {
    // MARK: Properties
    
    let recipeTitles = [
        "Simple Stack View",
        "Nested Stack Views",
        "Dynamic Stack View",
        "Simple Single View",
        "Adaptive Single View",
        "Two Equal Width Views",
        "Two Views with Different Widths",
        "Two Views with Complex Widths",
        "Simple Label and Text Field",
        "Label and Text Field with Dynamic Height",
        "Fixed Height, Aligned Columns",
        "Dynamic Height, Aligned Columns",
        "Two Equal Width Buttons",
        "Three Equal Width Buttons",
        "Defining Equal-Sized White Spaces",
        "Buttons and Size-Classes",
        "Grouping Views",
        "Image Views and Aspect Fit Mode",
        "Image Views and Aspect Ratio Constraints",
        "Dynamic Text and Readability",
        "Self Sizing Table View Cells",
        "Working with Scroll Views",
        "Size Class Specific Layouts",
        "Animating Dynamic Changes",
        "UIKit Dynamics and Auto Layout"
    ]
    
    // MARK: XCTestCase
    
    override func setUp() {
        super.setUp()

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()
        
        XCUIDevice.sharedDevice().orientation = .Portrait
    }
    
    // MARK: Tests
    
    func testRecipeTitlesAndDescriptions() {
        let app = XCUIApplication()
        
        let nextButton = app.buttons["Next"]
        
        for title in recipeTitles {
            // Make sure the title has changed.
            let titleLabel = app.staticTexts[title]
            XCTAssertTrue(titleLabel.exists, "Title label should be \"\(title)\"")
            
            // Make sure information about the recipe can be shown.
            app.buttons["More Info"].tap()

            let infoNavigationBar = app.navigationBars["Information"]
            XCTAssertTrue(infoNavigationBar.exists, "The information view hasn't been shown")
            
            // Close the information view.
            infoNavigationBar.buttons["Done"].tap()
            
            // Tap the "Next" button to move to the next recipe.
            nextButton.tap()
        }

        // Make sure the first recipe is being shown again.
        let firstTitle = recipeTitles.first!
        let titleLabel = app.staticTexts[firstTitle]
        XCTAssertTrue(titleLabel.exists, "Title label should be \"\(firstTitle)\"")
    }
}
