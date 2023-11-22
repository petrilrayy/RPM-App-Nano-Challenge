//
//  DetailView.swift
//  testingcrunchyrollsimilar
//
//  Created by Raimondo Marco Petraglia on 16/11/23.
//

import Foundation
import SwiftUI

struct DetailView: View {
    let item: MediaItem
    
    var body: some View {
        VStack {
            Image(item.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding()
            
            Text(item.title)
                .font(.title)
                .padding()
            
            // Aggiungi altre informazioni sull'elemento, se necessario
        }
        .navigationBarTitle(item.title)
    }
}

