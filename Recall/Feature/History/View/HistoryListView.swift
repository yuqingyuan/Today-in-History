//
//  HistoryListView.swift
//  Recall
//
//  Created by 俞清源 on 2020/2/28.
//  Copyright © 2020 俞清源. All rights reserved.
//

import SwiftUI

struct HistoryListView: View {
    @ObservedObject var viewModel = EventListViewModel()
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottomTrailing) {
                List(viewModel.events) { model in
                    IntroCellView(viewModel: model)
                        .frame(width: nil, height: 140, alignment: .center)
                        .shadow(color: .gray, radius: 6, x: 0, y: 5)
                }
                .listRowBackground(Color(.clear))
                .listStyle(PlainListStyle())
                .navigationBarTitle(Text("历史上的今天"), displayMode: .automatic)
                .navigationBarItems(trailing:
                    NavigationLink(destination: SettingsView()) {
                        Image(systemName: "gear")
                })
                .onAppear() {
                    UITableView.appearance().separatorStyle = .none
                }
                
                ReloadButton(isLoading: $viewModel.isLoading) {
                    
                }
                .offset(x: -20, y: -20)
            }
        }
    }
}

struct HistoryListView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryListView()
    }
}
