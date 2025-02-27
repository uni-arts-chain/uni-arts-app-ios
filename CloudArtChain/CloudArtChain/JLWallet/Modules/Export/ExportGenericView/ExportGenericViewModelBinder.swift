import UIKit

final class ExportGenericViewModelBinder: ExportGenericViewModelBinding {
    let uiFactory: UIFactoryProtocol

    init(uiFactory: UIFactoryProtocol) {
        self.uiFactory = uiFactory
    }

    func bind(stringViewModel: ExportStringViewModel, locale: Locale) -> UIView {
        let detailsView = uiFactory.createDetailsView(with: .smallIconTitleSubtitle, filled: true)
        detailsView.translatesAutoresizingMaskIntoConstraints = false

        detailsView.heightAnchor
            .constraint(equalToConstant: UIConstants.triangularedViewHeight).isActive = true

        detailsView.subtitleLabel?.lineBreakMode = .byTruncatingMiddle
        detailsView.title = stringViewModel.option.titleForLocale(locale)
        detailsView.subtitle = stringViewModel.data

        return detailsView
    }

    func bind(multilineViewModel: ExportStringViewModel, locale: Locale) -> UIView {
        let detailsView = uiFactory.createMultilinedTriangularedView()

        detailsView.titleLabel.text = multilineViewModel.option.titleForLocale(locale)
        detailsView.subtitleLabel.text = multilineViewModel.data

        return detailsView
    }

    func bind(mnemonicViewModel: ExportMnemonicViewModel, locale: Locale) -> UIView {
//        let title = "Use non digital way to backup, such as writing the sequence of mnemonic words and derivation path (if set) down on paper."
//        let icon = UIImage(named: "iconAlert")
        let mnemonicView = uiFactory.createTitledMnemonicView(nil, icon: nil)
//        let mnemonicView = uiFactory.createTitledMnemonicView(title, icon: icon)
        mnemonicView.contentView.bind(words: mnemonicViewModel.mnemonic, columnsCount: 2)

        return mnemonicView
    }
}
