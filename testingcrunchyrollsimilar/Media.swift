//
//  Media.swift
//  testingcrunchyrollsimilar
//
//  Created by Raimondo Marco Petraglia on 14/11/23.
//

import Foundation
import SwiftData

struct MediaItem: Identifiable, Codable, Hashable {
    var id = UUID()
    let title: String
    let imageName: String
}

let popularItems: [MediaItem] = [
    MediaItem(title: "Attack on Titan", imageName: "attackontitan"),
    MediaItem(title: "One Piece", imageName: "onepiece"),
    MediaItem(title: "Dragon Ball", imageName: "dragonball"),
    MediaItem(title: "Naruto", imageName: "naruto"),
    MediaItem(title: "Bleach", imageName: "bleach"),
    MediaItem(title: "Berserk", imageName: "berserk"),
    MediaItem(title: "Haikyu!!", imageName: "haikyuuu"),
    MediaItem(title: "Evangelion", imageName: "evangelion"),
]

let recentItems: [MediaItem] = [
    MediaItem(title: "My Hero Academia", imageName: "myheroacademia"),
    MediaItem(title: "Blue Lock", imageName: "bluelock"),
    MediaItem(title: "Demon Slayer", imageName: "demonslayer"),
    MediaItem(title: "Spy X Family", imageName: "spyxfamily"),
    MediaItem(title: "Jujutsu Kaisen", imageName: "jujutsukaisen"),
    MediaItem(title: "Chainsaw Man", imageName: "chainsawman"),
    MediaItem(title: "Dr. Stone", imageName: "drstone"),
    MediaItem(title: "Arcane", imageName: "ARCANE"),
    
    
]

