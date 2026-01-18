import SwiftUI
import SwiftData

struct CreatePredictionsView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var text = ""
    @State private var openingDate = Date()
    @State private var selectedEmoji = "😊"
    
    let emojis = ["😊", "😢", "😡", "😰", "😍", "😳", "😴", "🤔", "😮", "😌"]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Group {
                        Text("Was möchtest du schreiben?").bold()
                        TextField("Titel...", text: $title)
                            .padding().background(Color.purple.opacity(0.2)).cornerRadius(10)
                        
                        TextEditor(text: $text)
                            .frame(height: 100).padding(4).background(Color.purple.opacity(0.1)).cornerRadius(10)
                    }
                    
                    DatePicker("Wann öffnen?", selection: $openingDate, displayedComponents: .date)
                        .datePickerStyle(.graphical).padding().background(Color.purple.opacity(0.1)).cornerRadius(15)
                    
                    Text("Wie fühlst du dich gerade?").bold()
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 5)) {
                        ForEach(emojis, id: \.self) { emoji in
                            Text(emoji).font(.largeTitle)
                                .padding(8)
                                .background(selectedEmoji == emoji ? Color.purple.opacity(0.4) : Color.clear)
                                .cornerRadius(10)
                                .onTapGesture { selectedEmoji = emoji }
                        }
                    }
                    
                    Button(action: saveAction) {
                        Text("Nachricht speichern")
                            .frame(maxWidth: .infinity).padding().background(Color.purple.opacity(0.5)).foregroundColor(.black).cornerRadius(25)
                    }
                    .padding(.top)
                }
                .padding()
            }
            .navigationTitle("Neue Vorhersage")
            .toolbar { ToolbarItem(placement: .topBarLeading) { Button("Zurück") { dismiss() } } }
        }
    }
    
    func saveAction() {
        
        let new = Prediction(title: title, text: text, openingDate: openingDate, emoji: selectedEmoji)
        modelContext.insert(new)
        dismiss()
    }
}
