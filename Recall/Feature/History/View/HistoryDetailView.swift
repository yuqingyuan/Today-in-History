//
//  HistoryDetailView.swift
//  Recall
//
//  Created by Yuqingyuan on 2020/3/18.
//  Copyright © 2020 俞清源. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI

struct HistoryDetailNaviBarItem: View {
    @Environment(\.presentationMode) var mode
    
    var body: some View {
        Button(action: {
            self.mode.wrappedValue.dismiss()
        }) {
            Image(systemName: "arrow.left")
                .scaledToFit()
                .frame(width: 38, height: 38, alignment: .center)
        }
        .background(Color(UIColor.systemGray5))
        .cornerRadius(14)
    }
}

struct HistoryHeadView: View {
    let picURL: URL
    
    var body: some View {
        KFImage(picURL)
            .resizable()
            .frame(width: nil, height: 260, alignment: .center)
            .cornerRadius(10, antialiased: true)
            .padding([.leading, .trailing])
    }
}

struct HistoryContentView: View {
    let title: String
    let detail: String
    
    var body: some View {
        ScrollView {
            Text(title)
                .multilineTextAlignment(.center)
                .padding([.leading, .trailing])
                .font(.title)
            
            Spacer(minLength: 10)
            
            Text(detail)
                .multilineTextAlignment(.leading)
                .padding([.leading, .trailing])
            
            Spacer()
        }
    }
}

struct HistoryDetailMainView: View {
    @State var viewModel: EventViewModel
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            If(self.viewModel.picURL != nil) {
                HistoryHeadView(picURL: self.viewModel.picURL!)
            }
            
            HistoryContentView(title: viewModel.title, detail: viewModel.detail)
            
            Spacer()
        }
        .edgesIgnoringSafeArea([.bottom])
        .navigationBarTitle(Text(viewModel.dateStr), displayMode: .large)
        .if(isPhone) {
            $0.navigationBarItems(leading: HistoryDetailNaviBarItem())
        }
    }
}

#if DEBUG
struct HistoryDetailMainView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HistoryDetailMainView(viewModel: EventViewModel(0, event: HistoryEvent(picUrl: "http://www.todayonhistory.com/upic/201002/18/791933708.jpg", title: "标题", year: "2020", month: 2, day: 3, details: "内容")))
        }
    }
}
#endif
