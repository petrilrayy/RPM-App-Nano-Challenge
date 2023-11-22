//
//  ContentView.swift
//  testingcrunchyrollsimilar
//
//  Created by Raimondo Marco Petraglia on 14/11/23.
//

import SwiftUI
import UIKit
struct ContentView: View {
    @State private var favoriteItems: [MediaItem] = []
    @State private var selectedTab = 0
    @State private var searchText = ""
    @Environment(\.colorScheme) var colorScheme
    
    let favoritesKey = "FavoriteItems"
    
    
    func hapticFeedback() {
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.prepare()
        generator.impactOccurred()
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            
            NavigationView {
                
                
                VStack(alignment: .leading) {
                    if searchPopResults.isEmpty && searchRecResults.isEmpty{
                        Text("We found nothing!")
                            .font(.title)
                        
                        
                    }
                    else{
                        
                        
                        if !searchPopResults.isEmpty {
                            SectionView(title: "Most Popular", items: searchPopResults, favoriteItems: $favoriteItems) { item in
                                toggleFavorite(item)
                            }
                        }
                        
                        if !searchRecResults.isEmpty {
                            SectionView(title: "Most Recents", items: searchRecResults, favoriteItems: $favoriteItems) { item in
                                toggleFavorite(item)
                            }
                        }
                    }
                }
                .navigationTitle("Crunchyroll")
    
                
            }
            .searchable(text: $searchText, prompt: "")
            .colorScheme(.dark)
            .onAppear {
                loadFavorites() // Carica i preferiti all'avvio dell'app
            }
            .onDisappear {
                saveFavorites()
            }

            .tabItem {
                Image(systemName: "house")
                    .accessibilityLabel("Home")
                Text("Home")

            }
            .tag(0)
            
            FavoriteItemsView(favoriteItems: $favoriteItems, toggleFavorite: toggleFavorite)
                .tabItem {
                    Image(systemName: "bookmark")
                        .accessibilityLabel("My watchlist")
                    Text("My Lists")
                                       
                }
                .tag(1)
        }
        .accentColor(.white)
        
        .colorScheme(.dark)
//        .foregroundStyle(.red)
    }
    
    
    var searchPopResults: [MediaItem] {
        if searchText.isEmpty {
            return popularItems }
        else {
            return popularItems.filter { $0.title.contains(searchText)
            }
        }
    }
    
    var searchRecResults: [MediaItem] {
        if searchText.isEmpty {
            return recentItems }
        else {
            return recentItems.filter { $0.title.contains(searchText)
            }
        }
    }
    
    func toggleFavorite(_ item: MediaItem) {
        if let index = favoriteItems.firstIndex(where: { $0.title == item.title }) {
            favoriteItems.remove(at: index)
        } else {
            favoriteItems.append(item)
            hapticFeedback()
        }
        saveFavorites()
    }
    
    func saveFavorites() {
        do {
            let data = try JSONEncoder().encode(favoriteItems)
            UserDefaults.standard.set(data, forKey: favoritesKey)
        } catch {
            print("Errore durante il salvataggio dei preferiti: \(error.localizedDescription)")
        }
    }
    
    func loadFavorites() {
        if let data = UserDefaults.standard.data(forKey: favoritesKey) {
            do {
                let decodedItems = try JSONDecoder().decode([MediaItem].self, from: data)
                let uniqueItems = Array(Set(decodedItems)) // Rimuove i duplicati
                favoriteItems = uniqueItems
            } catch {
                print("Errore durante il caricamento dei preferiti: \(error.localizedDescription)")
            }
        }
    }
}
    
    
    struct SectionView: View {
        let title: String
        let items: [MediaItem]
        @Binding var favoriteItems: [MediaItem]  // Aggiunto il binding a favoriteItems
        let action: (MediaItem) -> Void
        
        var body: some View {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                    .padding(.horizontal)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(items) { item in
                            
                            VStack {
                                Image(item.imageName)
                                    .resizable()
                                    .frame(width: 100, height: 150)
                                    .cornerRadius(8)
                                
                                Text(item.title)
                                    .font(.caption)
                                    .multilineTextAlignment(.center)
                                    .frame(width: 100)
                                
                                Button(action: {
                                    action(item)
                                }) {
                                    Image(systemName: favoriteItems.contains(where: { $0.title == item.title }) ? "bookmark.fill" : "bookmark")
                                        .accessibilityLabel("Add to my watchlist")
                                        .foregroundColor(.red)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
    
    
    struct FavoriteItemsView: View {
        @Binding var favoriteItems: [MediaItem]
        var toggleFavorite: (MediaItem) -> Void
        
        var body: some View {
            NavigationView {
                if favoriteItems.isEmpty {
                    Text("Your Watchlist needs some love.")
                        .accessibilityLabel("Your watchlist needs some love")
                        .navigationTitle(
                            Text("My Lists")
                                .foregroundColor(.red))
                    
                }
                else {
                    List(favoriteItems) { item in
                        HStack {
                            Image(item.imageName)
                                .resizable()
                                .frame(width: 50, height: 80)
                                .cornerRadius(8)
                            
                            Text(item.title)
                            
                            Spacer()
                            
                            Button(action: {
                                toggleFavorite(item)
                                let generator = UIImpactFeedbackGenerator(style: .heavy)
                                          generator.impactOccurred()
                            }) {
                                Image(systemName: "bookmark.fill")
                                    .foregroundColor(.red)
                            }
                        }
                        .padding(.vertical)
                    }
                    .navigationBarTitle("My Lists")
                }
            }.colorScheme(.dark)
        }
    }
    #Preview{
        ContentView()
    }
    
