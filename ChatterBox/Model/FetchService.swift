import Foundation



struct FetchService{
    enum FetchError: Error{
        case badResponse
    }
    
    let baseURL = URL(string: "https://breaking-bad-api-six.vercel.app/api")!

    func fetchQuote(from show: String) async throws -> Quote{
        
        let quoteUrl = baseURL.appending(path: "quotes/random")
        let fetchUrl = quoteUrl.appending(queryItems: [URLQueryItem(name: "production", value: show)])
        
        //fetch data
        let (data, response) = try await URLSession.shared.data(from: fetchUrl)
        
        //handle response
        guard let response = response as? HTTPURLResponse , response.statusCode == 200 else{
            throw FetchError.badResponse
        }
        
        //decode data
        let quote = try JSONDecoder().decode(Quote.self, from: data)
                
        
        //return quote
        return quote
    }
    
}
