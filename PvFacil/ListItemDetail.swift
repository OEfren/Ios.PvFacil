//
//  ListItemDetail.swift
//  PvFacil
//
//  Created by Efren Ordaz on 12/12/23.
//

import Foundation
import UIKit;

class ListItemDetail : UIViewController {
    
    @IBOutlet weak var imvImage: UIImageView!
    @IBOutlet weak var lblDescription: UITextView!
    
    var articulo: ArticuloInfo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://estratecc.mx/connecta-pvfacil/file-server?id=" + self.articulo.imagen)!
        let htmlString = articulo.descripcionHtml
        let data = htmlString.data(using: .utf8)!
        let attributedString = try? NSAttributedString(
            data: data,
            options: [.documentType: NSAttributedString.DocumentType.html],
            documentAttributes: nil)
        lblDescription.attributedText = attributedString
        
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    self.imvImage.image = UIImage(data: data)
                }
            }
        }
    }
    
}
