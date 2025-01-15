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
    var chacter: Character
    
    
    init(){
        
    }
}
