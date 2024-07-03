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
    
//    let mapState: MapState
    let cluster: Cluster
    let area: Area?
    
    @State private var presentRemoveDownloadSheet = false
    @State private var presentCancelDownloadSheet = false
    @State private var areaToEdit : Area = Area.load(id: 1)! // FIXME
    
//    private func otherClusters(except: Cluster) -> [Cluster] {
//        Cluster.troisPignons
//        
//        return Array(
//            Set(Cluster.troisPignons).subtracting(Set([except]))
//        )
//    }
    
    var mainArea : Area {
        area ?? cluster.mainArea
    }
    
//    var title: String {
//        if area == nil && cluster.troisPignons {
//            return "Trois Pignons"
//        }
//        else {
//            return mainArea.cluster?.name ?? ""
//        }
//    }
    
    var areasToDisplay: [Area] {
        mainArea.otherAreasOnSameClusterSorted.map{$0.area}
    }
    
    private var footer: some View {
        Text("Téléchargez les secteurs en avance pour utiliser Boolder en mode hors-connexion.")
    }
    
    var body: some View {
        NavigationView {
            List {

                Section {
                    ForEach(areasToDisplay) { a in
                        
                        HStack {
                            Text(a.name).foregroundColor(.primary)
                            
                            Spacer()
                            
                            DownloadAreaButtonView(area: a, areaToEdit: $areaToEdit, presentRemoveDownloadSheet: $presentRemoveDownloadSheet, presentCancelDownloadSheet: $presentCancelDownloadSheet)
                        }
                    }
                }
                
            }
            .background {
                EmptyView().actionSheet(isPresented: $presentRemoveDownloadSheet) {
                    ActionSheet(
                        title: Text("area.photos.remove.title"),
                        buttons: [
                            .destructive(Text("area.photos.remove.action")) {
                                DownloadCenter.shared.areaDownloader(id: areaToEdit.id).remove()
                            },
                            .cancel()
                        ]
                    )
                }
            }
            .background {
                EmptyView().actionSheet(isPresented: $presentCancelDownloadSheet) {
                    ActionSheet(
                        title: Text("area.photos.cancel.title"),
                        buttons: [
                            .destructive(Text("area.photos.cancel.action")) {
                                DownloadCenter.shared.areaDownloader(id: areaToEdit.id).cancel()
                            },
                            .cancel()
                        ]
                    )
                }
            }
            .navigationTitle(cluster.name)
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
