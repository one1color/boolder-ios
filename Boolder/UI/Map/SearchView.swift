//
//  AlgoliaView.swift
//  Boolder
//
//  Created by Nicolas Mondollot on 01/11/2022.
//  Copyright © 2022 Nicolas Mondollot. All rights reserved.
//

import SwiftUI
import InstantSearchSwiftUI

struct SearchView: View {
    @Environment(\.presentationMode) var presentationMode
    
    static let algoliaController = AlgoliaController()
    @ObservedObject var searchBoxController = Self.algoliaController.searchBoxController
    @ObservedObject var problemHitsController = Self.algoliaController.problemHitsController
    @ObservedObject var areaHitsController = Self.algoliaController.areaHitsController
    @ObservedObject var errorController = Self.algoliaController.errorController
    
    @State private var isEditing = false
    
    let mapState: MapState
    
    var body: some View {
        NavigationView {
            VStack {
                if #available(iOS 15, *) { }
                else {
                    SearchBar(text: $searchBoxController.query,
                              isEditing: $isEditing,
                              onSubmit: searchBoxController.submit)
                    .disableAutocorrection(true)
                    .padding(.horizontal)
                    .padding(.top)
                }
                
                if errorController.requestError {
                    Spacer()
                    Text("search.request_error").foregroundColor(.gray)
                    Spacer()
                }
                else if searchBoxController.query.count == 0 {
                    VStack {
                        VStack(spacing: 16) {
                            Text("search.examples")
                                .foregroundColor(Color.secondary)
                            
                            ForEach(["Cul de Chien", "La Marie-Rose", "Apremont"], id: \.self) { query in
                                Button {
                                    searchBoxController.query = query
                                } label: {
                                    Text(query).foregroundColor(.appGreen)
                                }
                            }
                        }
                        .padding(.top, 100)

                        Spacer()
                    }
                }
                else if(areaHitsController.hits.count == 0 && problemHitsController.hits.count == 0) {
                    Spacer()
                    Text("search.no_results").foregroundColor(.gray)
                    Spacer()
                }
                else {
                    Results()
                }
            }
            .navigationBarTitle(Text("search.title"), displayMode: .inline)
            .navigationBarItems(
                trailing: Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("OK")
                        .bold()
                        .padding(.vertical)
                        .padding(.leading, 32)
                }
            )
            
            .modify {
                if #available(iOS 15, *) {
                    $0.searchable(text: $searchBoxController.query, placement: .navigationBarDrawer(displayMode: .always), prompt: Text("search.placeholder"))
                        .disableAutocorrection(true)
                }
                else {
                    $0
                }
            }
        }
    }
    
    private func Results() -> some View {
        List {
            if(areaHitsController.hits.count > 0) {
                Section(header: Text("search.areas")) {
                    ForEach(areaHitsController.hits, id: \.self) { (hit: AreaItem?) in
                        if let id = Int(hit?.objectID ?? "") {
                            
                            Button {
                                presentationMode.wrappedValue.dismiss()
                                
                                if let area = Area.load(id: id) {
                                    mapState.centerOnArea(area)
                                }
                            } label: {
                                HStack {
                                    Text(hit?.name ?? "").foregroundColor(.primary)
                                }
                            }
                        }
                    }
                }
            }
            if(problemHitsController.hits.count > 0) {
                Section(header: Text("search.problems")) {
                    ForEach(problemHitsController.hits, id: \.self) { hit in
                        if let id = Int(hit?.objectID ?? ""), let problem = Problem.load(id: id), let hit = hit {
                            
                            Button {
                                presentationMode.wrappedValue.dismiss()
                                
                                mapState.selectAndPresentAndCenterOnProblem(problem)
                            } label: {
                                HStack {
                                    ProblemCircleView(problem: problem)
                                    Text(hit.name).foregroundColor(.primary)
                                    Text(hit.grade).foregroundColor(.gray).padding(.leading, 2)
                                    Spacer()
                                    Text(hit.area_name).foregroundColor(.gray).font(.caption)
                                }
                            }
                        }
                    }
                }
            }
        }
        .listStyle(.grouped)
    }
}

//struct AlgoliaView_Previews: PreviewProvider {
//    static var previews: some View {
//        AlgoliaView()
//    }
//}
