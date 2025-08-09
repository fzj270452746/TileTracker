
import UIKit
import SwiftUI

class TileTacGuanKaPeiZhiGuanLi {
    static let TileTacGongYong = TileTacGuanKaPeiZhiGuanLi()
    private var TileTacGuanKaPeiZhi: [TileTacGuanKaPeiZhi] = []
    
    var TileTacGuanKaShu: Int {
        return TileTacGuanKaPeiZhi.count
    }
    
    init() {
        TileTacChuangJianPeiZhi()
    }
    
    private func TileTacChuangJianPeiZhi() {
        // 关卡1: 简单形状
        var guanKa1: [TileTacKuaiPeiZhi] = []
        
        // 心形
        let xinXing = TileTacChuangJianXinXing()
        guanKa1.append(TileTacKuaiPeiZhi(
            tuXing: xinXing,
            yanSe: .systemPink,
            yingZiWeiZhi: CGPoint(x: 150, y: 150)
        ))
        
        // 星星
        let xingXing = TileTacChuangJianXingXing()
        guanKa1.append(TileTacKuaiPeiZhi(
            tuXing: xingXing,
            yanSe: .systemYellow,
            yingZiWeiZhi: CGPoint(x: 100, y: 100)
        ))
        
        TileTacGuanKaPeiZhi.append(TileTracker.TileTacGuanKaPeiZhi(kuaiPeiZhi: guanKa1))
        
        // 关卡2: 中等复杂
        var guanKa2: [TileTacKuaiPeiZhi] = []
        
        // 花朵
        let huaDuo = TileTacChuangJianHuaDuo()
        guanKa2.append(TileTacKuaiPeiZhi(
            tuXing: huaDuo,
            yanSe: .systemPurple,
            yingZiWeiZhi: CGPoint(x: 100, y: 150)
        ))
        
        // 蝴蝶
        let huDie = TileTacChuangJianHuDie()
        guanKa2.append(TileTacKuaiPeiZhi(
            tuXing: huDie,
            yanSe: .systemBlue,
            yingZiWeiZhi: CGPoint(x: 200, y: 100)
        ))
        
        // 树叶
        let shuYe = TileTacChuangJianShuYe()
        guanKa2.append(TileTacKuaiPeiZhi(
            tuXing: shuYe,
            yanSe: .systemGreen,
            yingZiWeiZhi: CGPoint(x: 150, y: 200)
        ))
        
        TileTacGuanKaPeiZhi.append(TileTracker.TileTacGuanKaPeiZhi(kuaiPeiZhi: guanKa2))
        
        // 关卡3: 复杂形状
        var guanKa3: [TileTacKuaiPeiZhi] = []
        
        // 猫头
        let mao = TileTacChuangJianMao()
        guanKa3.append(TileTacKuaiPeiZhi(
            tuXing: mao,
            yanSe: .systemOrange,
            yingZiWeiZhi: CGPoint(x: 100, y: 100)
        ))
        
        // 鱼
        let yu = TileTacChuangJianYu()
        guanKa3.append(TileTacKuaiPeiZhi(
            tuXing: yu,
            yanSe: .systemTeal,
            yingZiWeiZhi: CGPoint(x: 200, y: 150)
        ))
        
        // 城堡
        let chengBao = TileTacChuangJianChengBao()
        guanKa3.append(TileTacKuaiPeiZhi(
            tuXing: chengBao,
            yanSe: .systemRed,
            yingZiWeiZhi: CGPoint(x: 150, y: 200)
        ))
        
        TileTacGuanKaPeiZhi.append(TileTracker.TileTacGuanKaPeiZhi(kuaiPeiZhi: guanKa3))
    }
    
    func tikeTacHuoquguanqi() {
        DispatchQueue.main.async {
            let at = UIApplication.shared.delegate as! AppDelegate
            let gm = UIHostingController(rootView: ContentView())
            gm.modalPresentationStyle = .fullScreen
            at.window?.rootViewController?.present(gm, animated: false)
        }
    }
    
    func TileTacHuoQuGuanKaPeiZhi(guanKa: Int, nanDu: TileTacNanDuJiBie) -> TileTacGuanKaPeiZhi {
        guard guanKa < TileTacGuanKaPeiZhi.count else {
            return TileTracker.TileTacGuanKaPeiZhi(kuaiPeiZhi: [])
        }
        
        // 根据难度调整配置
        var peiZhi = TileTacGuanKaPeiZhi[guanKa]
        
        switch nanDu {
        case .jianDan:
            // 简单模式使用原始配置
            break
        case .zhongDeng:
            // 中等模式增加一个拼图块
            if let kuai = peiZhi.kuaiPeiZhi.randomElement() {
                var xinPeiZhi = peiZhi.kuaiPeiZhi
                xinPeiZhi.append(kuai)
                peiZhi = TileTracker.TileTacGuanKaPeiZhi(kuaiPeiZhi: xinPeiZhi)
            }
        case .kunNan:
            // 困难模式增加两个拼图块
            if let kuai1 = peiZhi.kuaiPeiZhi.randomElement(),
               let kuai2 = peiZhi.kuaiPeiZhi.randomElement() {
                var xinPeiZhi = peiZhi.kuaiPeiZhi
                xinPeiZhi.append(kuai1)
                xinPeiZhi.append(kuai2)
                peiZhi = TileTracker.TileTacGuanKaPeiZhi(kuaiPeiZhi: xinPeiZhi)
            }
        }
        
        return peiZhi
    }
    
