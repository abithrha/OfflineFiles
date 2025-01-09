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
        NavigationStack {
            ScrollView {
                LazyVGrid (columns: columns, content: {
                    ForEach(fileViewModel.folders) { folder in
                        FolderView(folderName: folder.name ?? "")
                    }
                })
            }
            .navigationTitle("Files")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        fileViewModel.addFolder()
                    } label: {
                        Image(systemName: "folder.badge.minus")
                    }

                }
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    OfflineFileView()
}
