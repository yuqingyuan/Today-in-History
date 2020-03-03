//
//  BannerView.swift
//  Recall
//
//  Created by 俞清源 on 2020/2/28.
//  Copyright © 2020 俞清源. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI

struct BannerView: View {
    var body: some View {
        GeometryReader { geo in
            ZStack {
                KFImage(URL(string: "http://www.todayonhistory.com/upic/201002/18/791933708.jpg"))
                    .resizable()
                    .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                    .scaledToFill()
                
                VStack {
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text("发生时间 - 历史事件的名称")
                            .font(.system(size: 18))
                            .foregroundColor(.white)
                            .lineLimit(1)
                        
                        Text("历史事件详细内容")
                            .font(.system(size: 12))
                            .foregroundColor(.white)
                    }
                    .padding(6)
                    .frame(width: geo.size.width, height: geo.size.height/3.0, alignment: .topLeading)
                    .background(Color(.init(red: 0, green: 0, blue: 0, alpha: 0.8)))
                }
            }
        }
    }
}

struct BannerView_Previews: PreviewProvider {
    static var previews: some View {
        BannerView().previewDevice("iPhone X")
    }
}
