//
//  SessionManager.swift
//  Pointly
//
//  Created by Никита on 12.09.2025.
//

import Foundation
import SwiftUI

class SessionManager: ObservableObject {
    static let shared = SessionManager()
    
    @AppStorage("currentUserId") private var storedUserId: String?
        @Published var currentUserId: String? {
            didSet {
                storedUserId = currentUserId
            }
        }
    
    private init() {
        self.currentUserId = storedUserId
    }
    
    func logIn(userId: String) {
        currentUserId = userId
    }
    
    func logOut() {
        currentUserId = nil
    }
}
