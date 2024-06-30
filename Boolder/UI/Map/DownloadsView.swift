//
//  DownloadsView.swift
//  Boolder
//
//  Created by Nicolas Mondollot on 28/06/2024.
//  Copyright © 2024 Nicolas Mondollot. All rights reserved.
//

import SwiftUI

struct DownloadsView: View {
    @Environment(\.presentationMode) var presentationMode
    
    let mapState: MapState
    let area: Area
    
    var body: some View {
        NavigationView {
            List {
                
                Section {
                    
                    Button {
                        //
                    } label: {
                        HStack {
                            
                            VStack(alignment: .leading) {
                                Text(area.name).foregroundColor(.primary)
                                Text("\(Int(area.photosSize.rounded())) Mo").foregroundStyle(.gray).font(.caption)
                            }
                            
                            
                            Spacer()
                            
                            Image(systemName: "arrow.down.circle").font(.title2)
                            
                        }
                    }
                }
            
                
                Section {
                    NavigationLink {
                        List {
                            ForEach(area.otherAreasOnSameCluster) { a in
                                HStack {
                                    Text(a.name)
                                    Spacer()
                                    Text("\(Int(a.photosSize.rounded())) Mo").foregroundStyle(.gray)
                                    
                                }
                            }
                        }
                    } label: {
                        HStack {
                            
                            VStack(alignment: .leading) {
                                Text("Secteurs voisins")
                            }
                            
                            Spacer()
                            
                            Text("\(area.otherAreasOnSameCluster.count)").foregroundStyle(.gray)
                            
                        }
                    }
                    
                }
                
                
                
            }
            .navigationTitle("Télécharger")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Fermer")
                        .padding(.vertical)
                        .font(.body)
                }
            )
        }
    }
}

//#Preview {
//    DownloadsView()
//}
