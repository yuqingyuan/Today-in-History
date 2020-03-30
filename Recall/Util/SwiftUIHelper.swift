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

extension View {
    func `if`<Content: View>(_ conditional: Bool, content: (Self) -> Content) -> some View {
        if conditional {
            return AnyView(content(self))
        } else {
            return AnyView(self)
        }
    }
}
