//
//  SectionElementButton.swift
//  OfflineFiles
//
//  Created by Abith Rajakumaran on 14/01/25.
//

import SwiftUI

struct SectionElementButton: View {
    var title: String
    var icon: String
    var action: ((String) -> Void)?
    var body: some View {
        Button {
            action?(title)
        } label: {
            HStack {
                Text(title)
                    .font(.system(size: 14.0, weight: .medium, design: .default))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                
                Spacer()
                if icon != "" {
                    Image(systemName: icon)
                        .foregroundColor(.white)
                        .font(.system(size: 14.0, weight: .semibold, design: .default))
                }
            }
        }
    }
}

#Preview {
    SectionElementButton(title: "", icon: "") { _ in 
        
    }
}
