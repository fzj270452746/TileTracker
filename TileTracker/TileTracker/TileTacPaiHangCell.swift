

import UIKit

class TileTacPaiHangCell: UITableViewCell {
    private var TileTacPaiMingBiao: UILabel!
    private var TileTacGuanKaBiao: UILabel!
    private var TileTacNanDuBiao: UILabel!
    private var TileTacFenShuBiao: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        TileTacChuangJianUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        TileTacChuangJianUI()
    }
    
    private func TileTacChuangJianUI() {
        backgroundColor = .clear
        selectionStyle = .none
        
        let beiJing = UIView()
        beiJing.backgroundColor = UIColor.systemIndigo.withAlphaComponent(0.3)
        beiJing.layer.cornerRadius = 15
        beiJing.layer.borderWidth = 2
        beiJing.layer.borderColor = UIColor.systemTeal.cgColor
        contentView.addSubview(beiJing)
        beiJing.translatesAutoresizingMaskIntoConstraints = false
        
        TileTacPaiMingBiao = UILabel()
        TileTacPaiMingBiao.font = UIFont.boldSystemFont(ofSize: 24)
        TileTacPaiMingBiao.textColor = .systemYellow
        contentView.addSubview(TileTacPaiMingBiao)
        TileTacPaiMingBiao.translatesAutoresizingMaskIntoConstraints = false
        
        TileTacGuanKaBiao = UILabel()
        TileTacGuanKaBiao.font = UIFont.systemFont(ofSize: 18)
        TileTacGuanKaBiao.textColor = .white
        contentView.addSubview(TileTacGuanKaBiao)
        TileTacGuanKaBiao.translatesAutoresizingMaskIntoConstraints = false
        
        TileTacNanDuBiao = UILabel()
        TileTacNanDuBiao.font = UIFont.systemFont(ofSize: 16)
        TileTacNanDuBiao.textColor = .systemGreen
        contentView.addSubview(TileTacNanDuBiao)
        TileTacNanDuBiao.translatesAutoresizingMaskIntoConstraints = false
        
        TileTacFenShuBiao = UILabel()
        TileTacFenShuBiao.font = UIFont.boldSystemFont(ofSize: 22)
        TileTacFenShuBiao.textColor = .systemOrange
        contentView.addSubview(TileTacFenShuBiao)
        TileTacFenShuBiao.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            beiJing.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            beiJing.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            beiJing.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            beiJing.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            TileTacPaiMingBiao.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            TileTacPaiMingBiao.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            TileTacPaiMingBiao.widthAnchor.constraint(equalToConstant: 50),
            
            TileTacGuanKaBiao.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            TileTacGuanKaBiao.leadingAnchor.constraint(equalTo: TileTacPaiMingBiao.trailingAnchor, constant: 20),
            
            TileTacNanDuBiao.topAnchor.constraint(equalTo: TileTacGuanKaBiao.bottomAnchor, constant: 5),
            TileTacNanDuBiao.leadingAnchor.constraint(equalTo: TileTacPaiMingBiao.trailingAnchor, constant: 20),
            
            TileTacFenShuBiao.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            TileTacFenShuBiao.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
    }
    
    func TileTacPeiZhi(xiang: TileTacPaiHangXiang, paiMing: Int) {
        TileTacPaiMingBiao.text = "\(paiMing)"
        TileTacGuanKaBiao.text = "关卡: \(xiang.guanKa + 1)"
        TileTacNanDuBiao.text = "难度: \(xiang.nanDu.rawValue)"
        TileTacFenShuBiao.text = "\(xiang.fenShu)"
    }
}
