import SwiftUI

struct StartScreen: View {
    @State private var showButtons = false
    
    var body: some View {
        // Hier beginnt die Verknüpfungs-Logik
        NavigationStack {
            ZStack {
                // Hintergrund
                Color(red: 0.75, green: 0.55, blue: 0.55)
                    .ignoresSafeArea()
                
                // Weißer Kasten
                VStack(spacing: 0) {
                    Spacer()
                    
                    VStack(spacing: 25) {
                        Image("logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120, height: 140)
                        
                        Text("FutureNotes")
                            .font(.system(size: 40, weight: .bold, design: .rounded))
                            .foregroundColor(.black)
                        
                        if showButtons {
                            VStack(spacing: 15) {
                                // Login Button
                                Button(action: { print("Login") }) {
                                    Text("Login")
                                        .fontWeight(.semibold)
                                        .foregroundColor(.white)
                                        .frame(maxWidth: .infinity)
                                        .padding(.vertical, 12)
                                        .background(Color.black)
                                        .cornerRadius(10)
                                }
                                
                                // HIER IST DIE VERKNÜPFUNG:
                                // NavigationLink ersetzt den Button und führt zu RegisterView
                                NavigationLink(destination: RegisterView().navigationBarBackButtonHidden(true)) {
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
                            .transition(.opacity)
                        } else {
                            VStack {}.frame(height: 180)
                        }
                    }
                    .padding(.vertical, 40)
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.white)
                .ignoresSafeArea()
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation(.easeInOut(duration: 0.8)) {
                        self.showButtons = true
                    }
                }
            }
        }
    }
}

#Preview {
    StartScreen()
}
