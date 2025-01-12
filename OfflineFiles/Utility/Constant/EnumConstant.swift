//
//  EnumConstant.swift
//  OfflineFiles
//
//  Created by Abith Rajakumaran on 12/01/25.
//

import Foundation

enum SortOption: String, CaseIterable, Identifiable {
    case name = "Name"
    case creationDate = "Creation date"
    case none
    var id: Self { self }
}
