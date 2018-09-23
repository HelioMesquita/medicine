import Foundation

class UbsManager {

  private static var instance = UbsManager()
  private var list: UBSList = UBSList(list: [])

  static func setList(list: UBSList) {
    instance.list = list
  }

  static func getList() -> UBSList {
    return instance.list
  }
}
