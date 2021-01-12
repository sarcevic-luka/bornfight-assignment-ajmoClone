//
//  General.swift
//  AjmoClone
//
//  Created by Luka Šarčević on 12.01.2021..
//

import Foundation

typealias Action = () -> Void
typealias ParametrisedAction<T> = (T) -> Void

func onMainThread(action: Action?) {
  DispatchQueue.main.async { action?() }
}
