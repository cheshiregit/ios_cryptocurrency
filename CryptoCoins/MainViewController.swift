//
//  ViewController.swift
//  CryptoCoins
//
//  Created by Roman Nordshtrem on 21.03.2018.
//  Copyright © 2018 Роман Нордштрем. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var tableView: UITableView!
    
    let cellIdentifier = "xibCell"
    
    var currency = [DataModel]()
    
    var refresh: UIRefreshControl!
    
    //
    var realm : Realm!
    
    var coinsList: Results<RealmModel> {
        get {
            return realm.objects(RealmModel.self)
        }
    }
    
    var realmModelItem = [RealmModel]()
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib.init(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        
        refresh = UIRefreshControl()
        
        refresh.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tableView.refreshControl = refresh
        refreshData()
        
        //
        realm = try! Realm()
        //
    }

    @objc func refreshData() {
        let urlString = "https://api.coinmarketcap.com/v1/ticker/?limit=10"
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with:url!) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
                print("No Internet")
            }
            
            guard let data = data else { return }
            
            do {
                //let currentData = try JSONDecoder().decode([DataModel].self, from: data)
                //let parsedData = try JSONSerialization.jsonObject(with: data!) as! [[String : Any]]
                let currentData = try JSONDecoder().decode([RealmModel].self, from: data)
                
                DispatchQueue.main.async {
                    //self.currency = currentData
                    //
                    self.realmModelItem = currentData
                    
                    print(currentData)
                    print(self.realmModelItem)
                    
                    try! self.realm.write({
                        //self.realm.add(self.realmModelItem)
                        self.realm.add(self.realmModelItem, update: true)
                    })
                    
                    //
                    self.tableView.reloadData()
                    self.refresh.endRefreshing()
                }
                
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }.resume()
        print(Realm.Configuration.defaultConfiguration.description)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return currency.count
        return coinsList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "xibCell", for: indexPath) as? CustomTableViewCell else { return UITableViewCell() }
        
        //
        let item = coinsList[indexPath.row]
        
        cell.coinImage.image = UIImage(named: item.symbol.lowercased())
        print(item.symbol)
        cell.coinName.text = item.symbol + " | " + item.name
        cell.coinPrice.text = item.price + " $"
        if item.change24h.hasPrefix("-") {
            cell.value24h.textColor = UIColor.red } else {
            cell.value24h.textColor = UIColor.init(red: 0, green: 0.7, blue: 0, alpha: 1)
        }
        cell.value24h.text = item.change24h
        if item.change7d.hasPrefix("-") {
            cell.value7d.textColor = UIColor.red } else {
            cell.value7d.textColor = UIColor.init(red: 0, green: 0.7, blue: 0, alpha: 1)
        }
        cell.value7d.text = item.change7d
 
        //
        /*
        cell.coinImage.image = UIImage(named: currency[indexPath.row].symbol.lowercased())
        cell.coinName.text = currency[indexPath.row].symbol + " | " + currency[indexPath.row].name
        cell.coinPrice.text = currency[indexPath.row].price + " $"
        if currency[indexPath.row].change24h.hasPrefix("-") {
            cell.value24h.textColor = UIColor.red } else {
            cell.value24h.textColor = UIColor.init(red: 0, green: 0.7, blue: 0, alpha: 1)
        }
        cell.value24h.text = currency[indexPath.row].change24h
        if currency[indexPath.row].change7d.hasPrefix("-") {
            cell.value7d.textColor = UIColor.red } else {
            cell.value7d.textColor = UIColor.init(red: 0, green: 0.7, blue: 0, alpha: 1)
        }
        cell.value7d.text = currency[indexPath.row].change7d
        */
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

}

