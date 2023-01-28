//
//  ViewController.swift
//  CryptoApp
//
//  Created by Hüseyin HÖBEK on 26.01.2023.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var barButtonItem: UIBarButtonItem!
    var selectedTitle: String?
    var viewModel: MainViewModel?
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.delegate = self
        tableView.dataSource = self
        viewModel = MainViewModel(webService: MainWebServiceAdapter(webService: NewsWebService()))
        guard let viewModel = viewModel else {return}
        viewModel.getCoin {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.cryptoList?.coins?.count ?? 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        let model = viewModel?.cryptoList?.coins![indexPath.section]
        cell.configCell(model: model!)
        return cell
    }
 
    @IBAction func barButton(_ sender: Any) {
        
        self.barButtonItem.title = "Sort"
        
        let alertController = UIAlertController(title: "Filter Options", message: "Please select a filter option", preferredStyle: .actionSheet)
        
        let priceAction = UIAlertAction(title: "Price", style: .default, handler: { (action) in
            // Code for filtering based on price
            guard let viewModel = self.viewModel else {return}
            viewModel.cryptoList?.coins!.sort { (crypto1, crypto2) -> Bool in
                return crypto1.price! < crypto2.price!
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            self.selectedTitle = "Price"
            self.barButtonItem.title = self.selectedTitle
        })

        let marketCapAction = UIAlertAction(title: "Market Cap", style: .default, handler: { (action) in
            // Code for filtering based on market cap
            guard let viewModel = self.viewModel else {return}
            viewModel.cryptoList?.coins!.sort { (crypto1, crypto2) -> Bool in
                return crypto1.marketCap! < crypto2.marketCap!
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            self.selectedTitle = "Market Cap"
            self.barButtonItem.title = self.selectedTitle
        })
        let volumeAction = UIAlertAction(title: "24h Volume", style: .default, handler: { (action) in
            // Code for filtering based on 24h volume
            guard let viewModel = self.viewModel else {return}
            viewModel.cryptoList?.coins!.sort { (crypto1, crypto2) -> Bool in
                return crypto1.the24HVolume! < crypto2.the24HVolume!
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            self.selectedTitle = "24h Volume"
            self.barButtonItem.title = self.selectedTitle
        })
        let changeAction = UIAlertAction(title: "Change", style: .default, handler: { (action) in
            // Code for filtering based on change
            guard let viewModel = self.viewModel else {return}
            viewModel.cryptoList?.coins!.sort { (crypto1, crypto2) -> Bool in
                return crypto1.change! < crypto2.change!
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            self.selectedTitle = "Change"
            self.barButtonItem.title = self.selectedTitle
        })
        let listedAtAction = UIAlertAction(title: "Listed At", style: .default, handler: { (action) in
            // Code for filtering based on listed at
            guard let viewModel = self.viewModel else {return}
            viewModel.cryptoList?.coins!.sort { (crypto1, crypto2) -> Bool in
                return crypto1.listedAt! < crypto2.listedAt!
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            self.selectedTitle = "Listed At"
            self.barButtonItem.title = self.selectedTitle
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.modalPresentationStyle = .custom
        alertController.addAction(priceAction)
        alertController.addAction(marketCapAction)
        alertController.addAction(volumeAction)
        alertController.addAction(changeAction)
        alertController.addAction(listedAtAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)

    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let DetailVC = storyboard.instantiateViewController(withIdentifier: "DetailVC") as! DetailViewController
        let selectedCoin = self.viewModel?.cryptoList?.coins![indexPath.section]
        DetailVC.selectedCrypto = selectedCoin
//        DetailVC.selectedCoin = selectedCoin

        self.navigationController?.pushViewController(DetailVC, animated: true)
    }
}


