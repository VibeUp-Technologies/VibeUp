import Foundation

final class AppComponents {
    
    lazy var firestoreService = FirestoreService()
    lazy var authService = AuthService(firestoreService: firestoreService)
}
