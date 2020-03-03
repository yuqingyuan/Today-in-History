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
        Button(action: {
            
        }, label: {
            GeometryReader { geo in
                VStack(alignment: .center, spacing: 0) {
                    HStack(alignment: .center, spacing: 12) {
                        Image(systemName: "calendar")
                        Text(self.viewModel.dateStr)
                        Spacer()
                    }
                    .frame(width: geo.size.width, height: geo.size.height/5.0, alignment: .center)
                    .padding([.leading], 30)
                    .background(Color(.tertiarySystemFill))
                    
                    HStack {
                        HStack {
                            KFImage(self.viewModel.picURL).placeholder {
                                Image(systemName: "photo")
                            }
                            .resizable()
                            .frame(width: geo.size.height*0.5, height: geo.size.height*0.5, alignment: .center)
                            .background(Color(.systemGray4))
                            .cornerRadius(12)
                            .padding([.leading], 14)
                            
                            VStack(alignment: .leading) {
                                Text(self.viewModel.title)
                                    .lineLimit(1)
                                Text(self.viewModel.detail)
                            }
                            .frame(width: nil, height: geo.size.height*0.5, alignment: .topLeading)
                            
                            Spacer()
                            
                            Button(action: {
                                
                            }, label: {
                                Image(systemName: "chevron.right")
                            })
                            .padding([.trailing], 10)
                        }
                    }
                    .frame(width: geo.size.width, height: 4.0*geo.size.height/5.0, alignment: .center)
                    .background(Color(.quaternarySystemFill))
                }
                .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                .cornerRadius(20)
            }
        })
        .buttonStyle(PlainButtonStyle())
    }
}

struct IntroCellView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geo in
            IntroCellView(viewModel: EventViewModel(0, event: HistoryEvent(picUrl: "http://www.todayonhistory.com/upic/201002/18/791933708.jpg", title: "Title", year: "2020", month: "3", day: "2", details: "content")))
                .frame(width: geo.size.width-20, height: 160, alignment: .center)
                .offset(.init(width: 10, height: 0))
        }
    }
}
