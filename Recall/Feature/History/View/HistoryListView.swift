//
//  HistoryListView.swift
//  Recall
//
//  Created by 俞清源 on 2020/2/28.
//  Copyright © 2020 俞清源. All rights reserved.
//

import SwiftUI

struct ListViewCell: View {
    let viewModel: EventViewModel
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @State private var longPressTap = false
    
    var body: some View {
        HStack {
            if self.colorScheme == .light {
                IntroCellView(viewModel: viewModel)
                    .shadow(color: Color(UIColor.systemGray3), radius: 6, x: 0, y: 5)
            } else {
                IntroCellView(viewModel: viewModel)
            }
        }
        .frame(width: nil, height: 140, alignment: .center)
        .padding([.top, .bottom], 8)
        .opacity(self.longPressTap ? 0.4 : 1.0)
        .onTapGesture {
            
        }
        .onLongPressGesture(minimumDuration: .infinity, maximumDistance: .infinity, pressing: { pressing in
            self.longPressTap = pressing
        }) {
            
        }
        .animation(.default)
    }
}

struct HistoryListView: View {
    @ObservedObject var viewModel = EventListViewModel()
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottomTrailing) {
                List(viewModel.events) { model in
                    ListViewCell(viewModel: model)
                }
                .listRowBackground(Color(.clear))
                .navigationBarTitle(Text("历史上的今天"), displayMode: .automatic)
                .onAppear() {
                    UITableView.appearance().separatorStyle = .none
                    self.viewModel.fetch()
                }
                
                ReloadButton(isLoading: $viewModel.isLoading) {
                    self.viewModel.fetch()
                }
                .shadow(radius: 10)
                .offset(x: -20, y: -20)
            }
        }
    }
}

#if DEBUG
struct HistoryListView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryListView()
    }
}
#endif
