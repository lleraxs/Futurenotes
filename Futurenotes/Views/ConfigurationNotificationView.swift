//
//  ContentView.swift
//  Futurenotes
//
//  Created by ta635 on 17.01.26.
//
import SwiftUI

struct ConfigurationNotificationView: View {
    // Diese Variablen speichern, ob der Schalter an oder aus ist
    @State private var showNotifications = true
    @State private var playSound = true
    @Environment(\.dismiss) var dismiss // Zum Zurückkehren

    var body: some View {
        ZStack {
            // Hintergrund der gesamten Seite ist weiß
            Color.white.ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 20) {

                // 2. Überschrift mit Glocken-Icon
                HStack(spacing: 15) {
                    Image(systemName: "bell.fill")
                        .font(.title)
                    Text("Benachrichtigungen")
                        .font(.title2)
                        .bold()
                }
                .padding(.horizontal, 25)
                .padding(.top, 50)
                // 3. Die Schalter-Boxen
                VStack(spacing: 1) {
                    // Erster Schalter: Benachrichtigung anzeigen
                    HStack {
                        Text("Benachrichtigung anzeigen")
                        Spacer()
                        Toggle("", isOn: $showNotifications)
                            .labelsHidden() // Versteckt das Standard-Label des Toggles
                            .tint(.green)   // Farbe wenn aktiv
                    }
                    .padding()
                    .background(Color(uiColor: .systemGray6)) // Hellgrauer Hintergrund wie im Bild
                    .cornerRadius(15, corners: [.topLeft, .topRight]) // Nur oben abgerundet

                    // Zweiter Schalter: Ton
                    HStack {
                        Text("Ton")
                        Spacer()
                        Toggle("", isOn: $playSound)
                            .labelsHidden()
                            .tint(.green)
                    }
                    .padding()
                    .background(Color(uiColor: .systemGray6))
                    .cornerRadius(15, corners: [.bottomLeft, .bottomRight]) // Nur unten abgerundet
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 50)


                Spacer() // Schiebt alles nach oben

                // 4. Der rote Reset-Link ganz unten
                HStack {
                    Spacer()
                    Button(action: {
                        // Setzt die Schalter zurück
                        showNotifications = true
                        playSound = true
                    }) {
                        Text("Benachrichtigungseinstellungen zurücksetzen")
                            .foregroundColor(.red)
                            .font(.system(size: 14))
                    }
                    Spacer()
                }
                .padding(.bottom, 30)
            }
        }
        // Versteckt die Standard-Back-Button von Apple, damit deiner benutzt wird
        .navigationBarBackButtonHidden(true)
    }
}

// Hilfsfunktion für abgerundete Ecken an bestimmten Seiten
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

#Preview {
    ConfigurationNotificationView()
}
