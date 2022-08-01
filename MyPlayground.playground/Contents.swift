import Foundation
func getData(urlRequest: String) {
    guard let url = URL(string: urlRequest) else { return }
    let configuration: URLSessionConfiguration = .default
    configuration.allowsCellularAccess = true
    configuration.waitsForConnectivity = true
    let session = URLSession(configuration: configuration)
    session.dataTask(with: url) { (data, response, error) in
        if error != nil {
            print(error?.localizedDescription ?? "")
        } else if let response = response as? HTTPURLResponse, response.statusCode == 200 {
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let jsonData = try decoder.decode(Cards.self, from: data)
                    jsonData.cards.forEach { card in
                        let textToPrint = """
                        Имя карты: \(card.nameCard)
                        Тип: \(card.type)
                        Мановая стоимость: \(card.manaCost ?? "none")
                        Название сета: \(card.setName)
                        Редкость: \(card.rarity)
                        Описание: \(card.description)
                        ___
                        """
                        print(textToPrint)
                    }
                } catch {
                    print(error)
                }
            }
        }
    }.resume()
}

getData(urlRequest: "https://api.magicthegathering.io/v1/cards?name=Opt")
getData(urlRequest: "https://api.magicthegathering.io/v1/cards?name=Black%20Lotus")

struct Cards: Codable {
    let cards: [Card]
}

struct Card: Codable {
    let nameCard: String
    let type: String
    let manaCost: String?
    let rarity: String
    let setName: String
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case nameCard = "name"
        case type
        case manaCost
        case rarity
        case setName
        case description = "text"
    }
}
