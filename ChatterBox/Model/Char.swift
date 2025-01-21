import Foundation

struct Char: Decodable {
    let name: String
    let birthday: String
    let occupation: [String]?
    let images: [URL]
    let aliases: [String]
    let status: String
    let portrayedBy: String
    var death: Death? // Make this optional
    
    enum CodingKeys: String, CodingKey {
        case name
        case birthday
        case occupation
        case images
        case aliases
        case status
        case portrayedBy
    }
    
    init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.name = try container.decode(String.self, forKey: .name)
            self.birthday = try container.decode(String.self, forKey: .birthday)
            self.occupation = try? container.decode([String].self, forKey: .occupation)
            self.images = try container.decode([URL].self, forKey: .images)
            self.aliases = try container.decode([String].self, forKey: .aliases)
            self.status = try container.decode(String.self, forKey: .status)
            self.portrayedBy = try container.decode(String.self, forKey: .portrayedBy)
                
        // Handle the optional death data with safe decoding
        let deathDecoder = JSONDecoder()
        deathDecoder.keyDecodingStrategy = .convertFromSnakeCase
        
        if let deathURL = Bundle.main.url(forResource: "sampledeath", withExtension: "json") {
            do {
                let deathData = try Data(contentsOf: deathURL)
                self.death = try deathDecoder.decode(Death.self, from: deathData)
            } catch {
                print("Error loading or decoding 'sampledeath.json': \(error)")
                self.death = nil // If there's an error, set death to nil
            }
        } else {
            print("Error: 'sampledeath.json' file not found.")
            self.death = nil // If the file doesn't exist, set death to nil
        }
    }
}
