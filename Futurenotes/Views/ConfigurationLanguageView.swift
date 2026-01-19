import SwiftUI

struct ConfigurationLanguageView: View {
    @Binding var selectedLanguage: String
    @Environment(\.dismiss) var dismiss
    
    let sprachen = ["Deutsch", "English", "Português", "Українська"]
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer().frame(height: 40)
            
            VStack(spacing: 10) {
                Text("Sprache").font(.title2).bold()
                Text("Bitte gewünschte Sprache auswählen")
                    .font(.subheadline).foregroundColor(.gray)
            }
            
            List(sprachen, id: \.self) { sprache in
                Button(action: {
                    selectedLanguage = sprache
                    dismiss()
                }) {
                    HStack {
                        Text(sprache).foregroundColor(.black)
                        Spacer()
                        if selectedLanguage == sprache {
                            Image(systemName: "checkmark").foregroundColor(.purple)
                        }
                    }
                }
            }
            .listStyle(.insetGrouped)
            .scrollContentBackground(.hidden)
        }
        .background(Color.white)
    }
}//
//  ConfigurationLanguageView.swift
//  Futurenotes
//
//  Created by TA603 on 19.01.26.
//

