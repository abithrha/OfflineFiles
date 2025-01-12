//
//  AddFolderView.swift
//  OfflineFiles
//
//  Created by Abith Rajakumaran on 09/01/25.
//

import SwiftUI

struct AddFolderView: View {
    @State var displayError: Bool = false
    @Binding var displayFolderAlert: Bool
    @Binding var folderName: String
    @Binding var color: Color
    @Binding var isFavorite: Bool
    var action: () -> Void
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.ultraThinMaterial)
                .ignoresSafeArea()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .onTapGesture {
                    displayFolderAlert.toggle()
                }
            VStack {
                Text("Create the folder")
                
                VStack(spacing: 16) {
                    TextField("Kindly enter folder name", text: $folderName, onEditingChanged: { _ in
                        displayError = false
                    })
                    .padding()
                    .background(Color.red.opacity(0.3))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .onSubmit {
                        displayError = folderName.isEmpty
                    }
                    .onChange(of: folderName) {
                        displayError = false
                    }
                        
                    
                    ColorPicker(selection: $color, label: {
                        Text("Select the Favorite color")
                    })
                    
                    HStack {
                        Text("Set as favorite folder")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Button(action: {
                            isFavorite.toggle()
                        }, label: {
                            Image(systemName: isFavorite ? "star.fill" : "star")
                                .foregroundStyle(.yellow)
                        })
                    }
                    
                    HStack {
                        Image(systemName: "questionmark.folder.fill")
                        
                        Text("Please enter the folder name")
                            .font(.caption)
                    }
                    .foregroundStyle(Color.red)
                    .hide(if: displayError)
                    
                    Button(
                        action: {
                            displayError = folderName.isEmpty
                            if !folderName.isEmpty {
                                displayFolderAlert.toggle()
                                action()
                            }
                        },
                        label: {
                        Text("Create the Folder!")
                            .padding()
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    })
                    
                }
                .padding()
            }
            .padding()
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(16)
        }
        
    }
    
}

#Preview {
    AddFolderView(
        displayFolderAlert: .constant(true),
        folderName: .constant("true"),
        color: .constant(.red),
        isFavorite: .constant(true)) {
            
        }
}
