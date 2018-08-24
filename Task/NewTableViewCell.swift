//
//  NewTableViewCell.swift
//  Task
//
//  Created by mahavir on 30/06/17.
//  Copyright © 2017 mobileFirst. All rights reserved.
//

import UIKit

class NewTableViewCell: UITableViewCell {

    @IBOutlet var imgView: UIImageView!
    
      @IBOutlet var lblName: UILabel!
    
    
    @IBOutlet var lblLat: UILabel!
    
    
       
    
    
    override func awakeFromNib() {
      
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
