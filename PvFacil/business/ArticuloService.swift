//
//  SucursalInfo.swift
//  PvFacil
//
//  Created by Efren Ordaz on 09/12/23.
//

import Foundation

struct ArticuloInfo : Codable, Identifiable {
    
    var id: Int
    var nombre: String
    var imagen: String
    var descripcionHtml: String
    
}

struct ResponseArticulo : Codable {
    
    var articuloInfo: ArticuloInfo
    
}

class ArticuloService : ObservableObject {
    
    func loadData(completion: @escaping ([ResponseArticulo]) -> ()) {
        guard let url  = URL(string:"https://estratecc.mx/connecta-pvfacil/api/sales/articulo/get-list") else {
            print("Invalid url")
            return
        }
        
        var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("Ykxn46NR9Axk9xmZk+AgiST3bDJLmQsHCh2WU1o5vgKypwWZbii5ofafIyVb3TJ08MTEPn5DgsXvA7PLo+sSkVdGbaocrwEPVvLQH8TgsP/KpKoY0dqQbbfr7o+/j0Z1NB5yds8DM4tp0rNKpNdF3FgA22PkabzG", forHTTPHeaderField: "sessionID")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            let articulos = try! JSONDecoder().decode([ResponseArticulo].self, from: data!)
            print(articulos)
            DispatchQueue.main.async {
                completion(articulos)
            }
        }.resume()
    }
    
}
