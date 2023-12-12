//
//  ListController.swift
//  PvFacil
//
//  Created by Efren Ordaz on 09/12/23.
//

import Foundation
import UIKit

class ListController: UIViewController {
    
    //https://www.ralfebert.com/ios-examples/uikit/uitableviewcontroller/custom-cells/
    
    @IBOutlet weak var tableView: UITableView!
    
    var articulos = [ArticuloInfo]()
    var articulo: ArticuloInfo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        ArticuloService().loadData{(items) in
            for item in items {
                self.articulos.append(item.articuloInfo)
            }
            self.tableView.reloadData()
        }
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if (segue.identifier == "storyArticuloDetail") {
            // initialize new view controller and cast it as your view controller
            let detail = sender as! ListItemCell
            let viewController = segue.destination as! ListItemDetail
            viewController.articulo = detail.item
        }
    }
    
}

extension ListController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //self.articulo = self.articulos[indexPath.row]
        //performSegue(withIdentifier: "goToSecondVC", sender: indexPath)
    }
    
}

extension ListController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articulos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ListItemCell
        let url = URL(string: "https://estratecc.mx/connecta-pvfacil/file-server?id=" + self.articulos[indexPath.row].imagen)!
        cell.item = self.articulos[indexPath.row]
        cell.lblName.text = self.articulos[indexPath.row].nombre
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    cell.imvItem.image = UIImage(data: data)
                }
            }
        }
        return cell;
    }
    
}
