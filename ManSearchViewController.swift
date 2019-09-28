//
//  ManSearchViewController.swift
//  Baitapjson
//
//  Created by Nguyễn Minh Hiếu on 9/24/19.
//  Copyright © 2019 Nguyễn Minh Hiếu. All rights reserved.
//

import UIKit
var cityArr = [City]()
class ManSearchViewController: UIViewController {
    
    @IBOutlet weak var searchbar2: UISearchBar!
    @IBOutlet weak var table: UITableView!

    var insertDataCity = [City]()
    weak var pushDataMain : Delegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        searchbar2.becomeFirstResponder()
        setUpDataCity()
        table.delegate = self
        table.dataSource = self
        searchbar2.delegate = self
    }
    
    func setUpDataCity() {
        insertDataCity = cityArr
    }
}

extension ManSearchViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return insertDataCity.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? TableViewCell else {
            return UITableViewCell()
        }
        cell.labelcell.text = insertDataCity[indexPath.row].name
        return cell
    }
}

extension ManSearchViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { // set chieu cao cell
        return 100
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        pushDataMain?.pushBackData(namecity: insertDataCity[indexPath.row].name!,countrycity: insertDataCity[indexPath.row].country!,lon: insertDataCity[indexPath.row].coord!.lon ,lat : insertDataCity[indexPath.row].coord!.lat)
        self.navigationController?.popViewController(animated: true)
    }
}

extension ManSearchViewController : UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        guard !searchText.isEmpty else{
            table.reloadData()
            return
        }
        insertDataCity = cityArr.filter({city -> Bool in
//            guard let text = searchbar2.text else {return false}
            return city.name!.contains(searchText)
        })
        table.reloadData()
    }
}

protocol Delegate: class{
    func pushBackData(namecity: String,countrycity : String ,lon : Double,lat : Double)
}

