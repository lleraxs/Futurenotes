import SwiftUI
import SwiftData // Обязательно добавь эту строку!

struct HomeView: View {
    @Query var predictions: [Prediction]
    @State private var showingCreateSheet = false
    
    let bgPurple = Color(red: 0.35, green: 0.25, blue: 0.45) // Фиолетовый из Figma
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 0.75, green: 0.55, blue: 0.55).ignoresSafeArea() // Фон экрана
                
                VStack(spacing: 25) {
                    // Шапка (как в Figma)
                    VStack(spacing: 10) {
                        Text("FutureNotes").font(.title2).bold()
                        Image(systemName: "sun.max.fill").font(.system(size: 40))
                        Text("Schreibe dir selber eine Nachricht und entdecke sie später wieder")
                            .multilineTextAlignment(.center).font(.subheadline)
                    }
                    .padding().frame(maxWidth: .infinity).background(bgPurple).foregroundColor(.white).cornerRadius(20).padding(.horizontal)

                    // Сетка статистики (4 карточки)
                    LazyVGrid(columns: [GridItem(), GridItem()], spacing: 15) {
                        StatCard(title: "Gesperrt", value: predictions.filter { !$0.isOpened }.count)
                        StatCard(title: "Bereit", value: 0)
                        StatCard(title: "Geöffnet", value: predictions.filter { $0.isOpened }.count)
                        StatCard(title: "Insgesamt", value: predictions.count)
                    }
                    .padding(.horizontal)

                    // Кнопка создания
                    Button(action: { showingCreateSheet.toggle() }) {
                        Label("Neue Nachricht erstellen", systemImage: "plus")
                            .padding().background(Color.black).foregroundColor(.white).clipShape(Capsule())
                    }
                    
                    Spacer()
                }
                .padding(.top)
            }
            .sheet(isPresented: $showingCreateSheet) { CreatePredictionView() }
        }
    }
}

struct StatCard: View {
    var title: String
    var value: Int
    var body: some View {
        VStack {
            Text(title).font(.headline)
            Text("\(value)").font(.title).bold()
        }
        .frame(maxWidth: .infinity, minHeight: 120)
        .background(Color(red: 0.35, green: 0.25, blue: 0.45))
        .foregroundColor(.white).cornerRadius(20)
    }
}
