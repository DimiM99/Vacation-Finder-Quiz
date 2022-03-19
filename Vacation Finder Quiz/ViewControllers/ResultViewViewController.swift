//
//  ResultViewViewController.swift
//  Vacation Finder Quiz
//
//  Created by Dimi on 26.02.22.
//

import UIKit

class ResultViewViewController: UIViewController {
    
    @IBOutlet weak var cNameLabel: UILabel!
    @IBOutlet weak var cFlagLabel: UILabel!
    @IBOutlet weak var covidAdisoryMessage: UILabel!
    
    var rCountryCode: Country = .IT
    var maxVal = 0
    var advisoryMessage = ""
    
    enum flags: String {
        case 🇮🇹, 🇭🇷, 🇫🇷, 🇪🇸, 🇹🇷
    }
    
    struct RCountry {
        var code: Country
        var name: String
        var flag: flags
    }
    
    
    let url = "https://www.travel-advisory.info/api?countrycode="
    var RequestURL = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        validateTheResults()
        let ResultCountry = parseTheResultCountry()
        cNameLabel.text = ResultCountry.name
        cFlagLabel.text = ResultCountry.flag.rawValue
        RequestURL = url + ResultCountry.code.rawValue
        getDataFromTravelApi(from: RequestURL)
        covidAdisoryMessage.text = advisoryMessage
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        while covidAdisoryMessage.text == "" {
            covidAdisoryMessage.text = advisoryMessage
        }
        //compansate the api delay
    }
    
    
    func getDataFromTravelApi(from url: String) {
        URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { data, response, error in
            guard let data = data, error == nil else {
                print("there is an error")
                return
            }
            
            var results: TravelApi?
            do {
                try results = JSONDecoder().decode(TravelApi.self, from: data)
            } catch {
                print("failed to convert \(error.localizedDescription)")
            }
            guard let json = results else {
                return
            }
            
            let Result = json
            if let shitt = Result.data[self.rCountryCode.rawValue]?.advisory.message {
                self.advisoryMessage = shitt
            } else {
                return
            }
            
        }).resume()
    }
    
    
    
    struct TravelApi: Codable {
        let data: [String: ResponceCountry]
    }

    struct ResponceCountry: Codable {
        let iso_alpha2: String
        let name: String
        let continent: String
        let advisory: CovAdvice
    }

    struct CovAdvice: Codable {
        let score: Double
        let sources_active: Int
        let message: String
        let updated: String
        let source: String
    }
    
    
    
//parsing the result and basic for this View to go on
    
    func validateTheResults() {
        for (key, value) in CountriesScores {
            if value > maxVal {
                maxVal = value
                rCountryCode = key
            }
        }
    }
    func parseTheResultCountry() -> RCountry {
        let code = rCountryCode
        var name = ""
        var flag: flags
        switch code {
        case .IT:
            name = "Italy"
            flag = .🇮🇹
        case .HR:
            name = "Croatia"
            flag = .🇭🇷
        case .FR:
            name = "France"
            flag = .🇫🇷
        case .ES:
            name = "Spain"
            flag = .🇪🇸
        case .TR:
            name = "Turkey"
            flag = .🇹🇷
        }
        return RCountry(code: code, name: name, flag: flag)
    }
}
