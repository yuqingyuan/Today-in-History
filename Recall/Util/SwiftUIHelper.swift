//
//  SwiftUIHelper.swift
//  Recall
//
//  Created by yuqingyuan on 2020/3/30.
//  Copyright © 2020 俞清源. All rights reserved.
//

import Foundation
import SwiftUI

struct If<Output : View> : View {
    init?(_ value: Bool, product: @escaping () -> Output) {
        if value {
            self.product = product
        } else {
            return nil
        }
    }

    private let product: () -> Output

    var body: some View {
        product()
    }
}

//MARK: 拓展ViewModifier
extension View {
    func `if`<Content: View>(_ conditional: Bool, content: (Self) -> Content) -> some View {
        if conditional {
            return AnyView(content(self))
        } else {
            return AnyView(self)
        }
    }
}

//MARK: 对@Binding修饰的Bool类型进行取反,eg:$isOn.negative()
extension Binding where Value == Bool {
    public func negate() -> Binding<Bool> {
        return Binding<Bool>(get: { !self.wrappedValue }) { _ in }
    }
}

struct MultipleSelectionRow: View {
    var title: String
    var isSelected: Bool
    var action: () -> Void

    var body: some View {
        Button(action: self.action) {
            HStack {
                Text(self.title)
                
                if self.isSelected {
                    Spacer()
                    Image(systemName: "checkmark").foregroundColor(.blue)
                }
            }
        }
        .foregroundColor(.primary)
    }
}
