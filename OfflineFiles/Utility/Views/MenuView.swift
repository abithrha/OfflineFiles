//
//  MenuView.swift
//  OfflineFiles
//
//  Created by Abith Rajakumaran on 14/01/25.
//

import SwiftUI

struct MenuView: View {
    var menuSection: [MenuSection] = MenuSection.menuSection
    var menuRow: [MenuRow] = MenuRow.sortOption
    var action: (String) -> Void
    var body: some View {
        ZStack {
            Menu {
                ForEach(menuSection) { menu in
                    Section {
                        ForEach(menu.rows) { row in
                            if row.title == "Sort by" {
                                Menu {
                                    ForEach(menuRow) { option in
                                        SectionElementButton(
                                            title: option.title,
                                            icon: option.icon,
                                            action: action
                                        )
                                    }
                                } label: {
                                    SectionElementButton(title: row.title, icon: "")
                                }
                                
                            } else {
                                SectionElementButton(
                                    title: row.title,
                                    icon: row.icon,
                                    action: action
                                )
                            }
                        }
                    }
                }
            } label: {
                Circle()
                    .fill(.gray.opacity(0.15))
                    .frame(width: 30, height: 30)
                    .overlay {
                        Image(systemName: "ellipsis")
                            .font(.system(size: 13.0, weight: .semibold))
                            .foregroundColor(.black)
                            .padding()
                    }
            }
        }
    }
}

#Preview {
    MenuView() { _ in
        
    }
}
