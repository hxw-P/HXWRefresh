//
//  HXWRefreshExtension.swift
//  HXWRefreshDemo
//
//  Created by 华晓伟 on 2020/3/10.
//  Copyright © 2020 hxw. All rights reserved.
//


import UIKit

class HXWRefreshConstant {
    static var associatedObjectHXWHeader = 0
    static var associatedObjectHXWFooter = 1
}

public extension UIScrollView {
    
    fileprivate var hxwHeader: HXWRefreshHeader? {
        get {
            return objc_getAssociatedObject(self, &HXWRefreshConstant.associatedObjectHXWHeader) as? HXWRefreshHeader
        }
        set {
            if newValue == nil {
                objc_removeAssociatedObjects(hxwHeader as Any)
            } else {
                objc_setAssociatedObject(self, &HXWRefreshConstant.associatedObjectHXWHeader, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
    fileprivate var hxwFooter: HXWRefreshFooter? {
        get {
            return objc_getAssociatedObject(self, &HXWRefreshConstant.associatedObjectHXWFooter) as? HXWRefreshFooter
        }
        set {
            if newValue == nil {
                objc_removeAssociatedObjects(hxwFooter as Any)
            } else {
                objc_setAssociatedObject(self, &HXWRefreshConstant.associatedObjectHXWFooter, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
    
    //MARK: /**添加下拉刷新**/
    //默认下拉刷新
    func hxw_addRefreshHeaderView(refreshHeader: HXWRefreshHeader, delegate:HXWRefreshHeaderDelegate) {
        if hxwHeader != refreshHeader {
            hxwHeader?.removeFromSuperview()
            refreshHeader.headerRefreshDelegate = delegate
            refreshHeader.contentScrollview = self
            hxwHeader = refreshHeader
        }
    }
    
    func hxw_addRefreshHeaderView(refreshHeader: HXWRefreshHeader, refreshBlock:@escaping HXWRefreshBlock) {
        if hxwHeader != refreshHeader {
            hxwHeader?.removeFromSuperview()
            refreshHeader.refreshBlock = refreshBlock
            refreshHeader.contentScrollview = self
            hxwHeader = refreshHeader
        }
    }

    //下拉刷新高度自定义
    func hxw_addRefreshHeaderView(refreshHeader: HXWRefreshHeader, delegate:HXWRefreshHeaderDelegate, refreshHeaderHeight: CGFloat) {
        refreshHeader.headerHeight = refreshHeaderHeight
        if hxwHeader != refreshHeader {
            hxwHeader?.removeFromSuperview()
            refreshHeader.headerRefreshDelegate = delegate
            refreshHeader.contentScrollview = self
            hxwHeader = refreshHeader
        }
    }
    
    func hxw_addRefreshHeaderView(refreshHeader: HXWRefreshHeader, refreshHeaderHeight: CGFloat, refreshBlock:@escaping HXWRefreshBlock) {
        refreshHeader.headerHeight = refreshHeaderHeight
        if hxwHeader != refreshHeader {
            hxwHeader?.removeFromSuperview()
            refreshHeader.refreshBlock = refreshBlock
            refreshHeader.contentScrollview = self
            hxwHeader = refreshHeader
        }
    }
    
    //下拉刷新完成提示刷新成功或者失败
    /**
     * @param refreshHeaderHeight 下拉刷新高度，默认60
     * @param refreshedShowTime 刷新后提示刷新成功或者失败的时间，重写refreshed方法配合使用，默认为0
     * @param refreshedHeaderHeight 刷新后提示刷新成功或者失败时的高度，默认和refreshHeaderHeight一样
     */
    //delegate
    func hxw_addRefreshHeaderView(refreshHeader: HXWRefreshHeader, delegate:HXWRefreshHeaderDelegate, refreshHeaderHeight: CGFloat, refreshedShowTime: Double, refreshedHeaderHeight: CGFloat) {
        refreshHeader.headerHeight = refreshHeaderHeight
        refreshHeader.refreshedHeaderHeight = refreshedHeaderHeight
        refreshHeader.refreshedShowTime = refreshedShowTime
        if hxwHeader != refreshHeader {
            hxwHeader?.removeFromSuperview()
            refreshHeader.headerRefreshDelegate = delegate
            refreshHeader.contentScrollview = self
            hxwHeader = refreshHeader
        }
    }
    
    //block
    func hxw_addRefreshHeaderView(refreshHeader: HXWRefreshHeader, refreshHeaderHeight: CGFloat, refreshedShowTime: Double, refreshedHeaderHeight: CGFloat, refreshBlock:@escaping HXWRefreshBlock) {
        refreshHeader.headerHeight = refreshHeaderHeight
        refreshHeader.refreshedHeaderHeight = refreshedHeaderHeight
        refreshHeader.refreshedShowTime = refreshedShowTime
        if hxwHeader != refreshHeader {
            hxwHeader?.removeFromSuperview()
            refreshHeader.refreshBlock = refreshBlock
            refreshHeader.contentScrollview = self
            hxwHeader = refreshHeader
        }
    }
    
    //MARK: /**添加上拉加载**/
    /**
     * @param refreshFooterHeight 下拉刷新高度，默认50
     * @param isInstant true: 没有松开加载那个状态，上拉直接加载更多 false: 普通样式松开加载
     * @param isTail true: tableview的bottom要缩进一直显示footer，false: 普通样式上拉显示footer
     */
    //delegate
    func hxw_addRefreshFooterView(refreshFooter: HXWRefreshFooter, delegate:HXWRefreshFooterDelegate, refreshFooterHeight: CGFloat, isInstant: Bool, isTail: Bool) {
        refreshFooter.isInstant = isInstant
        refreshFooter.isTail = isTail
        refreshFooter.footerHeight = refreshFooterHeight
        if hxwFooter != refreshFooter {
            hxwFooter?.removeFromSuperview()
            refreshFooter.footerRefreshDelegate = delegate
            refreshFooter.contentScrollview = self
            hxwFooter = refreshFooter
        }
    }
    
    //block
    func hxw_addRefreshFooterView(refreshFooter: HXWRefreshFooter, refreshFooterHeight: CGFloat, isInstant: Bool, isTail: Bool, refreshBlock:@escaping HXWRefreshBlock) {
        refreshFooter.isInstant = isInstant
        refreshFooter.isTail = isTail
        refreshFooter.footerHeight = refreshFooterHeight
        if hxwFooter != refreshFooter {
            hxwFooter?.removeFromSuperview()
            refreshFooter.refreshBlock = refreshBlock
            refreshFooter.contentScrollview = self
            hxwFooter = refreshFooter
        }
    }

    //MARK: /**开始下拉刷新**/
    func startRefreshing() {
        hxwHeader?.startRefreshing()
    }

    //MARK: /**结束下拉刷新**/
    func endRefreshing(_ isSuccess: Bool) {
        hxwHeader?.endRefreshing(isSuccess)
    }
    
    //MARK: /**结束上拉加载**/
    func endLoadMore(_ isSuccess: Bool ,isNoMoreData: Bool) {
        hxwFooter?.endLoadMore(isSuccess, isNoMoreData: isNoMoreData)
    }
    
    //MARK: /**只有一页**/
    func noMore() {
        hxwFooter?.noMore()
    }
    
    //MARK: /**有多页**/
    func hasMore() {
        hxwFooter?.hasMore()
    }
    
}
