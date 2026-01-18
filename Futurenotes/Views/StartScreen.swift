//
//  StartScreen.swift
//  Futurenotes
//
//  Created by ta635 on 18.01.26.
//
import SwiftUI

struct StartScreen: View {
    @State private var showButtons = false

    var body: some View {
        ZStack {
            // Hintergrundfarbe
            Color(red: 0.75, green: 0.55, blue: 0.55)
                .ignoresSafeArea()
            
            // Der weiße Bereich
            VStack(spacing: 0) {
                // 1. Spacer oben: Drückt den Inhalt nach unten
                Spacer()
                
                VStack(spacing: 25) {
                    // Logo
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 150)
                    
                    // App Name
                    Text("FutureNotes")
                        .font(.system(size: 40, weight: .bold, design: .rounded))
                        .foregroundColor(.black)
                    
                    // Buttons (erscheinen verzögert)
                    if showButtons {
                        VStack(spacing: 15) {
                            Button(action: { print("Login") }) {
                                Text("Login")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 12)
                                    .background(Color.black)
                                    .cornerRadius(10)
                            }
                            
                            Button(action: { print("Register") }) {
                                Text("Register")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 12)
                                    .background(Color.black)
                                    .cornerRadius(10)
                            }
                        }
                        .padding(20)
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                        )
                        .padding(.horizontal, 40)
                        .transition(.opacity.combined(with: .move(edge: .bottom)))
                    } else {
                        // Platzhalter während der 2 Sekunden, damit das Logo mittig bleibt
                        VStack {}.frame(height: 180)
                    }
                }
                .padding(.vertical, 40)
                
                // 2. Spacer unten: Drückt den Inhalt nach oben
                // Zusammen mit dem oberen Spacer bleibt alles perfekt in der Mitte
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white)
            .ignoresSafeArea()
        }
        .onAppear {
            // Timer für das Erscheinen der Buttons
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                withAnimation(.easeInOut(duration: 0.8)) {
                    self.showButtons = true
                }
            }
        }
    }
}

#Preview {
    StartScreen()
}
