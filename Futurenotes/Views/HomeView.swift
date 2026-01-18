import SwiftUI
import SwiftData

struct HomeView: View {
    // Эта магия подтягивает данные из базы в реальном времени
    @Query(sort: \Prediction.creationDate, order: .reverse) var predictions: [Prediction]
    @State private var showingCreateSheet = false
    
    // Твои цвета из Фигмы
    let bgPurple = Color(red: 0.35, green: 0.25, blue: 0.45)
    let mainBg = Color(red: 1.0, green: 1.0, blue: 1.0)
    
    var body: some View {
        NavigationStack {
            ZStack {
                mainBg.ignoresSafeArea()
                
                VStack(spacing: 20) {
                    // ШАПКА
                    VStack(spacing: 8) {
                        Text("FutureNotes").font(.title3).bold()
                        Image(systemName: "aperture").font(.largeTitle)
                        Text("Schreibe dir selber eine Nachricht\nund entdecke sie später wieder")
                            .multilineTextAlignment(.center).font(.caption)
                    }
                    .padding().frame(maxWidth: .infinity)
                    .background(bgPurple).foregroundColor(.white).cornerRadius(20).padding(.horizontal)

                    // СТАТИСТИКА (Квадраты теперь кнопки)
                    LazyVGrid(columns: [GridItem(), GridItem()], spacing: 12) {
                        NavigationLink(destination: PredictionListView(filter: .locked)) {
                            StatCard(title: "Gesperrt", value: predictions.filter { $0.openingDate > Date() }.count)
                        }
                        NavigationLink(destination: PredictionListView(filter: .ready)) {
                            StatCard(title: "Bereit", value: predictions.filter { $0.openingDate <= Date() && !$0.isOpened }.count)
                        }
                        NavigationLink(destination: PredictionListView(filter: .opened)) {
                            StatCard(title: "Geöffnet", value: predictions.filter { $0.isOpened }.count)
                        }
                        NavigationLink(destination: PredictionListView(filter: .all)) {
                            StatCard(title: "Insgesamt", value: predictions.count)
                        }
                    }
                    .padding(.horizontal)

                    // КНОПКА СОЗДАНИЯ
                    Button(action: { showingCreateSheet.toggle() }) {
                        Label("Neue Nachricht erstellen", systemImage: "plus")
                            .font(.headline).padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.black).foregroundColor(.white).clipShape(Capsule())
                    }
                    .padding(.horizontal)
                    
                    // ТВОЯ ЛЕНТА (Возвращена как в первой версии)
                    ScrollView {
                        if predictions.isEmpty {
                            VStack(spacing: 15) {
                                Circle().stroke(bgPurple, lineWidth: 2).frame(width: 60, height: 60)
                                    .overlay(Text("0").font(.title2))
                                Text("Keine Nachrichten").bold()
                            }.padding(.top, 40)
                        } else {
                            VStack(spacing: 12) {
                                ForEach(predictions) { pred in
                                    NavigationLink(destination: PredictionDetailView(prediction: pred)) {
                                        HStack {
                                            Text(pred.emoji).font(.title)
                                            VStack(alignment: .leading) {
                                                Text(pred.title.isEmpty ? "Vorhersage" : pred.title).bold()
                                                Text("Öffnet: \(pred.openingDate.formatted(date: .numeric, time: .omitted))").font(.caption2)
                                            }
                                            Spacer()
                                            Image(systemName: pred.openingDate > Date() ? "lock.fill" : "lock.open.fill")
                                        }
                                        .padding().background(bgPurple).foregroundColor(.white).cornerRadius(15)
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                }
            }
            .sheet(isPresented: $showingCreateSheet) {
                CreatePredictionsView()
            }
        }
    }
}

// Компонент квадратика, чтобы не было ошибки "Cannot find StatCard"
struct StatCard: View {
    var title: String
    var value: Int
    var body: some View {
        VStack(spacing: 5) {
            Text(title).font(.caption).bold()
            Text("\(value)").font(.title2).bold()
        }
        .frame(maxWidth: .infinity, minHeight: 90)
        .background(Color(red: 0.35, green: 0.25, blue: 0.45))
        .foregroundColor(.white).cornerRadius(15)
    }
}
