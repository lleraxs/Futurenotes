import SwiftUI

struct RegisterView: View {
    // Variablen für die Eingaben (Zustand)
    @State private var email = ""
    @State private var passwort = ""
    @State private var stayLoggedIn = false
    
    // Ermöglicht das Zurückgehen zur vorherigen Seite
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            // Hintergrundfarbe (wie im StartScreen)
            Color(red: 1.0, green: 1.0, blue: 1.0)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                // Weiße Box (Card)
                VStack(alignment: .leading, spacing: 20) {
                    
                    // Email Feld
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Email")
                            .font(.system(size: 16, weight: .medium))
                        TextField("ex.: name@gmail.com", text: $email)
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                            )
                            .autocapitalization(.none)
                            .keyboardType(.emailAddress)
                    }
                    
                    // Passwort Feld
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Passwort")
                            .font(.system(size: 16, weight: .medium))
                        SecureField("••••••••", text: $passwort)
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                            )
                    }
                    
                    // Checkbox Bereich (Label & Description)
                    HStack(alignment: .top, spacing: 12) {
                        Image(systemName: stayLoggedIn ? "checkmark.square.fill" : "square")
                            .foregroundColor(stayLoggedIn ? .black : .gray)
                            .onTapGesture { stayLoggedIn.toggle() }
                            .font(.system(size: 22))
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Label")
                                .font(.system(size: 16))
                            Text("Description")
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.vertical, 5)
                    
                    // Buttons
                    VStack(spacing: 12) {
                        // Registrieren Button (Schwarz)
                        Button(action: {
                            print("Registrierung wird ausgeführt")
                        }) {
                            Text("Registrieren")
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.black)
                                .cornerRadius(8)
                        }
                        
                        // Einloggen Button (Dunkelgrau)
                        Button(action: {
                            dismiss() // Schließt die Seite und geht zurück
                        }) {
                            Text("Einloggen")
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color(white: 0.35))
                                .cornerRadius(8)
                        }
                    }
                }
                .padding(25)
                .background(Color.white)
                .cornerRadius(12)
                .padding(.horizontal, 20)
                
                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

// Vorschau
#Preview {
    RegisterView()
}
