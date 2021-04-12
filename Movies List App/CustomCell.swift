//
//  CustomCell.swift
//  Movies List App
//
//  Created by Ahmed Badry on 3/8/21.
//

import UIKit

class CustomCell: UITableViewCell {

    
 
    @IBOutlet weak var moviesNameCell: UILabel!
    @IBOutlet weak var moviesImageCell: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }

}

