//
//  ReloadButton.swift
//  Recall
//
//  Created by 俞清源 on 2020/3/2.
//  Copyright © 2020 俞清源. All rights reserved.
//

import SwiftUI

struct ReloadButton: View {
    
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            self.action()
        }, label: {
            Image(systemName: "arrow.2.circlepath")
                .frame(width: 60, height: 60, alignment: .center)
                .foregroundColor(.black)
                .background(Color(.systemGray5))
                .cornerRadius(30)
                .shadow(radius: 10)
        })
    }
}

struct ReloadButton_Previews: PreviewProvider {
    static var previews: some View {
        ReloadButton {
            
        }
    }
}
