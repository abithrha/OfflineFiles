//
//  ContentView.swift
//  OfflineFiles
//
//  Created by Abith Rajakumaran on 08/01/25.
//

import SwiftUI

struct OfflineFileView: View {
    @State var fileViewModel: OfflineFileViewModel = OfflineFileViewModel.init()
    
    var body: some View {
        ZStack {
            NavigationStack {
                TabView {
                    CustomListView(
                        folder: fileViewModel.folders,
                        toggleFavorite: fileViewModel.toggleFavorite(for:),
                        deleteFolder: fileViewModel.deleteFolder(_:)
                    ) {
                        fileViewModel.saveAndFetchFolderData()
                    }
                    CustomListView(
                        isFavoriteFolder: true, 
                        folder: fileViewModel.favoriteFolder,
                        toggleFavorite: fileViewModel.toggleFavorite(for:),
                        deleteFolder: fileViewModel.deleteFolder(_:)
                    ) {
                        fileViewModel.saveAndFetchFolderData()
                    }
                }
                .navigationTitle(StringConstant.folderLibrary)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        MenuView() { title in
                            switch title {
                            case "Created folder":
                                fileViewModel.displayFolderAlert.toggle()
                            case "Ascending":
                                fileViewModel.sortFolders(sort: .ascending)
                            case "Descending":
                                fileViewModel.sortFolders(sort: .descending)
                            case "Created Date":
                                fileViewModel.sortFolders(sort: .createdDate)
                            default: break
                            }
                        }
                    }
                }
            }
            
            Text(StringConstant.noFolders)
                .font(.title)
                .bold()
                .hide(if: fileViewModel.folders.isEmpty)
            
            AddFolderView(
                displayFolderAlert: $fileViewModel.displayFolderAlert,
                folderName: $fileViewModel.folderName,
                color: $fileViewModel.folderColor,
                isFavorite: $fileViewModel.isFavoriteFolder,
                action: fileViewModel.addFolder
            )
            .hide(if: fileViewModel.displayFolderAlert)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    OfflineFileView()
}
