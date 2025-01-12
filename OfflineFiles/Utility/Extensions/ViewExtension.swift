//
//  ViewExtension.swift
//  OfflineFiles
//
//  Created by Abith Rajakumaran on 12/01/25.
//

import SwiftUI

struct HideViewModifier: ViewModifier {
    let isHidden: Bool
    @ViewBuilder func body(content: Content) -> some View {
        if isHidden {
            content
        } else {
            EmptyView()
        }
    }
}

extension View {
    func hide(if isHiddden: Bool) -> some View {
        ModifiedContent(content: self,
                        modifier: HideViewModifier(isHidden: isHiddden)
        )
    }
}
