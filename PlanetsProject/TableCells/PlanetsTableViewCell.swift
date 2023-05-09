//
//  PlanetsTableViewCell.swift
//  PlanetsProject
//
//  Created by Chetan on 09/05/2023.
//

import UIKit

class PlanetsTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var lblname: UILabel!
    
    @IBOutlet weak var lblPlanetName: UILabel!
    
    
    @IBOutlet weak var lblClimate: UILabel!
    
    
    @IBOutlet weak var lblClimateAns: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
