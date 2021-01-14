//
//  StartupProcess.swift
//  AjmoClone
//
//  Created by Luka Šarčević on 14.01.2021..
//

import Foundation

/// An abstraction for a predefined set of functionality, aimed to be ran once, at app startup.
public protocol StartupProcess {
  func run(completion: @escaping (Bool) -> Void)
}
