//
//  ViewController.swift
//  Baitapjson
//
//  Created by Nguyễn Minh Hiếu on 9/15/19.
//  Copyright © 2019 Nguyễn Minh Hiếu. All rights reserved.
//

import UIKit
import SwiftyJSON

let baseUrl = "https://api.openweathermap.org/data/2.5/weather?"
let keyapi = "&units=metric&lang=vi&APPID=0f17a750e711861498dc2d99cd03fa8d"

class ViewController: UIViewController {
    
    var insertDataCity = [City]()
    var se = [City]()
    var pasdataapi : WeathJSON?
    
    @IBOutlet weak var nameofcity: UILabel!
    @IBOutlet weak var countryofcity: UILabel!
    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var search: UISearchBar!
    @IBOutlet weak var labelweather: UILabel!
    @IBOutlet weak var labeltemp: UILabel!
    @IBOutlet weak var labelclody: UILabel!
    @IBOutlet weak var labelsunrise: UILabel!
    @IBOutlet weak var labelsunset: UILabel!
    @IBOutlet weak var labeltempmax: UILabel!
    @IBOutlet weak var labeltempmin: UILabel!
    @IBOutlet weak var labelhumidity: UILabel!
    @IBOutlet weak var labelpressure: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cityArr = Readjson.shared.pasejson()
        search.delegate = self
        first()
        timeCity()
    }

    func getApi(lon : Double , lat : Double, base : String, key : String){
        let codeUrl = base + "lat=\(lat)&lon=\(lon)" + key
        URLSession.shared.dataTask(with: URL(string: codeUrl)!){ (data, response, err) in
           if let data = data {
                do {
                    self.pasdataapi = try? JSONDecoder().decode(WeathJSON.self, from: data)
                    guard let check = self.pasdataapi else {return}
                    self.labeltemp.text = "Nhiệt độ: " + String(check.main!.temp!) + ".0oC"
                    self.labelclody.text = check.weather!.first!.description
                    self.labelsunrise.text = self.changetime(sun: check.sys!.sunrise!)
                    self.labelsunset.text = self.changetime(sun: check.sys!.sunset!)
                    self.labeltempmax.text = String(check.main!.temp_max!) + "oC"
                    self.labeltempmin.text = String(check.main!.temp_min!) + "oC"
                    self.labelpressure.text = String(check.main!.humidity!) + "%"
                    self.labelhumidity.text = String(check.main!.pressure!) + ".0 mb"
                }catch let error {
                print(error.localizedDescription)
                }
            }
        }.resume()
    }
    func changetime(sun : Int) -> String{
        let time = Date.init(timeIntervalSince1970: TimeInterval(sun))
        let dateform = DateFormatter()
        dateform.dateFormat = "HH:mm"
        let datea = dateform.string(from: time)
        return datea
    }
    func timeCity(){
        let curentTime = Date()
        let styleTime = DateFormatter()
        styleTime.dateStyle = .full
        styleTime.timeStyle = . short
        labelTime.text = styleTime.string(from: curentTime)
    }
    
    func first(){
        se = cityArr
        nameofcity.text = se.first!.name
        countryofcity.text = se.first!.country
    }
}

extension ViewController : UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let mansearch = sb.instantiateViewController(withIdentifier: "ManSearch") as? ManSearchViewController
        searchBar.resignFirstResponder()
        mansearch?.pushDataMain = self
        self.navigationController?.pushViewController(mansearch!, animated: true)
    }
}

extension ViewController: Delegate {
    func pushBackData(namecity : String,countrycity : String,lon : Double,lat : Double){
        nameofcity.text = namecity
        countryofcity.text = countrycity
        getApi(lon: lon,lat: lat, base: baseUrl, key: keyapi)
    }
}
