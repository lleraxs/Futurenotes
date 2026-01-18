import SwiftUI

struct CreatePredictionView: View {

    @State private var title = ""
    @State private var text = ""
    @State private var selectedFeeling: String? = nil

    let feelings = ["Hoffnungsvoll", "Unsicher", "Motiviert"]

    var body: some View {
        Form {
            Section("Titel") {
                TextField("Titel...", text: $title)
            }

            Section("Vorhersage") {
                TextEditor(text: $text)
                    .frame(height: 120)
            }

            Section("Wie fühlst du dich gerade?") {
                HStack {
                    ForEach(feelings, id: \.self) { feeling in
                        Button(feeling) {
                            selectedFeeling = feeling
                        }
                        .padding(8)
                        .background(selectedFeeling == feeling ? Color.purple : Color.gray.opacity(0.2))
                        .foregroundColor(.white)
                        .cornerRadius(12)
                    }
                }
            }

            Button("Vorhersage speichern") {
                print("Gespeichert")
            }
        }
        .navigationTitle("Neue Vorhersage")
    }
}
#Preview {
    CreatePredictionView()

}

