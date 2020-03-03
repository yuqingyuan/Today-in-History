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
        Animation.linear(duration: 1)
            .repeatCount(isLoading ? .max : 0, autoreverses: false)
    }

    var body: some View {
        VStack {
            Button(action: {
                self.action()
            }, label: {
                Image(systemName: "arrow.2.circlepath")
                    .frame(width: 60, height: 60, alignment: .center)
                    .foregroundColor(.black)
                    .background(Color(.systemGray5))
                    .cornerRadius(30)
                    .shadow(radius: 10)
                    .rotationEffect(.radians(isLoading ? .pi*2 : 0))
                    .animation(animation)
            })
            .disabled(isLoading)
        }
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
    }
}
