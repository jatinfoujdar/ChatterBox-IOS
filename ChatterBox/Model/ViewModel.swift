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
    var character: Char
    
    
    init() {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        do {
            guard let quoteDataURL = Bundle.main.url(forResource: "samplequote", withExtension: "json") else {
                fatalError("Missing samplequote.json file")
            }
            let quoteData = try Data(contentsOf: quoteDataURL)
            quote = try decoder.decode(Quote.self, from: quoteData)
            
            guard let characterDataURL = Bundle.main.url(forResource: "samplecharacter", withExtension: "json") else {
                fatalError("Missing samplecharacter.json file")
            }
            let characterData = try Data(contentsOf: characterDataURL)
            character = try decoder.decode(Char.self, from: characterData)
        } catch {
            fatalError("Error loading or decoding JSON data: \(error)")
        }
    }
    
    func getData(for show: String) async{
        status = .fetching
        
        do{
            quote = try await fetcher.fetchQuote(from: show)
           
            character = try await fetcher.fetchCharacter(quote.character)
            
            character.death = try await fetcher.fetchDeath(for: character.name)
                
            status = .success
        }catch{
            status = .failed(error: error)
        }
    }
}
