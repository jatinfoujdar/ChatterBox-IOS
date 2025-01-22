import SwiftUI

struct CharaterView: View {
    let character : Char
    let show : String
    var body: some View {
        GeometryReader{geo in
            ZStack(alignment: .top){
                Image(show.lowercased().replacingOccurrences(of: " ", with: ""))
                    .resizable()
                    .scaledToFit()
                
                ScrollView{
                    AsyncImage(url: character.images[0]){ image in
                        image
                            .resizable()
                            .scaledToFill()
                    }placeholder: {
                        ProgressView()
                    }
                    .frame(width: geo.size.width/1.2, height: geo.size.height/1.7)
                    .clipShape(.rect(cornerRadius: 25))
                    .padding(.top,60)
                    
                    VStack(alignment: .leading){
                        Text(character.name)
                            .font(.largeTitle)
                        
                        Text("Portrayed By: \(character.portrayedBy)")
                        Divider()
                        Text("\(character.name) Character Info")
                            .font(.title2)
                        
                        Text("Born \(character.birthday)")
                        
                        Divider()
                        
                        Text("Occuptions:")
                        ForEach(character.occupation ?? [], id: \.self) { occupation in
                        Text("-\(occupation)")
                                .font(.subheadline)
                        }
                        Divider()
                        Text("Nicknames: ")
                        
                        if character.aliases.count > 0{
                            ForEach(character.aliases , id: \.self) { aliases in
                                Text("-\(aliases)")
                                    .font(.subheadline)
                               }
                            } else {
                                Text("None")
                                    .font(.subheadline)
                            }
                        
                        Divider()
                        
                        
                    }
                    .frame(width: geo.size.width/1.2, alignment: .leading)
                }
                .scrollIndicators(.hidden)
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    CharaterView(character: ViewModel().character, show: "Breaking Bad")
        .preferredColorScheme(.dark)
}
