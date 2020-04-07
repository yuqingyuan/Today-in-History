//
//  UserSettingView.swift
//  Recall
//
//  Created by yuqingyuan on 2020/3/31.
//  Copyright © 2020 俞清源. All rights reserved.
//

import SwiftUI

struct UserSettingView: View {
    @ObservedObject var notiViewModel = NotificationSettingViewModel()
    
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
                Toggle(isOn: $notiViewModel.isOn) {
                    Text("消息通知")
                }
                NavigationLink(destination: PeriodSelectionView(viewModel: notiViewModel)) {
                    Text("重复")
                }
                DatePicker("时间", selection: $notiViewModel.pushDate, displayedComponents: [.hourAndMinute])
            }
        }
        .navigationBarTitle(Text("设置"), displayMode: .large)
        .navigationBarItems(trailing: Button("保存") {
            self.notiViewModel.saveSettings()
        })
        .alert(item: $notiViewModel.alertIdentifier) { identifier in
            switch identifier {
            case .boot: return bootAlert
            case .success: return saveStatusAlert(true)
            case .failure: return saveStatusAlert(false)
            }
        }
    }
}

extension UserSettingView {
    func saveStatusAlert(_ isSuccess: Bool) -> Alert {
        Alert(title: isSuccess ? Text("设置保存成功") : Text("设置保存失败，请重试"))
    }
}

/// 通知重复周期多选列表
struct PeriodSelectionView: View {
    @ObservedObject var viewModel: NotificationSettingViewModel
    
    var body: some View {
        List(viewModel.periodList) { value in
            MultipleSelectionRow(title: value.description, isSelected: self.viewModel.periodSelection.contains(value)) {
                if self.viewModel.periodSelection.contains(value) {
                    self.viewModel.periodSelection.removeAll(where: { $0 == value })
                } else {
                    self.viewModel.periodSelection.append(value)
                }
            }
        }
    }
}

#if DEBUG
struct UserSettingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            UserSettingView()
        }
    }
}
#endif
