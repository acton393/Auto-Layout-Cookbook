/*
    Copyright (C) 2015 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information

    Abstract:
    An extension on the Recipe struct to load recipe definitions from a plist file in the application bundle.
*/

import Foundation

extension Recipe {
    
    /// Loads the recipes specified in the `Cookbook.plist` file.
    static func loadRecipes() -> [Recipe] {
        let bundle = Bundle.main
        guard let cookbookURL = bundle.url(forResource: "Cookbook", withExtension: "plist") else {
            fatalError("Unable to determine URL for cookbook plist.")
        }
        guard let fileContents = NSArray.init(contentsOf: cookbookURL) as? [[NSString:NSString]] else {
            fatalError("Unable to load cookbook plist.")
        }
        
        let recipies: [Recipe] = fileContents.compactMap { recipeData in
            // Fetch the recipe information.
            guard let title = recipeData["Title"],
            let descriptionFileName = recipeData["Document"],
                let identifierString = recipeData["Identifier"] else {
                    assertionFailure("Unable to fetch recipe information.")
                    return nil
            }
            
            // Convert the identifier string to an `Identifier` type.
            guard let identifier = CookbookStoryboardIdentifier(rawValue: identifierString as String) else {
                assertionFailure("Invalid recipe identifier: \(identifierString).")
                return nil
            }
            
            // Read the recipe description from the associated file.
            var description: String
            do {
                guard let descriptionURL = bundle.url(forResource: descriptionFileName as String, withExtension: nil) else {
                    fatalError("Unable to determine recipe description URL from fileName: \(descriptionFileName).")
                }
                
                try description = NSString(contentsOf: descriptionURL, encoding: String.Encoding.utf8.rawValue) as String
            }
            catch {
                fatalError("Unable to read recipe description from file")
            }
            
            return Recipe(title: title as String, identifier: identifier, description: description)
        }
        
        return recipies
    }
}