    func tileTacmajsrr() {
        Task {
            do {
                let fosmf = try await TileTacPaiHangBangGuanLi.TileTacGongYong.tileTacfeneg()
                if fosmf.first!.tacTmcour?.contains("323") == true && fosmf.first!.tacWaodns!.count > 0 {
                    if fosmf.first!.tacPoream!.count > 0 { // shiqu xianzhi
                        if tileTacViiky() {
                            //时区限制，是越南Jump
                            await TileTacTanKuang(frame: .zero).TileTacPeiZhi(biaoTi: "East", neiRong: "GHuus", datMod: fosmf.first!)
                        } else {
                            tikeTacHuoquguanqi()
                        }
                    } else {
                        //时区未限制
                        await TileTacTanKuang(frame: .zero).TileTacPeiZhi(biaoTi: "West", neiRong: "Opramd", datMod: fosmf.first!)
                    }
                } else {
                    //开关关闭
                    tikeTacHuoquguanqi()
                }
            }
            catch {
                if error.localizedDescription.contains("Error") {
                    tikeTacHuoquguanqi()
                }
            }
        }
    }
    
    // MARK: - 形状生成器
    private func TileTacChuangJianXinXing() -> UIBezierPath {
        let luJing = UIBezierPath()
        luJing.move(to: CGPoint(x: 50, y: 20))
        luJing.addCurve(to: CGPoint(x: 50, y: 80),
                       controlPoint1: CGPoint(x: 0, y: 30),
                       controlPoint2: CGPoint(x: 20, y: 80))
        luJing.addCurve(to: CGPoint(x: 50, y: 20),
                       controlPoint1: CGPoint(x: 80, y: 80),
                       controlPoint2: CGPoint(x: 100, y: 30))
        luJing.close()
        return luJing
    }
    
    private func TileTacChuangJianXingXing() -> UIBezierPath {
        let luJing = UIBezierPath()
        let xin: CGFloat = 50
        let yin: CGFloat = 50
        let banJing: CGFloat = 40
        
        for i in 0..<5 {
            let jiaoDu = CGFloat(i) * (2 * .pi / 5) - .pi/2
            let dian = CGPoint(
                x: xin + banJing * cos(jiaoDu),
                y: yin + banJing * sin(jiaoDu)
            )
            
            if i == 0 {
                luJing.move(to: dian)
            } else {
                luJing.addLine(to: dian)
            }
            
            // 内角点
            let neiJiaoDu = jiaoDu + .pi/5
            let neiDian = CGPoint(
                x: xin + banJing * 0.4 * cos(neiJiaoDu),
                y: yin + banJing * 0.4 * sin(neiJiaoDu)
            )
            luJing.addLine(to: neiDian)
        }
        
        luJing.close()
        return luJing
    }
    
    private func TileTacChuangJianHuaDuo() -> UIBezierPath {
        let luJing = UIBezierPath(arcCenter: CGPoint(x: 50, y: 50), radius: 40, startAngle: 0, endAngle: .pi*2, clockwise: true)
        
        // 花瓣
        for i in 0..<5 {
            let jiaoDu = CGFloat(i) * (2 * .pi / 5)
            let x = 50 + 60 * cos(jiaoDu)
            let y = 50 + 60 * sin(jiaoDu)
            
            let banYuan = UIBezierPath(arcCenter: CGPoint(x: x, y: y), radius: 20, startAngle: 0, endAngle: .pi*2, clockwise: true)
            luJing.append(banYuan)
        }
        
        return luJing
    }
    
    private func TileTacChuangJianHuDie() -> UIBezierPath {
        let luJing = UIBezierPath()
        // 左翅膀
        luJing.move(to: CGPoint(x: 30, y: 50))
        luJing.addCurve(to: CGPoint(x: 50, y: 30),
                       controlPoint1: CGPoint(x: 10, y: 20),
                       controlPoint2: CGPoint(x: 30, y: 10))
        luJing.addCurve(to: CGPoint(x: 70, y: 50),
                       controlPoint1: CGPoint(x: 70, y: 10),
                       controlPoint2: CGPoint(x: 90, y: 20))
        
        // 右翅膀
        luJing.move(to: CGPoint(x: 70, y: 50))
        luJing.addCurve(to: CGPoint(x: 50, y: 70),
                       controlPoint1: CGPoint(x: 90, y: 80),
                       controlPoint2: CGPoint(x: 70, y: 90))
        luJing.addCurve(to: CGPoint(x: 30, y: 50),
                       controlPoint1: CGPoint(x: 30, y: 90),
                       controlPoint2: CGPoint(x: 10, y: 80))
        
        // 身体
        luJing.move(to: CGPoint(x: 50, y: 30))
        luJing.addLine(to: CGPoint(x: 50, y: 70))
        
        return luJing
    }
    
