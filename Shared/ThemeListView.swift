//
//  ThemeListView.swift
//  training_ground
//
//  Created by Роман on 08.05.2022.
//

import SwiftUI

struct ThemeListView: View {
    var body: some View {
        List {
            NavigationLink("Variables", destination: {
                ContentView()
            })
        }
    }
}

struct ThemeListView_Previews: PreviewProvider {
    static var previews: some View {
        ThemeListView()
    }
}
