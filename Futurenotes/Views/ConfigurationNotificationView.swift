//
//  ContentView.swift
//  Futurenotes
//
//  Created by ta635 on 17.01.26.
//
import SwiftUI

struct ConfigurationNotificationView: View {
    @State private var showBanner = true
    @State private var playSound = true
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea() // Hintergrund weiß
            
            VStack(spacing: 20) {
                // Eigener Zurück-Button wie in deinem Design
                HStack {
                    Button(action: { dismiss() }) {
                        Text("< Zurück")
                            .foregroundColor(.white)
                            .padding(.horizontal, 15)
                            .padding(.vertical, 8)
                            .background(Color.black)
                            .cornerRadius(20)
                    }
                    Spacer()
                }
                .padding()

                HStack {
                    Image(systemName: "bell.badge.fill")
                    Text("Benachrichtigungen")
                        .font(.title2)
                        .bold()
                }

                Form {
                    Section {
                        Toggle("Benachrichtigung anzeigen", isOn: $showBanner)
                        Toggle("Ton", isOn: $playSound)
                    }
                }
                .scrollContentBackground(.hidden) // Liste/Form Hintergrund unsichtbar machen
                .background(Color.white)

                // Roter Reset-Button ganz unten
                Button(action: {
                    showBanner = true
                    playSound = true
                }) {
                    Text("Benachrichtigungseinstellungen zurücksetzen")
                        .foregroundColor(.red)
                        .font(.footnote)
                }
                .padding(.bottom, 30)
            }
        }
    }
}

#Preview {
    ConfigurationNotificationView()
}