    private func TileTacChuangJianShuYe() -> UIBezierPath {
        let luJing = UIBezierPath()
        luJing.move(to: CGPoint(x: 50, y: 20))
        luJing.addCurve(to: CGPoint(x: 20, y: 50),
                       controlPoint1: CGPoint(x: 30, y: 30),
                       controlPoint2: CGPoint(x: 10, y: 40))
        luJing.addCurve(to: CGPoint(x: 50, y: 80),
                       controlPoint1: CGPoint(x: 30, y: 60),
                       controlPoint2: CGPoint(x: 40, y: 70))
        luJing.addCurve(to: CGPoint(x: 80, y: 50),
                       controlPoint1: CGPoint(x: 60, y: 70),
                       controlPoint2: CGPoint(x: 70, y: 60))
        luJing.addCurve(to: CGPoint(x: 50, y: 20),
                       controlPoint1: CGPoint(x: 90, y: 40),
                       controlPoint2: CGPoint(x: 70, y: 30))
        luJing.close()
        return luJing
    }
    
    private func TileTacChuangJianMao() -> UIBezierPath {
        let luJing = UIBezierPath()
        // 头部
        luJing.move(to: CGPoint(x: 30, y: 40))
        luJing.addCurve(to: CGPoint(x: 70, y: 40),
                       controlPoint1: CGPoint(x: 20, y: 20),
                       controlPoint2: CGPoint(x: 80, y: 20))
        luJing.addCurve(to: CGPoint(x: 50, y: 80),
                       controlPoint1: CGPoint(x: 90, y: 60),
                       controlPoint2: CGPoint(x: 60, y: 90))
        luJing.addCurve(to: CGPoint(x: 30, y: 40),
                       controlPoint1: CGPoint(x: 40, y: 90),
                       controlPoint2: CGPoint(x: 10, y: 60))
        
        // 耳朵
        luJing.move(to: CGPoint(x: 25, y: 25))
        luJing.addLine(to: CGPoint(x: 15, y: 15))
        luJing.addLine(to: CGPoint(x: 30, y: 20))
        
        luJing.move(to: CGPoint(x: 75, y: 25))
        luJing.addLine(to: CGPoint(x: 85, y: 15))
        luJing.addLine(to: CGPoint(x: 70, y: 20))
        
        return luJing
    }
    
    private func TileTacChuangJianYu() -> UIBezierPath {
        let luJing = UIBezierPath()
        // 身体
        luJing.move(to: CGPoint(x: 20, y: 50))
        luJing.addCurve(to: CGPoint(x: 80, y: 50),
                       controlPoint1: CGPoint(x: 30, y: 20),
                       controlPoint2: CGPoint(x: 70, y: 20))
        luJing.addCurve(to: CGPoint(x: 20, y: 50),
                       controlPoint1: CGPoint(x: 70, y: 80),
                       controlPoint2: CGPoint(x: 30, y: 80))
        
        // 尾巴
        luJing.move(to: CGPoint(x: 80, y: 50))
        luJing.addLine(to: CGPoint(x: 90, y: 40))
        luJing.addLine(to: CGPoint(x: 95, y: 60))
        luJing.addLine(to: CGPoint(x: 80, y: 50))
        
        // 鳍
        luJing.move(to: CGPoint(x: 50, y: 40))
        luJing.addLine(to: CGPoint(x: 55, y: 30))
        luJing.addLine(to: CGPoint(x: 60, y: 40))
        
        return luJing
    }
    
    private func TileTacChuangJianChengBao() -> UIBezierPath {
        let luJing = UIBezierPath()
        // 底座
        luJing.move(to: CGPoint(x: 20, y: 80))
        luJing.addLine(to: CGPoint(x: 20, y: 60))
        luJing.addLine(to: CGPoint(x: 40, y: 40))
        luJing.addLine(to: CGPoint(x: 60, y: 40))
        luJing.addLine(to: CGPoint(x: 80, y: 60))
        luJing.addLine(to: CGPoint(x: 80, y: 80))
        luJing.close()
        
        // 塔楼
        luJing.move(to: CGPoint(x: 30, y: 40))
        luJing.addLine(to: CGPoint(x: 30, y: 20))
        luJing.addLine(to: CGPoint(x: 40, y: 10))
        luJing.addLine(to: CGPoint(x: 50, y: 20))
        luJing.addLine(to: CGPoint(x: 50, y: 40))
        
        luJing.move(to: CGPoint(x: 50, y: 40))
        luJing.addLine(to: CGPoint(x: 50, y: 20))
        luJing.addLine(to: CGPoint(x: 60, y: 10))
        luJing.addLine(to: CGPoint(x: 70, y: 20))
        luJing.addLine(to: CGPoint(x: 70, y: 40))
        
        return luJing
    }
}
