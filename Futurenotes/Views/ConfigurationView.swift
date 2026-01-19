//
//  ContentView.swift
//  Futurenotes
//
//  Created by ta635 on 17.01.26.
//

import SwiftUI
import SwiftData

struct ConfigurationView: View {
    @Binding var language: String
    @Binding var isDarkMode: Bool
    @Binding var isLoggedIn: Bool
    
    var body: some View {
        ZStack {
            // 1. Die unterste Ebene: Ein Rechteck, das den ganzen Bildschirm weiß füllt
            Color.white
                .ignoresSafeArea() // Damit auch der Bereich oben bei der Uhr weiß ist
            VStack(spacing: 30) {
                // Logo Bereich
                VStack {
                    Image("Logo")
                        .resizable()
                        .scaledToFit() // Behält das Seitenverhältnis bei (wichtig!)
                        .frame(width: 360, height: 300) // Hier kannst du die Größe einstellen
                }
                .padding(.top)
                
                // Menü-Liste
                List {
                    NavigationLink(destination: ConfigurationLanguageView(selectedLanguage: $language)) {
                        Label("Sprache (Deutsch)", systemImage: "globe")
                            .foregroundColor(.black)
                    }
                    
                    NavigationLink(destination: ConfigurationNotificationView()) {
                        Label("Benachrichtigung", systemImage: "bell")
                            .foregroundColor(.black)
                    }
                    
                    Toggle(isOn: $isDarkMode) {
                        Label("Nacht Modus", systemImage: "moon")
                            .foregroundColor(.black)
                    }
                    
                    // NEU: Reset Button in Rot
                    Button(action: { /* Logik zum Löschen hier */ }) {
                        Label("Alle Notizen löschen", systemImage: "trash")
                            .foregroundColor(.red)
                    }
                    
                    Button(action: { isLoggedIn = false }) {
                        Label("Abmelden", systemImage: "person.badge.minus")
                            .foregroundColor(.red)
                    }
                }
                .scrollContentBackground(.hidden)
                .background(Color.white)
                .listStyle(.insetGrouped)
                Button("< Zurück") { /* Zurück-Logik */ }
                    .buttonStyle(.borderedProminent).tint(.black)
            }
        }
    }
}

    #Preview {
        ConfigurationView(
            language: .constant("Deutsch"),
            isDarkMode: .constant(false),
            isLoggedIn: .constant(true)
        )
    }
