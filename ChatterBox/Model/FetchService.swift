import Foundation



struct FetchService{
    enum FetchError: Error{
        case badResponse
    }
    
    let baseURL = URL(string: "https://breaking-bad-api-six.vercel.app/api")!

    func fetchQuote(from show: String) async throws -> Quote{
        
        let quoteUrl = baseURL.appending(path: "quotes/random")
        let fetchURL = quoteUrl.appending(queryItems: [URLQueryItem(name: "production", value: show)])
        
        //fetch data
        let (data, response) = try await URLSession.shared.data(from: fetchURL)
        
        //handle response
        guard let response = response as? HTTPURLResponse , response.statusCode == 200 else{
            throw FetchError.badResponse
        }
        
        //decode data
        let quote = try JSONDecoder().decode(Quote.self, from: data)
                
        
        //return quote
        return quote
    }
    
    
    func fetchCharacter(_ name: String) async throws -> Character {
        
        let characterURL = baseURL.appending(path: "characters")
        let fetchURL = characterURL.appending(queryItems: [URLQueryItem(name: "name", value: name)])
        
        
        let (data, response) = try await URLSession.shared.data(from: fetchURL)
        
        guard let response = response as? HTTPURLResponse , response.statusCode == 200 else{
            throw FetchError.badResponse
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let characters = try decoder.decode([Character].self, from: data)
        
        return characters[0]
       
    }
    
}
