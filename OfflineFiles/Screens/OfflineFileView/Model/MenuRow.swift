//
//  MenuRow.swift
//  OfflineFiles
//
//  Created by Abith Rajakumaran on 14/01/25.
//

import Foundation

struct MenuSection: Identifiable, Hashable {

    let id: String
    let rows: [MenuRow]
    
    init(rows: [MenuRow]) {
        self.id = UUID().uuidString
        self.rows = rows
    }
    static let menuSection: [MenuSection] = [
        MenuSection(rows: [
           MenuRow(title: "Created folder", icon: "folder.badge.plus")
        ]),
        MenuSection(rows: [
            MenuRow(title: "Sort by", icon: "chevron.compact.down")
        ])
    ]
}

struct MenuRow: Identifiable, Hashable {
    
    let id: String
    var title: String
    var icon: String
    
    init(title: String, icon: String) {
        self.id = UUID().uuidString
        self.title = title
        self.icon = icon
    }
    
    static let sortOption: [MenuRow] = [
        MenuRow(title: "Ascending", icon: "arrowshape.up"),
        MenuRow(title: "Descending", icon: "arrowshape.down"),
        MenuRow(title: "Created Date", icon: "calendar.circle")
    ]
    
}
