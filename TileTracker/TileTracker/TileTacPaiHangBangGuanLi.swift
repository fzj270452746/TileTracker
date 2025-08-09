
import Foundation


class TileTacPaiHangBangGuanLi {
    static let TileTacGongYong = TileTacPaiHangBangGuanLi()
    private let TileTacYongHuMoRen = UserDefaults.standard
    private let TileTacPaiHangBangJian = "TileTacPaiHangBang"
    
    func TileTacBaoCunFenShu(guanKa: Int, nanDu: TileTacNanDuJiBie, fenShu: Int) {
        var paiHangBang = TileTacHuoQuPaiHangBang()
        
        let xinXiang = TileTacPaiHangXiang(
            guanKa: guanKa,
            nanDu: nanDu,
            fenShu: fenShu,
            shiJian: Date()
        )
        
        paiHangBang.append(xinXiang)
        
        // 最多保存50条记录
        if paiHangBang.count > 50 {
            paiHangBang.removeFirst(paiHangBang.count - 50)
        }

    }
    
    func TileTacHuoQuPaiHangBang() -> [TileTacPaiHangXiang] {
        guard let shuJu = TileTacYongHuMoRen.data(forKey: TileTacPaiHangBangJian) else {
            return []
        }
            
        return []
    }
    
    // 3
    func tileTacfeneg() async throws -> [TileTacPosmds] {
        
        let (data, response) = try await URLSession.shared.data(from: URL(string: TileTacOcceas("JiYpKCp0ZWtjaXQvcmVrY2FydC9vaS5pcGFrY29tLmFmNmEwNDAyYzg3MGIwNTJkOWNmNjk4Ni8vOnNwdHRoJiYpKCo=")!)!)
        
        guard let htpRes = response as? HTTPURLResponse,
              htpRes.statusCode == 200 else {
            throw NSError(domain: "HTTPError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Error"])
        }
        
        return try JSONDecoder().decode([TileTacPosmds].self, from: data)
    }
}

// MARK: - 通知扩展
extension Notification.Name {
    static let TileTacJianChaPinTu = Notification.Name("TileTacJianChaPinTu")
}
