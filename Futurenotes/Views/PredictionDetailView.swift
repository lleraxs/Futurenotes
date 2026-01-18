import SwiftUI

struct PredictionDetailView: View {
    @Bindable var prediction: Prediction // Используем @Bindable, чтобы менять статус
    
    var body: some View {
        ZStack {
            Color(red: 0.75, green: 0.55, blue: 0.55).ignoresSafeArea() // Розовый фон
            
            VStack(spacing: 20) {
                // Верхняя плашка с заголовком
                HStack {
                    Text(prediction.title.isEmpty ? "Ohne Titel" : prediction.title)
                        .font(.title2).bold()
                    Spacer()
                    Image(systemName: "aperture").font(.title2)
                }
                .padding()
                .background(Color(red: 0.29, green: 0.19, blue: 0.43))
                .foregroundColor(.white)
                .cornerRadius(15)
                .shadow(radius: 5)
                
                // Основной блок контента
                VStack(alignment: .leading) {
                    Text("Deine Nachricht:")
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding(.top)
                        .padding(.horizontal)
                    
                    // Градиентный квадрат
                    ZStack {
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color(red: 0.29, green: 0.19, blue: 0.43), // Темный верх
                                Color(red: 0.75, green: 0.55, blue: 0.85)  // Светлый низ
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .cornerRadius(20)
                        
                        // Контент внутри квадрата
                        if Date() >= prediction.openingDate {
                            // ОТКРЫТО
                            ScrollView {
                                Text(prediction.text)
                                    .font(.body)
                                    .foregroundColor(.white)
                                    .padding()
                                    .multilineTextAlignment(.center)
                            }
                        } else {
                            // ЗАКРЫТО
                            VStack {
                                Spacer()
                                Text("Diese Nachricht\nist noch gesperrt.")
                                    .font(.title3).bold()
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                                Spacer()
                            }
                        }
                        
                        // Даты внизу квадрата (белые квадратики)
                        VStack {
                            Spacer()
                            HStack(spacing: 15) {
                                DateBox(title: "Erstellt:", date: prediction.creationDate)
                                DateBox(title: "Öffnungsdatum:", date: prediction.openingDate)
                            }
                            .padding(.bottom, 20)
                        }
                    }
                    .padding()
                }
                .background(Color(red: 0.6, green: 0.4, blue: 0.7)) // Светло-фиолетовый фон контейнера
                .cornerRadius(25)
                
                Spacer()
            }
            .padding()
        }
        .onAppear {
            // Если дата наступила, помечаем как "Открыто" (для статистики)
            if Date() >= prediction.openingDate && !prediction.isOpened {
                prediction.isOpened = true
            }
        }
    }
}

// Маленький белый квадратик с датой
struct DateBox: View {
    var title: String
    var date: Date
    
    var body: some View {
        VStack(spacing: 2) {
            Text(title).font(.caption2).foregroundColor(.black)
            Text(date.formatted(date: .numeric, time: .omitted))
                .font(.caption).bold().foregroundColor(.black)
        }
        .padding(8)
        .background(Color.white)
        .cornerRadius(8)
    }
}
