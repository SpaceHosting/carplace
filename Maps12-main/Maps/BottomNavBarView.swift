//
//  BottomNavBarView.swift
//  Maps
//
//  Created by hassoun on 24/05/2023.
//

import SwiftUI

struct BottomNavBarView: View {
    var body: some View {
        HStack {
            BottomNavBarItem(image: Image("Home"), action: {})
            BottomNavBarItem(image: Image("fav"), action: {})
            BottomNavBarItem(image: Image("shop"), action: {})
            BottomNavBarItem(image: Image("User"), action: {})
        }
        .padding()
        .background(Color.yellow)
        .clipShape(Capsule())
        .padding(.horizontal)
        .shadow(color: Color.blue.opacity(0.15), radius: 8, x: 2, y: 6)
    }
}

struct BottomNavBarItem: View {
    let image: Image
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            image
                .frame(maxWidth: .infinity)
        }
    }
}

struct BottomNavBarView_Previews: PreviewProvider {
    static var previews: some View {
        BottomNavBarView()
    }
}
