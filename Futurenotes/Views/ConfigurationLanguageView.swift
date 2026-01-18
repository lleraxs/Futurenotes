//
//  ContentView.swift
//  Futurenotes
//
//  Created by ta635 on 17.01.26.
//

import SwiftUI

struct ConfigurationLanguageView: View {
    @Binding var selectedLanguage: String // Die Live-Verbindung zur Hauptseite
    @Environment(\.dismiss) var dismiss    // Zum automatischen Zurückkehren
    
    let sprachen = ["Deutsch", "English", "Português", "Українська"]
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            VStack {
                // 1. Dieser Spacer drückt alles von oben nach unten
                Spacer()
                
                VStack(spacing: 15) {
                    Text("Sprache")
                        .font(.headline)
                    Text("Bitte gewünschte Sprache auswählen")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                
                List(sprachen, id: \.self) { sprache in
                    Button(action: {
                        // 2. Sprache speichern
                        selectedLanguage = sprache
                        // 3. Sofort zurück zur Einstellungsseite springen
                        dismiss()
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
                    }
                }
                .scrollContentBackground(.hidden)
                .listStyle(.insetGrouped)
                // 4. Hier stellst du ein, wie groß die Liste sein soll (schiebt sie in die Mitte)
                .frame(height: 300)
                
                // 5. Ein zweiter Spacer unten hält das Gleichgewicht
            
                Spacer()
            }
        }
    }
}

#Preview {
    ConfigurationLanguageView(selectedLanguage: .constant("Deutsch"))
}
