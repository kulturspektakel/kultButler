import SwiftUI

struct SolidButton: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled: Bool
    
    var color: Color?
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 17.0, weight: .semibold))
            .padding()
            .background(self.color ?? Color(.systemGray6))
            .opacity(isEnabled ? 1 : 0.3)
            .cornerRadius(10.0)
    }
}

struct SolidButton_Previews: PreviewProvider {
    static var previews: some View {
        HStack(alignment: .top, spacing: 20) {
            Button("Text") {}.buttonStyle(SolidButton())
            Button("Text") {}.buttonStyle(SolidButton(color: .red))
            Button("Text") {}.buttonStyle(SolidButton(color: .blue))
            Button("Text") {}.buttonStyle(SolidButton()).disabled(true)
        }
    }
}
