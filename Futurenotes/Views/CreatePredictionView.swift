import SwiftUI
import SwiftData

struct CreatePredictionsView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var text = ""
    @State private var openingDate = Date()
    @State private var selectedEmoji = "😊"
    @State private var selectedCategory = "🌱 Leben"
    
    let emojis = ["😊", "😢", "😡", "😰", "😍", "😳", "😴", "🤔", "😮", "😌"]
    let categories = ["🌱 Leben", "📚 Schule", "💼 Arbeit", "🎯 Ziele", "✨ Sonstiges"]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 25) {
                    
                    // 1. Title
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Gib deiner Nachricht einen Titel, damit du sie später easy erkennst.")
                            .font(.caption).foregroundColor(.secondary)
                        TextField("Titel...", text: $title)
                            .padding().background(Color.purple.opacity(0.1)).cornerRadius(10)
                    }
                    
                    // 2. Text
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Schreibe alles auf, was du deinem zukünftigen Ich mitteilen möchtest.")
                            .font(.caption).foregroundColor(.secondary)
                        TextEditor(text: $text)
                            .frame(height: 100)
                            .padding(4)
                            .background(Color.purple.opacity(0.05))
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.purple.opacity(0.1), lineWidth: 1)
                            )
                    }
                    
                    // 3. Category Chips
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Wähle eine Kategorie für dieses Ereignis.")
                            .font(.caption).foregroundColor(.secondary)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(categories, id: \.self) { cat in
                                    Text(cat)
                                        .padding(.horizontal, 15).padding(.vertical, 8)
                                        .background(selectedCategory == cat ? Color.purple.opacity(0.4) : Color.purple.opacity(0.1))
                                        .cornerRadius(20)
                                        .onTapGesture { selectedCategory = cat }
                                }
                            }
                        }
                    }
                    
                    // 4. Calendar
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Wähle den Tag, an dem diese Nachricht geöffnet werden soll.")
                            .font(.caption).foregroundColor(.secondary)
                        DatePicker("Datum", selection: $openingDate, in: Date()..., displayedComponents: .date)
                            .datePickerStyle(.graphical)
                            .padding().background(Color.purple.opacity(0.05)).cornerRadius(15)
                    }
                    
                    // 5. Emojis
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Wähle ein Emoji wie du dich gerade fühlst.")
                            .font(.caption).foregroundColor(.secondary)
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 5)) {
                            ForEach(emojis, id: \.self) { emoji in
                                Text(emoji).font(.largeTitle)
                                    .padding(8)
                                    .background(selectedEmoji == emoji ? Color.purple.opacity(0.3) : Color.clear)
                                    .cornerRadius(10)
                                    .onTapGesture { selectedEmoji = emoji }
                            }
                        }
                    }
                    
                    // Save Button
                    Button(action: saveAction) {
                        Text("Nachricht speichern")
                            .bold().frame(maxWidth: .infinity).padding()
                            .background(Color.purple.opacity(0.5)).foregroundColor(.black).cornerRadius(25)
                    }
                    .disabled(title.isEmpty || text.isEmpty) // Не сохраняем пустое
                    .opacity(title.isEmpty || text.isEmpty ? 0.5 : 1.0)
                }
                .padding()
            }
            .navigationTitle("Neue Vorhersage")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Zurück") { dismiss() }
                }
            }
        }
    }
    
    func saveAction() {
        // Создаем объект
        let newPrediction = Prediction(
            title: title,
            text: text,
            openingDate: openingDate,
            emoji: selectedEmoji,
            category: selectedCategory
        )
        
        // Вставляем в контекст
        modelContext.insert(newPrediction)
        
        // Сохраняем
        do {
            try modelContext.save()
            dismiss()
        } catch {
            print("❌ Ошибка сохранения: \(error.localizedDescription)")
        }
    }
}
