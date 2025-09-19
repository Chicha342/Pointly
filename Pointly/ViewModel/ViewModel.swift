//
//  ViewModel.swift
//  Pointly
//
//  Created by Никита on 16.09.2025.
//

import Foundation

//MARK: - Notes
class NotesViewModel: ObservableObject {
    @Published var coreDataManager = CoreDataManager.shared
    @Published var session = SessionManager.shared
    
    @Published var userEmail: String = "Loading..."
    
    //@Published var daysOfWeek: [String] = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    @Published var priority: [String] = ["Low", "Medium", "High"]
    
    @Published var selectedPrioriy: String = "Low"
    @Published var selectedDate = Date()
    
    @Published  var targetName = ""
    @Published  var descriptionText = ""
    
    @Published var notes: [NoteModelLocal] = []
    
    
    
    func loadNotes() {
        guard let userId = session.currentUserId else {
            notes = []
            return
        }
        notes = coreDataManager.fetchData(for: userId)
    }
    
    func addNote(title: String, descr: String, day: String, priority: String) {
        guard let userId = session.currentUserId else { return }
        let count = coreDataManager.fetchData(for: userId).count
        
        let formater = DateFormatter()
        formater.dateFormat = "HH:mm"
        let forametr2 = DateFormatter()
        forametr2.dateFormat = "yyyy-MM-dd"
        
        let timeString = ("\(formater.string(from: Date())) | \(forametr2.string(from: Date()))")
        
        coreDataManager.addItem(
            text: title,
            descr: descr,
            time: timeString,
            isDone: false,
            day: day,
            priority: priority,
            userId: userId
        )
        loadNotes()
        
        targetName = ""
        descriptionText = ""
        selectedDate = Date()
        selectedPrioriy = "Low"
    }
    
    func delete(_ note: NoteModelLocal) {
        coreDataManager.deleteItem(note)
        loadNotes()
    }
    
    func toggleDone(_ note: NoteModelLocal) {
        coreDataManager.toggleDone(note)
        loadNotes()
    }
    
    func loadUserEmail() async{
        guard let userId = SessionManager.shared.currentUserId else { return }
        
        let networkManager = NetworkManager()
        let users = await networkManager.fetchDataDirects()
        if let currentUser = users.first(where: { $0.id == userId }) {
            userEmail = currentUser.gmail
        }
    }
    
}

//MARK: - Auth
class AuthViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var isLoggedIn = false
    @Published var showError = false
    
    private let networkManager = NetworkManager()
    
    func login() {
        Task { @MainActor in
            let success = await networkManager.checkLogin(email: email, password: password)
            if success {
                isLoggedIn = true
                email = ""
                password = ""
            } else {
                showError = true
            }
        }
    }
    
    func register() {
        Task {
            let newUser = dataModel(id: nil, gmail: email, password: password)
            await networkManager.addData(newData: newUser)
            await MainActor.run {
                isLoggedIn = true
            }
        }
    }
    
    func deleteAccount(){
        guard let userId = SessionManager.shared.currentUserId else {
            return
        }
        
        Task{
            await NetworkManager().deleteData(id: userId)
            SessionManager.shared.logOut()
            
            let notes = CoreDataManager.shared.fetchData(for: userId)
            for note in notes {
                CoreDataManager.shared.deleteItem(note)
            }
            
        }
    }
    
    func logOutAccount(){
        guard let userId = SessionManager.shared.currentUserId else {
            return
        }
        
        Task{
            SessionManager.shared.logOut()
            
        }
    }
}
