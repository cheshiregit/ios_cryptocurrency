//
//  ViewController.swift
//  CryptoCoins
//
//  Created by Roman Nordshtrem on 21.03.2018.
//  Copyright © 2018 Роман Нордштрем. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var tableView: UITableView!
    
    let cellIdentifier = "xibCell"
    
    var dataModel: DataModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshData()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib.init(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        
        //refreshData()
    }

    func refreshData() {
        let urlString = "https://api.coinmarketcap.com/v1/ticker/bitcoin/"
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with:url!) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                do {
                    let parsedData = try JSONSerialization.jsonObject(with: data!) as! [[String : Any]]
                    for item in parsedData
                    {
                        let id = item["id"] as! String
                        let price = item["price_usd"] as! String
                        let change24h = item["percent_change_24h"] as! String
                        let change7d = item["percent_change_7d"] as! String
                        print("id: \(id), price: \(price), 24h: \(change24h), 7d: \(change7d)")
                        self.dataModel?.id = id
                        self.dataModel?.price = price
                        self.dataModel?.change24h = change24h
                        self.dataModel?.change7d = change7d
                    }
                    
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            }
            }.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "xibCell", for: indexPath) as? CustomTableViewCell else { return UITableViewCell() }
        cell.coinImage.image = UIImage(named: "btc")
        cell.coinName.text = dataModel?.id
        cell.coinPrice.text = dataModel?.price
        cell.label24h.text = dataModel?.change24h
        cell.label7d.text = dataModel?.change7d
        print("cell")
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

}

