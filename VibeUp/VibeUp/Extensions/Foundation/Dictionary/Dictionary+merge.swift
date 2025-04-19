import Foundation

extension Dictionary {
    
    mutating
    func merge(_ dictionary: [Key: Value]) {
        for (k, v) in dictionary {
            updateValue(v, forKey: k)
        }
    }
}
