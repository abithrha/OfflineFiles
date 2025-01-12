//
//  FolderView.swift
//  OfflineFiles
//
//  Created by Abith Rajakumaran on 09/01/25.
//

import SwiftUI

struct FolderView: View {
    var folderName: String = ""
    var color: String = ""
    
    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: "folder.fill")
                .resizable()
                .scaledToFill()
                .foregroundStyle(Color(hex: color))
                .frame(width: 50, height: 50)
            
            Text(folderName)
                .font(.caption2)
                .frame(width: 60, alignment: .leading)
            
        }
        .frame(width: 60)
    }
}

#Preview {
    FolderView()
}
