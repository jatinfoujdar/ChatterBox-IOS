import Foundation



struct FetchService{
    enum FetchError: Error{
        case badResponse
    }
    
    let baseURL = URL(string: "https://breaking-bad-api-six.vercel.app/api")!

    func fetchQuote(from show: String) async throws -> Quote{
        
        let quoteUrl = baseURL.appending(path: "quotes/random")
        let fetchUrl = quoteUrl.appending(queryItems: [URLQueryItem(name: "production", value: show)])
        
    }
    
}
