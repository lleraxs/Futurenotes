import SwiftUI
import SwiftData

struct PredictionDetailView: View {
    @Bindable var prediction: Prediction
    @Environment(\.modelContext) private var modelContext // Контекст для удаления
    @Environment(\.dismiss) var dismiss
    
    let bgMain = Color.white
    let purpleHeader = Color(red: 0.30, green: 0.20, blue: 0.42)
    let cardPurple = Color(red: 0.58, green: 0.40, blue: 0.61)

    var body: some View {
        ZStack {
            bgMain.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Хедер
                HStack {
                    Text(prediction.title.isEmpty ? "Titel..." : prediction.title)
                        .font(.title3).bold()
                    Spacer()
                    Image(systemName: "aperture").font(.title)
                }
                .padding(25)
                .background(purpleHeader)
                .foregroundColor(.white)
                .cornerRadius(20)
                .padding(.horizontal)
                .padding(.top, 10)

                // Кнопка Zurück
                HStack {
                    Button(action: { dismiss() }) {
                        Text("< Zurück")
                            .font(.system(size: 14, weight: .bold))
                            .padding(.horizontal, 20).padding(.vertical, 8)
                            .background(Color.black).foregroundColor(.white).clipShape(Capsule())
                    }
                    Spacer()
                }
                .padding(.horizontal, 30).padding(.vertical, 10)

                // Основная карточка
                VStack(spacing: 15) {
                    Text("Deine Nachricht:")
                        .font(.headline).foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding([.horizontal, .top])

                    ZStack {
                        LinearGradient(
                            colors: [Color(red: 0.29, green: 0.19, blue: 0.43), Color(red: 0.75, green: 0.55, blue: 0.85)],
                            startPoint: .topLeading, endPoint: .bottomTrailing
                        )
                        .cornerRadius(25)
                        
                        if Date() < prediction.openingDate {
                            VStack(spacing: 10) {
                                Image(systemName: "lock.fill").font(.largeTitle)
                                Text("Diese Vorhersage\nist noch gesperrt.")
                                    .font(.title3).bold().multilineTextAlignment(.center)
                            }
                            .foregroundColor(.white)
                        } else {
                            ScrollView {
                                Text(prediction.text)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .onAppear {
                                        prediction.isOpened = true // Помечаем как открытое
                                    }
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    // Даты
                    HStack(spacing: 15) {
                        DetailDateCard(label: "Erstellt:", date: prediction.creationDate)
                        DetailDateCard(label: "Öffnungsdatum:", date: prediction.openingDate)
                    }
                    .padding(.horizontal)

                    // КНОПКА УДАЛЕНИЯ
                    Button(action: deletePrediction) {
                        HStack {
                            Image(systemName: "trash")
                            Text("Nachricht löschen")
                        }
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.red)
                        .padding(.bottom, 15)
                    }
                }
                .frame(maxHeight: .infinity)
                .background(cardPurple)
                .cornerRadius(30)
                .padding(.horizontal)
                .padding(.bottom, 10)
            }
        }
        .navigationBarHidden(true)
    }

    // Функция удаления
    func deletePrediction() {
        modelContext.delete(prediction)
        do {
            try modelContext.save()
            dismiss() // Возвращаемся назад после удаления
        } catch {
            print("Ошибка при удалении: \(error.localizedDescription)")
        }
    }
}
struct DetailDateCard: View {
    let label: String
    let date: Date
    var body: some View {
        VStack(spacing: 4) {
            Text(label)
                .font(.system(size: 10))
                .foregroundColor(.black.opacity(0.6))
            Text(date.formatted(date: .numeric, time: .omitted))
                .font(.system(size: 12, weight: .bold))
                .foregroundColor(.black)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 10)
        .background(Color.white)
        .cornerRadius(10)
    }
}
