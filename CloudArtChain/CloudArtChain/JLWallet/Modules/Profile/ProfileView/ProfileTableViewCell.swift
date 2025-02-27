import UIKit
import SoraUI

final class ProfileTableViewCell: UITableViewCell {

    @IBOutlet private var iconImageView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var subtitleLabel: UILabel!

    private(set) var viewModel: ProfileOptionViewModelProtocol?

    override func awakeFromNib() {
        super.awakeFromNib()

        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = UIColor(red: 0.0, green: 0.298, blue: 0.718, alpha: 0.3)
        self.selectedBackgroundView = selectedBackgroundView
    }

    func bind(viewModel: ProfileOptionViewModelProtocol) {
        self.viewModel = viewModel

        iconImageView.image = viewModel.icon
        titleLabel.text = viewModel.title

        subtitleLabel.text = viewModel.accessoryTitle
    }
}
