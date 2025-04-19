import Foundation
import Logger

final class AppComponents {
    
    lazy var logger = OSLogger(subsystem: "ViperUp")
    
    lazy var firestoreService = FirestoreService(
        logger: logger
    )
    
    lazy var authState = AuthState()
    lazy var authService = AuthService(
        authState: authState,
        firestoreService: firestoreService
    )
}
