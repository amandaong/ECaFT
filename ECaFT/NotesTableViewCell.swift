//
//  NotesTableViewCell.swift
//  ECaFT
//
//  Created by Amanda Ong on 1/7/17.
//  Copyright © 2017 loganallen. All rights reserved.
//

import UIKit

class NotesTableViewCell: UITableViewCell {

    @IBOutlet weak var notesTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
