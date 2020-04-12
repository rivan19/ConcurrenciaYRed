//
//  UserDetailDataManager.swift
//  DiscourseClient
//
//  Created by Ivan Llopis Guardado on 12/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

protocol UserDetailDataManager: class {
    func fetchUser(userName: String, completion: @escaping (Result<SingleUserResponse?, Error>) -> ())
    func editUser(userName: String, name: String, completion: @escaping (Result<EditSingleUserResponse?, Error>) -> ())
}
