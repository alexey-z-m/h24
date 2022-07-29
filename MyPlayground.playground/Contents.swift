import UIKit

func getData(urlRequest: String) {
    guard let url = URL(string: urlRequest) else { return }
    let configuration: URLSessionConfiguration = .default
    configuration.allowsCellularAccess = true
    configuration.waitsForConnectivity = true
    let session = URLSession(configuration: configuration)
    session.dataTask(with: url) { (data, response, error) in
        if error != nil {
            print(error?.localizedDescription ?? "")
        } else { print("ошибок нет") }
        if let response = response as? HTTPURLResponse, response.statusCode == 200 {
            print(response)
        }
        if let data = data {
            let dataAsString = String(data: data, encoding: .utf8)
            print(dataAsString ?? "nil")
        }
    }.resume()
}
