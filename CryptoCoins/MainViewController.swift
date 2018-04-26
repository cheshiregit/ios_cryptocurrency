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
    
    var currency = [DataModel]()
    
    var refresh: UIRefreshControl!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib.init(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        
        refresh = UIRefreshControl()
        
        refresh.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tableView.refreshControl = refresh
        refreshData()
    }

    @objc func refreshData() {
        let urlString = "https://api.coinmarketcap.com/v1/ticker/?limit=10"
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with:url!) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            
            guard let data = data else { return }
            
            do {
                let currentData = try JSONDecoder().decode([DataModel].self, from: data)
                //let parsedData = try JSONSerialization.jsonObject(with: data!) as! [[String : Any]]
                DispatchQueue.main.async {
                    //print(articlesData)
                    self.currency = currentData
                    
                    self.tableView.reloadData()
                    self.refresh.endRefreshing()
                }
                    
                        /*
                        let id = item["id"] as! String
                        let price = item["price_usd"] as! String
                        let change24h = item["percent_change_24h"] as! String
                        let change7d = item["percent_change_7d"] as! String
                        print("id: \(id), price: \(price), 24h: \(change24h), 7d: \(change7d)")
                        self.dataModel?.id = id
                        self.dataModel?.price = price
                        self.dataModel?.change24h = change24h
                        self.dataModel?.change7d = change7d
                        */
                    
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currency.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "xibCell", for: indexPath) as? CustomTableViewCell else { return UITableViewCell() }
        //cell.coinImage.image = UIImage(named: "btc_2")
        cell.coinImage.image = UIImage(named: currency[indexPath.row].symbol.lowercased())
        cell.coinName.text = currency[indexPath.row].id
        cell.coinPrice.text = currency[indexPath.row].price
        cell.value24h.text = currency[indexPath.row].change24h
        cell.value7d.text = currency[indexPath.row].change7d
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

}

