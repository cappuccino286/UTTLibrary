import UIKit
import SQLite
class BookDBHelper{
    init(name:String,photo: UIImage?) {
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory,in: .userDomainMask, appropriateFor:nil, create:true)
            let fileUrl = documentDirectory.appendingPathComponent("user").appendingPathExtension("sqlite3")
            let database = try Connection(fileUrl.path)
            self.database = database
        } catch {
            print(error)
        }
    }
}

