//
//  ConfigurationView.swift
//  Futurenotes
//
//  Created by TA603 on 19.01.26.
//

import SwiftUI
import SwiftData

struct ConfigurationView: View {
    @Binding var language: String
    @Binding var isDarkMode: Bool
    @Binding var isLoggedIn: Bool
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    @Query var allPredictions: [Prediction] // Нужно для удаления всех заметок
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            VStack(spacing: 20) {
                // Логотип
                VStack {
                    // Если картинки "Logo" нет в Assets, замени на Image(systemName: "aperture")
                    Image("Logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 150)
                }
                .padding(.top)
                
                List {
                    NavigationLink(destination: ConfigurationLanguageView(selectedLanguage: $language)) {
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
                    
                    // Кнопка удаления ВСЕХ данных
                    Button(role: .destructive, action: deleteAllNotes) {
                        Label("Alle Notizen löschen", systemImage: "trash")
                            .foregroundColor(.red)
                    }
                    
                    Button(action: { isLoggedIn = false }) {
                        Label("Abmelden", systemImage: "person.badge.minus")
                            .foregroundColor(.red)
                    }
                }
                .scrollContentBackground(.hidden)
                
                // Кнопка назад
                Button(action: { dismiss() }) {
                    Text("< Zurück")
                        .bold()
                        .frame(width: 150, height: 45)
                        .background(Color.black)
                        .foregroundColor(.white)
                        .cornerRadius(25)
                }
                .padding(.bottom, 20)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    // Логика полной очистки базы данных
    func deleteAllNotes() {
        for note in allPredictions {
            modelContext.delete(note)
        }
        try? modelContext.save()
    }
}
