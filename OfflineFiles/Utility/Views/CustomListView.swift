//
//  CustomListView.swift
//  OfflineFiles
//
//  Created by Abith Rajakumaran on 14/01/25.
//

import SwiftUI

struct CustomListView: View {
    let columns = [GridItem(.adaptive(minimum: 80))]
    var isFavoriteFolder: Bool = false
    let folder: [FolderEntity]
    var toggleFavorite: (FolderEntity) -> Void
    var deleteFolder: (FolderEntity) -> Void
    var refresh: () -> Void
    
    var body: some View {
        ScrollView {
            LazyVGrid (columns: columns, content: {
                ForEach(folder) { folder in
                    NavigationLink {
                        FilesView(
                            folderEntity: folder,
                            refresh: refresh
                        )
                    } label: {
                        FolderView(
                            folderName: folder.name ?? "",
                            color: folder.color ?? "",
                            isFavorite: folder.isFavorite
                        ).contextMenu {
                            Button {
                                toggleFavorite(folder)
                            } label: {
                                Label(folder.isFavorite ? "Unfavorite" : "Mark as Favorite",
                                      systemImage: folder.isFavorite ? "star.slash" : "star"
                                )
                            }
                            
                            Button {
                                deleteFolder(folder)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    }
                }
            })
        }
        .tabItem {
            Text(isFavoriteFolder ? "Favorite folder" : "All folder")
            Image(systemName: isFavoriteFolder ? "star.fill" : "folder.circle.fill")
                .renderingMode(.template)
        }
        .tag(isFavoriteFolder ? 1 : 0)
    }
}
