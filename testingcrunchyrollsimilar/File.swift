//
//  File.swift
//  testingcrunchyrollsimilar
//
//  Created by Raimondo Marco Petraglia on 16/11/23.
//

import Foundation
import SwiftUI
import SwiftData

struct MediaItemDetailVieww: View {
    var mediaItem: MediaItem

    var body: some View {
        VStack {
            Text(mediaItem.title)
                .font(.largeTitle)
                .padding()

            Image(mediaItem.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding()

            // Aggiungi altre informazioni riguardanti il MediaItem, se lo desideri
        }
    }
}
