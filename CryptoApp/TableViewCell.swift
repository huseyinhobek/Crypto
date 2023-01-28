//
//  TableViewCell.swift
//  CryptoApp
//
//  Created by Hüseyin HÖBEK on 26.01.2023.
//

import UIKit
import SDWebImageSVGCoder

class TableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var changeLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    
  
    var viewModel: MainViewModel!
    var imageStore: ImageStore!
    
    func configCell(model: Coin) {
        symbolLabel.text = model.symbol
        nameLabel.text = model.name
        

//        changeLabel.text = "\(model.change) \(model.price) * \(model.change)"
        let price = NumberFormatter().number(from: model.price!)?.doubleValue ?? 0.0
        let change = Double(model.change!) ?? 0.0
        let priceChange = price * (change / 100)
        changeLabel.text = "\(change)% (\(priceChange) $)"
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        priceLabel.text = "$\(formatter.string(from: NSNumber(value: price)) ?? "")"
        changeLabel.text = "\(change)% ($\(formatter.string(from: NSNumber(value: priceChange)) ?? ""))"
        if priceChange > 0 {
            changeLabel.textColor = UIColor.systemGreen
        } else {
            changeLabel.textColor = UIColor.red
        }

        let url = URL(string: model.iconUrl ?? "")
        SDImageCodersManager.shared.addCoder(SDImageSVGCoder.shared)
        iconImageView.sd_setImage(with: url, completed: nil)
    }

}
