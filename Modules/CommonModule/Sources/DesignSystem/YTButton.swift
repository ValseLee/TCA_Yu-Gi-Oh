import SwiftUI

public enum YTButtonTypes {
    case primary, secondary, plainText
}

public struct YTButton<Label: View>: View {
    // MARK: - Properties
    let buttonType: YTButtonTypes
    let buttonLabel: Label
    
    // MARK: - LIFECYCLE
    public init(
        buttonType: YTButtonTypes,
        @ViewBuilder label: @escaping () -> Label
    ) {
        self.buttonType = buttonType
        self.buttonLabel = label()
    }
    
    // MARK: - Body
    public var body: some View {
        switch buttonType {
        case .primary:
            Button {
                
            } label: {
                buttonLabel
            }
        case .secondary:
            Button {
                
            } label: {
                buttonLabel
            }
        case .plainText:
            Button {
                
            } label: {
                buttonLabel
            }
        }
    }
}

struct YTButton_Previews: PreviewProvider {
    static var previews: some View {
        YTButton(buttonType: .primary) {
            Text("?")
        }
    }
}
