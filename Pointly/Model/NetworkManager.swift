//
//  NetworkManager.swift
//  Pointly
//
//  Created by Никита on 11.09.2025.
//

import Foundation

class NetworkManager {
    let urlString = "https://68c27dc3f9928dbf33ee8c35.mockapi.io/loginData"
    @Published var dataArray: [dataModel] = []
    
    //fetch
    func fetchData() async {
        guard let url = URL(string: urlString) else { return }
        
        do{
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoded = try JSONDecoder().decode([dataModel].self, from: data)
            DispatchQueue.main.async {
                self.dataArray = decoded
            }
        }catch{
            print("Error fetch: \(error)")
        }
    }
    
    
    
    //check Login
    func fetchDataDirects() async -> [dataModel] {
        guard let url = URL(string: urlString) else { return [] }
        do{
            let (data, _) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode([dataModel].self, from: data)
        }catch{
            print("Error fetch: \(error)")
            return []
        }
    }
    
    func checkLogin(email: String, password: String) async -> Bool {
        let users = await fetchDataDirects()
        
        if let user = users.first(where: { $0.gmail == email && $0.password == password }) {
            SessionManager.shared.logIn(userId: user.id ?? "")
            return true
        }
        
        return false
    }
    
    //Add
    func addData(newData: dataModel) async {
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue( "application/json", forHTTPHeaderField: "Content-Type")
        
        do{
            let body = try JSONEncoder().encode(newData)
            let(data, response) = try await URLSession.shared.upload(for: request, from: body)
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201{
                print("Data added successfully")
                
                
                let createdUser = try JSONDecoder().decode(dataModel.self, from: data)
                
                if let userId = createdUser.id {
                    SessionManager.shared.logIn(userId: userId)
                }
                
                await fetchData()
            }
        }catch{
            print("Error add: \(error)")
        }
    }
    
    //Delete
    func deleteData(id: String) async {
        guard let url = URL(string: "\(urlString)/\(id)") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        do{
            let (_, response) = try await URLSession.shared.data(for: request)
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200{
                DispatchQueue.main.async {
                    self.dataArray.removeAll { $0.id == id }
                }
            }
            else{
                print("Error deleting test")
            }
            
        }catch{
            print("Error deleting test: \(error.localizedDescription)")
        }
    }
    
    
}
