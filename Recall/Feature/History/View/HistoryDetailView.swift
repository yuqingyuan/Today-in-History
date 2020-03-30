//
//  HistoryDetailView.swift
//  Recall
//
//  Created by Yuqingyuan on 2020/3/18.
//  Copyright © 2020 俞清源. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI

struct HistoryDetailNaviBar: View {
    @Environment(\.presentationMode) var mode
    
    var body: some View {
        HStack(alignment: .center) {
            Button(action: {
                self.mode.wrappedValue.dismiss()
            }) {
                Image(systemName: "arrow.left")
                    .scaledToFit()
                    .frame(width: 38, height: 38, alignment: .center)
            }
            .background(Color(UIColor.systemGray5))
            .cornerRadius(14)
            .shadow(radius: 2)
            
            Spacer()
        }
    }
}

struct HistoryDetailView: View {
    @State var viewModel: EventViewModel
    
    var body: some View {
        VStack {
            Text("施工中...")
        }
        .navigationBarItems(leading: HistoryDetailNaviBar().padding([.leading], 2))
    }
}

struct HistoryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryDetailView(viewModel: EventViewModel(0, event: HistoryEvent(picUrl: nil, title: "标题", year: "2020", month: 2, day: 3, details: "内容")))
    }
}
