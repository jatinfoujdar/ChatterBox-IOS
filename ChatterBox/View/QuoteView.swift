import SwiftUI

struct QuoteView: View {
    let vm = ViewModel()
    let show: String
    
    @State var showCharater = false
    
    var body: some View {
        GeometryReader{ geo in
            ZStack{
                Image(show.lowercased().replacingOccurrences(of: " ", with: ""))
                    .resizable()
                    .frame(width: geo.size.width * 2.7,height: geo.size.height * 1.2 )
                
                VStack{
                    VStack{
                        Spacer(minLength: 60)
                        switch vm.status {
                        case .notStarted:
                            EmptyView()
                        case .fetching:
                            ProgressView()
                        case .success:
                            Text("\"\(vm.quote.quote)\"")
                                .minimumScaleFactor(0.5)
                                .multilineTextAlignment(.center)
                                .padding()
                                .background(.black.opacity(0.5))
                                .clipShape(.rect(cornerRadius: 25))
                                .padding(.horizontal)
                            
                            ZStack(alignment: .bottom){
                                AsyncImage(url: vm.character.images[0]){ image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                }placeholder: {
                                    ProgressView()
                                }
                                .frame(width: geo.size.width/1.1 ,height: geo.size.height/1.8)
                                
                                Text(vm.quote.character)
                                    .foregroundColor(.white)
                                    .padding(10)
                                    .frame(maxWidth: .infinity)
                                    .background(.ultraThinMaterial)
                            }
                            .frame(width: geo.size.width/1.1 ,height: geo.size.height/1.8)
                            .clipShape(.rect(cornerRadius: 50))
                            .onTapGesture {
                                showCharater.toggle()
                            }
                        case .failed(let error):
                            Text(error.localizedDescription)
                        }
                        Spacer()
                    }
                    
                    Button{
                        Task{
                            await vm.getData(for: show)
                        }
                    }label: {
                        Text("Get Random Quote")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding()
                            .background(.breakinggreen)
                            .clipShape(.rect(cornerRadius: 7))
                            .shadow(color: .black, radius: 2)
                    }
                    Spacer(minLength: 95)
                }
                .frame(width: geo.size.width ,height: geo.size.height)
            }
            .frame(width: geo.size.width ,height: geo.size.height )
        }
        .ignoresSafeArea()
        
        .sheet(isPresented: $showCharater){
            CharaterView(character: vm.character, show: show)
        }
    }
}

#Preview {
    QuoteView(show: "Better Call Saul")
        .preferredColorScheme(.dark)
}
