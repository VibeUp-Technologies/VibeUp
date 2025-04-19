import Foundation
import BackdoorPanel

enum Screen {
    case dashboard([TabBarView.Tab])
    case backdoor(BackdoorCoordinator)
}
