//
//  UserSettingView.swift
//  Recall
//
//  Created by yuqingyuan on 2020/3/31.
//  Copyright © 2020 俞清源. All rights reserved.
//

import SwiftUI

struct UserSettingView: View {
    @ObservedObject var settingViewModel = UserSettingViewModel()
    
    var body: some View {
        Form {
            Toggle(isOn: $settingViewModel.isLocalNotificationOn) {
                Text("本地通知")
            }
        }
        .navigationBarTitle(Text("设置"), displayMode: .large)
    }
}

struct UserSettingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            UserSettingView()
        }
    }
}
