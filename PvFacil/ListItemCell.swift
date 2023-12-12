//
//  ListItemCell.swift
//  PvFacil
//
//  Created by Efren Ordaz on 12/12/23.
//

import Foundation
import SwiftUI
import UIKit

class ListItemCell: UITableViewCell {
    
    // UIView code here
    @IBOutlet weak var imvItem: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    
    var item: ArticuloInfo!
    
}
