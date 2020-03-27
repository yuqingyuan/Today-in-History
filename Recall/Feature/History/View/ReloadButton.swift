//
//  ReloadButton.swift
//  Recall
//
//  Created by 俞清源 on 2020/3/2.
//  Copyright © 2020 俞清源. All rights reserved.
//

import SwiftUI

struct ReloadButton: View {

    @Binding var isLoading: Bool

    let action: () -> Void
    private var animation: Animation {
        Animation.linear(duration: isLoading ? 0.5 : 0)
            .repeatCount(.max, autoreverses: false)
    }

    var body: some View {
        Button(action: {
            self.action()
        }, label: {
            Image(systemName: "arrow.2.circlepath")
                .frame(width: 60, height: 60, alignment: .center)
                .rotationEffect(.radians(isLoading ? .pi*2 : 0))
                .animation(animation)
        })
        .disabled(isLoading)
        .background(Color(UIColor.systemGray5))
        .cornerRadius(30)
    }
}

struct ReloadButton_Previews: PreviewProvider {
    
    struct ReloadButtonPreview: View {
        @State var testFlag = false
        var body: some View {
            ReloadButton(isLoading: $testFlag) {
                self.testFlag.toggle()
                DispatchQueue.main.asyncAfter(deadline: .now()+2) {
                    self.testFlag.toggle()
                }
            }
        }
    }
    
    static var previews: some View {
        ReloadButtonPreview()
            .shadow(radius: 6)
    }
}
