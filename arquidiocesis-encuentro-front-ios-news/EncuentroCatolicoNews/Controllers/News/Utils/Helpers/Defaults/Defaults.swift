//
//  Defaults.swift
//  zeus-ios-sdk-new-social-network
//
//  Created by Miguel Angel Vicario Flores on 07/09/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import UIKit

public class storedData {
    
    //MARK: - Properties
    public static var skip: Int {
        get { retrieve(fileName: "skip") ?? 0 }
        set { save(value: newValue, fileName: "skip") }
    }
    
    public static var groupSkip: Int {
        get { retrieve(fileName: "groupSkip") ?? 0 }
        set { save(value: newValue, fileName: "groupSkip") }
    }
    
    public static var pages: Int {
        get { retrieve(fileName: "pages") ?? 0 }
        set { save(value: newValue, fileName: "pages") }
    }
    
    public static var pagesGroups: Int {
        get { retrieve(fileName: "pages") ?? 0 }
        set { save(value: newValue, fileName: "pages") }
    }

    public static var defaultReactionId: Int {
        get { retrieve(fileName: "defaultReactionId") ?? 0 }
        set { save(value: newValue, fileName: "defaultReactionId") }
    }
    
    public static var numberOfPosts: Int {
        get { retrieve(fileName: "numberOfPosts") ?? 0 }
        set { save(value: newValue, fileName: "numberOfPosts") }
    }
    
    //MARK: - Methods
    private static func save<T>(value: T, fileName: String) {
        UserDefaults.standard.set(value, forKey: fileName)
        UserDefaults.standard.synchronize()
    }
    // GGG Timeline OBTIEN DATOS DE USERDEFAULT
    private static func retrieve<T>(fileName: String) -> T? {
        let result = UserDefaults.standard.object(forKey: fileName)
        return result as? T
    }
}
