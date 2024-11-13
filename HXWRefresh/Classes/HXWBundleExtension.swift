//
//  HXWBundleExtension.swift
//  HXWRefreshDemo
//
//  Created by 华晓伟 on 2020/3/10.
//  Copyright © 2020 hxw. All rights reserved.
//

import UIKit

public extension Bundle{
    
    static var HXWRefreshBundle: Bundle? {
        struct StaticBundle {
            static let refreshStr: String =  Bundle(for: HXWRefreshView.self).path(forResource: "HXWRefresh", ofType: "bundle")!
            static let rbundle: Bundle = Bundle(path: Bundle(path: refreshStr)!.path(forResource: "Resource", ofType: "bundle")!)!
        }
        return StaticBundle.rbundle
    }
    
    static var HXWLanguageBundle: Bundle?{
        var language = Locale.preferredLanguages.first
        if (language?.hasPrefix("en"))! {
            language="en"
        }else if (language?.hasPrefix("zh"))! {
            if ((language?.range(of: "Hans")) != nil) {
                language="zh-Hans"
            }else{
                //zh-Hant\zh-HK\zh-TW
                language="zh-Hant"
            }
        }else{
            language="en"
        }
        return Bundle(path: (Bundle.HXWRefreshBundle?.path(forResource: language, ofType: "lproj"))!)
    }
        
    class func HXWLocalizedString(key:String) -> String? {
        let valueReal = self.HXWLanguageBundle?.localizedString(forKey: key, value: nil, table: nil)
        //自己的配置文件重新改数据，不修改就用默认的
        return self.main.localizedString(forKey: key, value: valueReal, table: nil)
    }
    
}
