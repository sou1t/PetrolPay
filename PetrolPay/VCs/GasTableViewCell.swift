//
//  GasTableViewCell.swift
//  PetrolPay
//
//  Created by Виталий Волков on 30.03.17.
//  Copyright © 2017 Виталий Волков. All rights reserved.
//

import UIKit

class GasTableViewCell: UITableViewCell {

    @IBOutlet weak var checkBox: M13Checkbox!
    @IBOutlet weak var label: UILabel!
    
    var isChecked: Bool{
        var value = true
        switch self.checkBox.checkState {
        case .checked:
            value = true;
        case .unchecked:
            value = false;
        case .mixed:
            value = false;
        }
        return value
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            checkBox.setCheckState(.checked, animated: true)
            self.backgroundColor = UIColor(red: 255/255, green: 189/255, blue: 0, alpha: 1)
            label.textColor = UIColor(red: 35/255, green: 35/255, blue: 35/255, alpha: 1)
            checkBox.secondaryTintColor = UIColor(red: 35/255, green: 35/255, blue: 35/255, alpha: 1)
            checkBox.secondaryCheckmarkTintColor = UIColor(red: 35/255, green: 35/255, blue: 35/255, alpha: 1)
            checkBox.tintColor = UIColor(red: 35/255, green: 35/255, blue: 35/255, alpha: 1)
        }
        else {
            checkBox.setCheckState(.unchecked, animated: true)
            self.backgroundColor = .clear
            label.textColor = UIColor(red: 255/255, green: 189/255, blue: 0, alpha: 1)
            checkBox.secondaryTintColor = UIColor(red: 255/255, green: 189/255, blue: 0, alpha: 1)
            checkBox.secondaryCheckmarkTintColor = UIColor(red: 255/255, green: 189/255, blue: 0, alpha: 1)
            checkBox.tintColor = UIColor(red: 255/255, green: 189/255, blue: 0, alpha: 1)
        }
    }
    
    func createCell(label: String){
        self.backgroundColor = .clear
        self.label.text = label
    }

}
