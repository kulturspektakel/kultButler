//
//  PayMethodsView.swift
//  kultButler
//
//  Created by Valentin Langer on 14.04.21.
//

import SwiftUI

struct PayMethodsView: View {
    var body: some View {
        HStack {
            Button("Bar", action: { print("PayMethod: Bar") })
                .padding()
                .background(Color.gray)
                .foregroundColor(.white)
                .cornerRadius(10.0)
            Button("Karte", action: { print("PayMethod: Karte") })
                .padding()
                .background(Color.gray)
                .foregroundColor(.white)
                .cornerRadius(10.0)
            Button("Gutschein", action: { print("PayMethod: Gutschein") })
                .padding()
                .background(Color.gray)
                .foregroundColor(.white)
                .cornerRadius(10.0)
            Button("Orga", action: { print("PayMethod: Orga") })
                .padding()
                .background(Color.gray)
                .foregroundColor(.white)
                .cornerRadius(10.0)
        }
    }
}

struct PayMethodsView_Previews: PreviewProvider {
    static var previews: some View {
        PayMethodsView()
    }
}
