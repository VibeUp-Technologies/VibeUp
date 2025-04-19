import Foundation

final class AppComponents {
    
    lazy var firestoreService = FirestoreService()
    
    lazy var authState = AuthState()
    lazy var authService = AuthService(
        authState: authState,
        firestoreService: firestoreService
    )
}
