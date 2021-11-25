//
//  HXWRefreshCycleHeader.swift
//  HXWRefreshDemo
//
//  Created by 华晓伟 on 2020/3/10.
//  Copyright © 2020 hxw. All rights reserved.
//

import UIKit

open class HXWRefreshCycleHeader: HXWRefreshHeader {

    lazy var refreshIndicater: HXWRefreshIndicater = { [unowned self] in
        var indicater = HXWRefreshIndicater()
        return indicater
        }()
    
    let imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(textLbl)
        addSubview(refreshIndicater)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func layoutSubviews() {
        refreshIndicater.frame = CGRect (x: 100, y: 20, width: height - 40, height: height - 40)
        textLbl.frame = CGRect (x: refreshIndicater.right + 30, y: 0, width: CalcTextWidth(textStr: "下拉加载", font: textLbl.font, height: height), height: height)
    }
    
    func CalcTextWidth(textStr: String,font: UIFont,height: CGFloat) -> CGFloat {
        let statusLabelText: String = textStr
        let size = CGSize(width: 900, height: height)
        let dic = NSDictionary(object: font, forKey: NSAttributedStringKey.font as NSCopying)
        let strSize = statusLabelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic as? [NSAttributedStringKey : AnyObject], context: nil).size
        return strSize.width + 5
    }

}

extension HXWRefreshCycleHeader {
    
    //MARK: /**普通**/
    open override func normal() {
        textLbl.text = Bundle.HXWLocalizedString(key: HXWPullDownToRefresh)
    }
    
    //MARK: /**即将刷新**/
    open override func willRefresh() {
        textLbl.text = Bundle.HXWLocalizedString(key: HXWReleaseToRefresh)
    }
    
    //MARK: /**刷新中**/
    open override func refreshing() {
        textLbl.text = Bundle.HXWLocalizedString(key: HXWRefreshing)
        refreshIndicater.startRotate()
        headerRefreshDelegate?.refresh()
        if refreshBlock != nil {
            refreshBlock!()
        }
    }
    
    //MARK: /**刷新完成**/
    open override func refreshed() {
        textLbl.text = Bundle.HXWLocalizedString(key: HXWPullDownToRefresh)
        refreshIndicater.endRotate()
        refreshIndicater.progress = 0
    }
    
    //MARK: /**更新拖动进度**/
    open override func updateProgress() {
        refreshIndicater.progress = progress
    }
    
}
