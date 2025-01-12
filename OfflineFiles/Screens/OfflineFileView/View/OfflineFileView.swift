//
//  ContentView.swift
//  OfflineFiles
//
//  Created by Abith Rajakumaran on 08/01/25.
//

import SwiftUI

struct OfflineFileView: View {
    @State var fileViewModel: OfflineFileViewModel = OfflineFileViewModel.init()
    let columns = [GridItem(.adaptive(minimum: 80))]
    
    var body: some View {
        ZStack {
            NavigationStack {
                ScrollView {
                    LazyVGrid (columns: columns, content: {
                        ForEach(fileViewModel.folders) { folder in
                            FolderView(
                                folderName: folder.name ?? "",
                                color: folder.color ?? ""
                            )
                        }
                    })
                }
                .navigationTitle("Files")
                .toolbar {
                    ToolbarItem(placement: .primaryAction) {
                        HStack {
                            Text("Sort by")
                            Picker("Sort by", selection: $fileViewModel.sortby) {
                                ForEach(SortOption.allCases) { value in
                                    Text(value.rawValue)
                                }
                            }
                            Button {
                                withAnimation {
                                    fileViewModel.displayFolderAlert.toggle()
                                }
                            } label: {
                                Image(systemName: "folder.badge.plus")
                            }
                        }
                        
                    }
                }
            }
            
            Text("No Folders added")
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
