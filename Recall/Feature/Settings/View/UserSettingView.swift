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
    @State var dateChoice = 0
    @State var isRepeat = 2
    @State var selectedDate = Date()
    
    var bootAlert: Alert {
        Alert(title: Text("提示"), message: Text("请在系统设置开启或关闭通知推送功能"), dismissButton: .default(Text("现在去设置"), action: {
            if let settingURL = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(settingURL, options: [:], completionHandler: nil)
            }
        }))
    }
    
    var body: some View {
        Form {
            Section {
                Toggle(isOn: $settingViewModel.isNotificationOn) {
                    Text("本地通知")
                }
                Picker("频率", selection: $dateChoice) {
                    Text("周一").tag(1)
                }
                Picker("重复", selection: $isRepeat) {
                    Text("是").tag(1)
                    Text("否").tag(2)
                }
                DatePicker("时间", selection: $selectedDate, displayedComponents: [.hourAndMinute])
            }
        }
        .navigationBarTitle(Text("设置"), displayMode: .large)
        .alert(isPresented: $settingViewModel.showBootAlert) { bootAlert }
    }
}

struct UserSettingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            UserSettingView()
        }
    }
}
