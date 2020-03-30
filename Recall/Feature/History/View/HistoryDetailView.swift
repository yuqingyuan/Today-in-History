//
//  HistoryDetailView.swift
//  Recall
//
//  Created by Yuqingyuan on 2020/3/18.
//  Copyright © 2020 俞清源. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI

struct HistoryDetailView: View {
    let viewModel: EventViewModel
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true, content: {
            VStack(alignment: .center, spacing: 10.0) {
                If(viewModel.picURL != nil) {
                    KFImage(self.viewModel.picURL)
                        .resizable()
                }
                
                Text(viewModel.title)
                    .font(.title)
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.center)
                
                Text(viewModel.detail)
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.leading)
                    .padding([.leading, .trailing], 4.0)

                HStack {
                    Spacer()
                    Text(viewModel.dateStr)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
        })
        .navigationBarTitle(Text(""), displayMode: .inline)
    }
}

struct HistoryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryDetailView(viewModel: EventViewModel(0, event: HistoryEvent(picUrl: nil, title: "标题", year: "2020", month: 2, day: 3, details: "内容")))
    }
}
