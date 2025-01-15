import Foundation


@Observable
@MainActor
class ViewModel{
    
    enum FetchStatus{
        case notStarted
        case fetching
        case success
        case failed(error:Error)
    }
    
    private(set) var status: FetchStatus = .notStarted
    
    private let fetcher = FetchService()
    
    var quote: Quote
    var character: Character
    
    
    init(){
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let quoteData = try! Data(contentsOf: Bundle.main.url(forResource: "samplequote", withExtension: "json")!)
        quote = try! decoder.decode(Quote.self, from: quoteData)
        
        let characterData = try! Data(contentsOf: Bundle.main.url(forResource: "samplequote", withExtension: "json")!)
        character = try! decoder.decode(Character.self, from: characterData)
    }
}
