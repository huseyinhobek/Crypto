//
//  DetailViewController.swift
//  CryptoApp
//
//  Created by Hüseyin HÖBEK on 27.01.2023.
//

import UIKit
import SDWebImageSVGCoder

class DetailViewController: UIViewController {
    
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var lowPriceLabel: UILabel!
    @IBOutlet weak var highPriceLabel: UILabel!
    @IBOutlet weak var changeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var currentLabel: UILabel!
    
    var selectedCrypto: Coin?
    var selectedCoin: Coin?
    let iconImageView = UIImageView()
    let blurView = UIVisualEffectView(effect: nil)
    let blurEffect = UIBlurEffect(style: .light)
    var blurEffectView: UIVisualEffectView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.titleView = setTitle(title: "\(selectedCrypto!.symbol!)", subtitle: "\(selectedCrypto!.name!)")
        let price = NumberFormatter().number(from: (selectedCrypto?.price!)!)?.doubleValue ?? 0.0
        let change = Double((selectedCrypto?.change!)!) ?? 0.0
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
        highPriceLabel.text = "High: $\(String(format: "%.2f", (selectedCrypto?.sparkline?.map{Double($0)!}.max() ?? 0.00)))"
        lowPriceLabel.text = "Low: $\(String(format: "%.2f", (selectedCrypto?.sparkline?.map{Double($0)!}.min() ?? 0.00)))"
        
        //MARK: -> BACKGROUND
        iconImageView.contentMode = .scaleAspectFill
        iconImageView.frame = view.frame
        blurView.frame = view.frame
        view.insertSubview(iconImageView, at: 0)
        view.insertSubview(blurView, aboveSubview: iconImageView)
        iconImageView.sd_setImage(with: URL(string: (selectedCrypto?.iconUrl!)!))
        blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
        blurEffectView.frame = iconImageView.bounds
        blurView.effect = blurEffect
        iconImageView.addSubview(blurEffectView)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        iconImageView.removeFromSuperview()
    }
    
    func setTitle(title:String, subtitle:String) -> UIView {
        let titleLabel = UILabel(frame: CGRect(x: 0, y: -2, width: 0, height: 0))
        titleLabel.backgroundColor = UIColor.clear
        titleLabel.textColor = UIColor.gray
        titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        titleLabel.text = title
        titleLabel.sizeToFit()
        let subtitleLabel = UILabel(frame: CGRectMake(0, 18, 0, 0))
        subtitleLabel.backgroundColor = UIColor.clear
        subtitleLabel.textColor = UIColor.black
        subtitleLabel.font = UIFont.systemFont(ofSize: 12)
        subtitleLabel.text = subtitle
        subtitleLabel.sizeToFit()
        let titleView = UIView(frame: CGRectMake(0, 0, max(titleLabel.frame.size.width, subtitleLabel.frame.size.width), 30))
        titleView.addSubview(titleLabel)
        titleView.addSubview(subtitleLabel)
        let widthDiff = subtitleLabel.frame.size.width - titleLabel.frame.size.width
        if widthDiff < 0 {
            let newX = widthDiff / 2
            subtitleLabel.frame.origin.x = abs(newX)
        } else {
            let newX = widthDiff / 2
            titleLabel.frame.origin.x = newX
        }
        return titleView
    }
}

