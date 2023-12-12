//
//  SucursalInfo.swift
//  PvFacil
//
//  Created by Efren Ordaz on 09/12/23.
//

import Foundation

struct SucursalInfo : Codable, Identifiable {
    
    var id: Int
    var nombre: String
    var lat: Double
    var lon: Double
    
}

struct ResponseSucursal : Codable {
    
    var sucursalInfo: SucursalInfo
    
}

class SucursalService : ObservableObject {
    
    @Published var sucursales = [SucursalInfo]()
    
    func loadData(completion: @escaping ([ResponseSucursal]) -> ()) {
        guard let url  = URL(string:"https://estratecc.mx/connecta-pvfacil/api/general/sucusal/get-list") else {
            print("Invalid url")
            return
        }
        
        var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("Ykxn46NR9Axk9xmZk+AgiST3bDJLmQsHCh2WU1o5vgKypwWZbii5ofafIyVb3TJ08MTEPn5DgsXvA7PLo+sSkVdGbaocrwEPVvLQH8TgsP/KpKoY0dqQbbfr7o+/j0Z1NB5yds8DM4tp0rNKpNdF3FgA22PkabzG", forHTTPHeaderField: "sessionID")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            let sucursales = try! JSONDecoder().decode([ResponseSucursal].self, from: data!)
            print(sucursales)
            DispatchQueue.main.async {
                completion(sucursales)
            }
        }.resume()
    }
    
}
