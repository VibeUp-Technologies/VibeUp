import SwiftUI

struct NavigationBarItemButton: View {
    
    let imageName: String
    let action: () -> Void
    
    var body: some View {
        Button(
            action: action,
            label: {
                Image(systemName: imageName)
                    .font(.system(size: 16.0))
                    .fontWeight(.bold)
                    .foregroundColor(Color(.sapphire))
            }
        )
    }
}

