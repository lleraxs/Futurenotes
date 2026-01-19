//
//  ConfigurationNotificationView.swift
//  Futurenotes
//
//  Created by TA603 on 19.01.26.
//

import SwiftUI

struct ConfigurationNotificationView: View {
    @State private var showNotifications = true
    @State private var playSound = true
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(alignment: .leading, spacing: 25) {
            // Кнопка назад
            Button("< Zurück") { dismiss() }
                .foregroundColor(.purple)
                .padding(.top)

            HStack(spacing: 15) {
                Image(systemName: "bell.fill").font(.title).foregroundColor(.purple)
                Text("Benachrichtigungen").font(.title2).bold()
            }
            
            VStack(spacing: 1) {
                Toggle("Benachrichtigung anzeigen", isOn: $showNotifications)
                    .padding()
                    .background(Color(uiColor: .systemGray6))
                    .cornerRadius(15, corners: [.topLeft, .topRight])

                Toggle("Ton", isOn: $playSound)
                    .padding()
                    .background(Color(uiColor: .systemGray6))
                    .cornerRadius(15, corners: [.bottomLeft, .bottomRight])
            }
            .tint(.purple)

            Spacer()

            Button(action: {
                showNotifications = true
                playSound = true
            }) {
                Text("Einstellungen zurücksetzen")
                    .foregroundColor(.red)
                    .frame(maxWidth: .infinity)
            }
            .padding(.bottom, 30)
        }
        .padding(.horizontal)
        .navigationBarBackButtonHidden(true)
    }
}

// Помощник для скругления отдельных углов (нужен для этого вида)
struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}
