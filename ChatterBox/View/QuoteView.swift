import SwiftUI

struct QuoteView: View {
    let vm = ViewModel()
    let show: String
    
    var body: some View {
        GeometryReader{ geo in
            ZStack{
                Image(show.lowercased().replacingOccurrences(of: " ", with: ""))
                    .resizable()
                    .frame(width: geo.size.width * 2.7,height: geo.size.height * 1.2 )
                
                VStack{
                    Text("\"\(vm.quote.quote)\"")
                        .frame(width: geo.size.width ,height: geo.size.height )
                }
            }
            .frame(width: geo.size.width ,height: geo.size.height )
        }
        .ignoresSafeArea()
    }
}

#Preview {
    QuoteView(show: "Breaking Bad")
        .preferredColorScheme(.dark)
}
