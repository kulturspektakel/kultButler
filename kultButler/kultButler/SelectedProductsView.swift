//
//  SelectedProductsView.swift
//  kultButler
//
//  Created by Tristan Häuser on 15.04.21.
//

import SwiftUI

struct SelectedProductsView: View {
    @StateObject var network = Network.shared
    var body: some View {
        List {
            //Hier müssen alle ausgewählten Produkte eingefügt werden
            ForEach(network.booths) {booth in
                HStack {
                    Text(booth.name)
                        .fontWeight(.semibold)
                        .truncationMode(.tail)
                        .lineLimit(1)
                    Spacer()
                }
            }.onDelete(perform: delete)
        }.frame(alignment: .leading)
        .padding()
        .listStyle(PlainListStyle())
    }
    
    func delete(at offsets: IndexSet) {
        //remove(atOffsets: offsets)
    }
}
struct SelectedProductsView_Previews: PreviewProvider {
    static var previews: some View {
        SelectedProductsView()
    }
}
