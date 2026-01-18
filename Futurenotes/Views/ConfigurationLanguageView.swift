//
//  ContentView.swift
//  Futurenotes
//
//  Created by ta635 on 17.01.26.
//

import SwiftUI

struct ConfigurationLanguageView: View {
    @Binding var selectedLanguage: String // @Binding, damit die Wahl an Seite 1 zurückgegeben wird
    @Environment(\.dismiss) var dismiss // Erlaubt uns, die Seite zu schließen

    let sprachen = ["Deutsch", "English", "Português", "Українська"]

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea() // Hintergrund komplett weiß
            
            VStack {
                Text("Sprache")
                    .font(.headline)
                    .padding(.top)
                
                Text("Bitte gewünschte Sprache auswählen")
                    .font(.subheadline)
                    .foregroundColor(.gray)

                List(sprachen, id: \.self) { sprache in
                    Button(action: {
                        selectedLanguage = sprache
                        dismiss() // Springt zurück zu Seite 1
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
                .scrollContentBackground(.hidden) // Macht das Standard-Grau der Liste weg
                .listStyle(.insetGrouped)
            }
        }
    }
}

#Preview {
    ConfigurationLanguageView(selectedLanguage: .constant("Deutsch"))
}
