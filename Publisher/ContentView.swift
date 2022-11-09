//
//  ContentView.swift
//  Publisher
//
//  Created by npc on 2022/11/09.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                Text("SwiftUI(のViewModelを変える）↓")
                Spacer()
            }
            HStack {
                Text(viewModel.displayingLabel)
                    .padding(.horizontal, 10)
                Spacer()
                Button {
                    viewModel.displayingLabel = "きえた"
                } label: {
                    Text("くりあ")
                        .frame(width: 75, height: 60)
                        .background(.blue)
                        .foregroundColor(Color.white)
                        .padding(.trailing, 20)
                }
            }
            
            HStack {
                Spacer()
                Text("UIViewからViewModelを変える↓")
                Spacer()
            }
            CustomView(viewModel: viewModel)
                .frame(height: 100)
        }
        .padding()
    }
}

class ContentViewModel: ObservableObject {
    @Published var displayingLabel: String = "hogeらっちょ"
}

struct CustomView: UIViewRepresentable {
    typealias UIViewType = CustomUIView
    @ObservedObject var viewModel: ContentViewModel
    
    func makeUIView(context: Context) -> CustomUIView {
        let customView = CustomUIView()
        customView.viewModel = viewModel
        return customView
    }
    
    func updateUIView(_ uiView: CustomUIView, context: Context) {
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
