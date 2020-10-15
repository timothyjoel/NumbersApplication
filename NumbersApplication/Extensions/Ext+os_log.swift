import os.log
import Foundation

extension OSLog {
    
    private static var subsystem = Bundle.main.bundleIdentifier!

    /// Network logs.
    static let network = OSLog(subsystem: subsystem, category: "network")
    /// View cycle logs.
    static let viewCycle = OSLog(subsystem: subsystem, category: "viewcycle")
    
}
