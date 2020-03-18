//
//  IntroCellView.swift
//  Recall
//
//  Created by 俞清源 on 2020/3/1.
//  Copyright © 2020 俞清源. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI

struct IntroCellView: View {

    @State var viewModel: EventViewModel
    
    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .center, spacing: 0) {
                HStack(alignment: .center, spacing: 12) {
                    Image(systemName: "calendar")
                    Text(self.viewModel.dateStr)
                    Spacer()
                }
                .frame(width: geo.size.width, height: geo.size.height/5.0, alignment: .center)
                .padding([.leading], 30)

                Divider()

                HStack {
                    HStack {
                        KFImage(self.viewModel.picURL).placeholder {
                            Image(systemName: "photo")
                        }
                        .resizable()
                        .frame(width: geo.size.height*0.6, height: geo.size.height*0.6, alignment: .center)
                        .cornerRadius(12)
                        .padding([.leading], 14)

                        VStack(alignment: .leading, spacing: 0) {
                            Text(self.viewModel.title)
                                .font(.headline)
                                .lineLimit(1)
                            Text(self.viewModel.detail)
                                .font(.subheadline)
                        }
                        .frame(width: nil, height: geo.size.height*0.6, alignment: .topLeading)

                        Spacer()

                        Image(systemName: "chevron.right")
                            .padding([.trailing], 10)
                    }
                }
                .frame(width: geo.size.width, height: 4.0*geo.size.height/5.0, alignment: .center)
            }
            .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
        }
        .background(Color(UIColor.systemGray5))
        .cornerRadius(20)
    }
}

#if DEBUG
struct IntroCellView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geo in
            IntroCellView(viewModel: EventViewModel(0, event: HistoryEvent(picUrl: "http://www.todayonhistory.com/upic/201002/18/791933708.jpg",
                                                                           title: "Title",
                                                                           year: "2020",
                                                                           month: 3,
                                                                           day: 2,
                                                                           details: "content")))
                .frame(width: geo.size.width-20, height: 160, alignment: .center)
                .offset(.init(width: 10, height: 0))
                .shadow(color: Color(UIColor.systemGray3), radius: 6, x: 0, y: 5)
        }
    }
}
#endif
