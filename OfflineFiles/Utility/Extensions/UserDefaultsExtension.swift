//
//  UserDefaultsExtension.swift
//  OfflineFiles
//
//  Created by Abith Rajakumaran on 14/01/25.
//

import Foundation

extension UserDefaults {
    private enum Keys {
        static let sortOption = "sortOption"
    }
    
    func setSortOption(_ option: SortOption) {
        set(option.rawValue, forKey: Keys.sortOption)
    }
    
    func getSortOption() -> SortOption {
        if let rawValue = string(forKey: Keys.sortOption),
           let option = SortOption(rawValue: rawValue) {
            return option
        }
        return .none
    }
}

