//
//  AirTicketsServerManager.swift
//  EffectiveMobile
//
//  Created by Марат Хасанов on 31.05.2024.
//

import Foundation

protocol AirTicketsManagerDelegate: AnyObject {
    func getAirTickets(tickets: [AirTicketsModel])
}

class AirTicketsManager {
    
    var delegate: AirTicketsManagerDelegate?
    
    let url = "https://run.mocky.io/v3/214a1713-bac0-4853-907c-a1dfc3cd05fd"
        
    func performRequest() {
        guard let url = URL(string: url) else { return }
        let urlSession = URLSession(configuration: .default)
        let task = urlSession.dataTask(with: url) { data, response, error in
            if error != nil {
                print(error!)
                return
            }
            
            if let safeData = data {
                if let parsedData = self.parseJSON(safeData) {
                    self.delegate?.getAirTickets(tickets: parsedData)
                }
            }
        }
        task.resume()
    }
    
    func parseJSON(_ data: Data) -> [AirTicketsModel]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(Object.self, from: data)
            
            let decodedParsedData = decodedData.offers
            var airTickets: [AirTicketsModel] = []
            decodedParsedData.forEach { offers in
                let id = offers.id
                let title = offers.title
                let town = offers.town
                let price = offers.price.value
                let airTicket = AirTicketsModel(id: id, title: title, town: town, value: price)
                airTickets.append(airTicket)
            }
            return airTickets
        } catch {
            print(error)
            return nil
        }
    }
}
