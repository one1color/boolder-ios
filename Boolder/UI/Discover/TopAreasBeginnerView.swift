//
//  TopAreasBeginnerView.swift
//  Boolder
//
//  Created by Nicolas Mondollot on 06/01/2023.
//  Copyright © 2023 Nicolas Mondollot. All rights reserved.
//

import SwiftUI

struct TopAreasBeginnerView: View {
    @Binding var appTab: ContentView.Tab
    let mapState: MapState
    
    @State private var areasForBeginners = [AreaWithCount]()
    
    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading) {
                
                Text("Secteurs avec circuits qui conviennent aux débutants :")
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal)
                    .padding(.bottom)
                
                VStack {
                    Divider() //.padding(.leading)
                    
                    ForEach(areasForBeginners) { areaWithCount in
                        
                        NavigationLink {
                            AreaView(area: areaWithCount.area, mapState: mapState, appTab: $appTab, linkToMap: true)
                        } label: {
                            HStack {
                                VStack(alignment: .leading, spacing: 6) {
                                    Text(areaWithCount.area.name)
                                    //                                                    .font(.body.weight(.semibold))
                                    //                                            .frame(maxWidth: .infinity, alignment: .leading)
                                        .multilineTextAlignment(.leading)
                                    //                                            .background(Color.blue)
                                    
                                }
                                
                                Spacer()
                                
                                HStack {
                                    ForEach(areaWithCount.area.circuits.filter{$0.beginnerFriendly}) { circuit in
                                        CircleView(number: "", color: circuit.color.uicolor, showStroke: false, height: 16)
                                    }
                                }
                                
                                Image(systemName: "chevron.right")
                                    .font(.caption.weight(.bold))
                                    .foregroundColor(.gray.opacity(0.7))
                                
                            }
                            .font(.body)
                            .foregroundColor(.primary)
                            .padding(.horizontal)
                            .padding(.vertical, 4)
                        }
                        
                        
                        Divider().padding(.leading)
                    }
                }
            }
            .padding(.vertical)
        }
        .onAppear{
            areasForBeginners = Area.forBeginners
        }
        
        .navigationTitle("Idéal pour débuter")
        .navigationBarTitleDisplayMode(.inline)
    }
}

//struct TopAreasBeginnerView_Previews: PreviewProvider {
//    static var previews: some View {
//        TopAreasBeginnerView()
//    }
//}
