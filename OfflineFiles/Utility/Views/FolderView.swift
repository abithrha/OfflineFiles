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
    var isFavorite: Bool = true
    
    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: "folder.fill")
                .resizable()
                .scaledToFill()
                .foregroundStyle(Color(hex: color))
                .frame(width: 50, height: 50)
            
            HStack(spacing: 0) {
                Text(folderName)
                    .font(.caption2)
                    .frame(width: 60, alignment: .leading)
                    .padding(.leading, 2)
                
                if isFavorite {
                    Image(systemName: "star.fill")
                        .resizable()
                        .frame(width: 10, height: 10)
                        .foregroundStyle(.yellow)
                }
            }
        }
        .padding(.top)
        .frame(width: 60, height: 100, alignment: .top)
    }
}

#Preview {
    FolderView()
}
