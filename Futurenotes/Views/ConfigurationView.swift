//
//  ContentView.swift
//  Futurenotes
//
//  Created by ta635 on 17.01.26.
//

import SwiftUI

struct ConfigurationView: View {
    @Binding var language: String
    @Binding var isDarkMode: Bool
    @Binding var isLoggedIn: Bool
    
    // Zustand für das Pop-up und den Reset-Alarm
    @State private var showLanguagePopup = false
    @State private var showResetAlert = false
    
    var body: some View {
        ZStack {
            // Hintergrund
            Color.white.ignoresSafeArea()
            
            VStack(spacing: 30) {
                // Logo Bereich
                VStack {
                    Image("Logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 360, height: 300)
                }
                .padding(.top)
                
                // Menü-Liste
                List {
                    // Sprache öffnet jetzt das Pop-up
                    Button(action: {
                        withAnimation { showLanguagePopup = true }
                    }) {
                        Label("Sprache (\(language))", systemImage: "globe")
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
                    
                    // Reset Button mit Bestätigung
                    Button(action: { showResetAlert = true }) {
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
            .blur(radius: showLanguagePopup ? 5 : 0) // Hintergrund verschwimmt bei Pop-up
            
            // Das Sprach-Pop-up Overlay
            if showLanguagePopup {
                Color.black.opacity(0.2)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation { showLanguagePopup = false }
                    }
                
                LanguagePopupView(selectedLanguage: $language, isShowing: $showLanguagePopup)
            }
        }
        // Bestätigungs-Dialog für den Reset
        .alert("Notizen löschen", isPresented: $showResetAlert) {
            Button("Abbrechen", role: .cancel) { }
            Button("Alles löschen", role: .destructive) {
                // Hier kommt euer Code zum Löschen der Daten rein
                print("Daten wurden gelöscht")
            }
        } message: {
            Text("Bist du sicher? Alle deine gespeicherten Notizen werden unwiderruflich entfernt.")
        }
    }
}

// MARK: - Sprach Pop-up View
struct LanguagePopupView: View {
    @Binding var selectedLanguage: String
    @Binding var isShowing: Bool
    
    let sprachen = ["Deutsch", "English", "Português", "Українська"]
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Sprache")
                .font(.headline)
                .padding(.top, 20)
            
            Text("Bitte gewünschte Sprache auswählen")
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(.bottom, 15)
            
            VStack(spacing: 0) {
                ForEach(sprachen, id: \.self) { sprache in
                    Button(action: {
                        selectedLanguage = sprache
                        withAnimation { isShowing = false }
                    }) {
                        HStack {
                            Text(sprache)
                                .foregroundColor(.black)
                            Spacer()
                            if selectedLanguage == sprache {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.blue)
                            }
                        }
                        .padding()
                        .frame(height: 50)
                        .background(Color.gray.opacity(0.1))
                    }
                    Divider() // Trennlinie zwischen den Sprachen
                }
            }
            .cornerRadius(15)
            .padding()
        }
        .frame(width: 300)
        .background(.ultraThinMaterial) // Der verschwommene Glas-Effekt
        .cornerRadius(25)
        .shadow(radius: 20)
    }
}

// MARK: - Preview
#Preview {
    ConfigurationView(
        language: .constant("Deutsch"),
        isDarkMode: .constant(false),
        isLoggedIn: .constant(true)
    )
}
