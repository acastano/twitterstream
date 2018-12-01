import Foundation

extension String {
    func cccMMMddYYYY() -> String? {
        var dateString: String?
        if let time = Double(self) {
            let date = Date(timeIntervalSince1970: time / 1000)
            let df = String.dateFormatter("ccc MMM dd YYYY")
            dateString = df.string(from: date)
        }
        return dateString
    }
    
    func urlEncodedStringWithEncoding() -> String? {
		let allowedCharacterSet = (CharacterSet.urlQueryAllowed as NSCharacterSet).mutableCopy() as! NSMutableCharacterSet
        allowedCharacterSet.removeCharacters(in: "\n:#/?@!$&'()*+,;=")
        allowedCharacterSet.addCharacters(in: "[]")
        return addingPercentEncoding(withAllowedCharacters: allowedCharacterSet as CharacterSet)
    }
    
    func hmac(_ key: String) -> Data? {
        var data: Data?
        if let str = cString(using: String.Encoding.utf8), let keyStr = key.cString(using: String.Encoding.utf8) {
            let strLen = lengthOfBytes(using: String.Encoding.utf8)
            let digestLen = Int(CC_SHA1_DIGEST_LENGTH)
            let result = UnsafeMutableRawPointer.allocate(byteCount: digestLen, alignment: 0)
            let keyLen = key.lengthOfBytes(using: String.Encoding.utf8)
            
            CCHmac(CCHmacAlgorithm(kCCHmacAlgSHA1), keyStr, keyLen, str, strLen, result)
            data = Data(bytes: result, count: digestLen)
        }
        return data
    }
    
    private static func dateFormatter(_ format:String) -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier:"en")
        return dateFormatter
    }
}
