//
//  ProjectCategory.swift
//  ProjectManager
//
//  Created by Minseong on 2022/07/13.
//

enum ProjectCategory: String, CaseIterable {
  case TODO
  case DOING
  case DONE

  var moveCategoryMenu: [ProjectCategory] {
    Self.allCases.filter { $0 != self }
  }
}
