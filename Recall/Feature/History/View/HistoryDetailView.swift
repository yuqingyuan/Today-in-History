//
//  HistoryDetailView.swift
//  Recall
//
//  Created by Yuqingyuan on 2020/3/18.
//  Copyright © 2020 俞清源. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI

struct HistoryHeadView: View {
    let picURL: URL
    
    var body: some View {
        KFImage(picURL)
            .if(isPhone) {
                $0.resizable()
                .frame(width: nil, height: 200, alignment: .center)
            }
            .cornerRadius(10, antialiased: true)
            .padding([.leading, .trailing])
    }
}

struct HistoryContentView: View {
    var viewModel: EventViewModel
    @State var scale = CGSize.zero
    
    var body: some View {
        GeometryReader { geo in
            ScrollView(showsIndicators: false) {
                If(self.viewModel.picURL != nil) {
                    HistoryHeadView(picURL: self.viewModel.picURL!)
                        .scaleEffect(self.scale)
                        .animation(.spring(dampingFraction: 0.7))
                        .onAppear {
                            self.scale = CGSize(width: 1, height: 1)
                        }
                }
                
                Text(self.viewModel.title)
                    .padding([.leading, .trailing])
                    .frame(width: geo.size.width, height: nil, alignment: .center)
                    .multilineTextAlignment(.center)
                    .font(.title)

                Spacer(minLength: 10)

                Text(self.viewModel.detail)
                    .padding([.leading, .trailing])
                    .frame(width: geo.size.width, height: nil, alignment: .center)
                    .multilineTextAlignment(.leading)
            }
        }
    }
}

struct HistoryDetailMainView: View {
    @State var viewModel: EventViewModel
    @State var opacity = Double.zero
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            HistoryContentView(viewModel: self.viewModel)
                .opacity(self.opacity)
                .animation(.linear(duration: 1.0))
                .onAppear {
                    self.opacity = 1.0
                }
            
            Spacer()
        }
        .edgesIgnoringSafeArea([.bottom])
        .navigationBarTitle(Text(viewModel.dateStr), displayMode: .automatic)
    }
}

#if DEBUG
struct HistoryDetailMainView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HistoryDetailMainView(viewModel: debugViewModel)
        }
    }
}
#endif
