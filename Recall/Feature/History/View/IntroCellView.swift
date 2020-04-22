//
//  IntroCellView.swift
//  Recall
//
//  Created by 俞清源 on 2020/3/1.
//  Copyright © 2020 俞清源. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI

struct Thumbnail: View {
    let picURL: URL
    @State var error: Bool = false
    
    var body: some View {
        KFImage(picURL)
            .placeholder {
                if self.error {
                    Image(systemName: "exclamationmark.triangle")
                } else {
                    Image(systemName: "photo")
                }
            }
            .onFailure { _ in
                self.error = true
            }
            .resizable()
    }
}

struct IntroCellView: View {

    @State var viewModel: EventViewModel
    @State var error: Bool = false
    var hasPic: Bool {
        viewModel.picURL != nil
    }
    
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
                        if(self.hasPic) {
                            Thumbnail(picURL: self.viewModel.picURL!)
                                .frame(width: geo.size.height*0.6, height: geo.size.height*0.6, alignment: .center)
                                .cornerRadius(12)
                                .padding([.leading], 14)
                        }

                        VStack(alignment: .leading, spacing: 0) {
                            Text(self.viewModel.title)
                                .font(.headline)
                                .lineLimit(1)
                            Text(self.viewModel.detail)
                                .font(.subheadline)
                        }
                        .frame(width: nil, height: geo.size.height*0.6, alignment: .topLeading)
                        .if(!self.hasPic) {
                            $0.padding([.leading], 14)
                        }

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
            IntroCellView(viewModel: debugViewModel)
                .frame(width: geo.size.width-20, height: 160, alignment: .center)
                .offset(.init(width: 10, height: 0))
                .shadow(color: Color(UIColor.systemGray3), radius: 6, x: 0, y: 5)
        }
    }
}
#endif
