import UIKit
import SoraUI
import SoraFoundation
import FearlessUtils

final class AccountInfoViewController: UIViewController {
    private struct Constants {
        static let bottomContentHeight: CGFloat = 48
    }

    var presenter: AccountInfoPresenterProtocol!

    @IBOutlet private var bottomBarHeight: NSLayoutConstraint!
    @IBOutlet private var addActionControl: IconCellControlView!

    @IBOutlet private var usernameDetailsTextField: AnimatedTextField!

    @IBOutlet private var addressView: DetailsTriangularedView!

    @IBOutlet private var networkView: DetailsTriangularedView!

    @IBOutlet private var cryptoTypeView: DetailsTriangularedView!

    private var usernameViewModel: InputViewModelProtocol?

    private var hasChanges: Bool = false

    var iconGenerating: IconGenerating?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupAddressView()
        setupTextField()
        setupLocalization()
        setupNavigationItem()

        presenter.setup()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        presenter.finalizeUsername()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        bottomBarHeight.constant = Constants.bottomContentHeight + view.safeAreaInsets.bottom
    }

    private func setupAddressView() {
        addressView.addTarget(self, action: #selector(actionAddress), for: .touchUpInside)

        addressView.subtitleLabel?.lineBreakMode = .byTruncatingMiddle
    }

    private func setupTextField() {
        usernameDetailsTextField.textField.returnKeyType = .done
        usernameDetailsTextField.textField.textContentType = .nickname
        usernameDetailsTextField.textField.autocapitalizationType = .none
        usernameDetailsTextField.textField.autocorrectionType = .no
        usernameDetailsTextField.textField.spellCheckingType = .no

        usernameDetailsTextField.delegate = self
    }

    private func setupNavigationItem() {
        let closeBarItem = UIBarButtonItem(image: UIImage(named: "iconClose"),
                                                style: .plain,
                                                target: self,
                                                action: #selector(actionClose))

        navigationItem.leftBarButtonItem = closeBarItem
    }

    private func setupLocalization() {
        title = "Account"

        usernameDetailsTextField.title = "Name"

        addActionControl.imageWithTitleView?.title = "Export account"

        navigationItem.rightBarButtonItem?.title = "Save"

        addressView.title = "Address"

        cryptoTypeView.title = "Keypair crypto type"
    }

    @objc private func actionClose() {
        presenter.activateClose()
    }

    @IBAction private func textFieldDidChange(_ sender: UITextField) {
        hasChanges = true

        if usernameViewModel?.inputHandler.value != sender.text {
            sender.text = usernameViewModel?.inputHandler.value
        }
    }

    @IBAction private func actionExport() {
        presenter.activateExport()
    }

    @objc func actionAddress() {
        presenter.activateAddressAction()
    }
}

extension AccountInfoViewController: AnimatedTextFieldDelegate {
    func animatedTextField(_ textField: AnimatedTextField,
                           shouldChangeCharactersIn range: NSRange,
                           replacementString string: String) -> Bool {

        guard let viewModel = usernameViewModel else {
            return true
        }

        let shouldApply = viewModel.inputHandler.didReceiveReplacement(string, for: range)

        if !shouldApply, textField.text != viewModel.inputHandler.value {
            textField.text = viewModel.inputHandler.value
        }

        return shouldApply
    }

    func animatedTextFieldShouldReturn(_ textField: AnimatedTextField) -> Bool {
        textField.resignFirstResponder()

        return false
    }
}

extension AccountInfoViewController: AccountInfoViewProtocol {
    func set(usernameViewModel: InputViewModelProtocol) {
        usernameDetailsTextField.text = usernameViewModel.inputHandler.value
        self.usernameViewModel = usernameViewModel
    }

    func set(address: String) {
        addressView.subtitle = address

        addressView.iconImage = try? iconGenerating?
            .generateFromAddress(address)
            .imageWithFillColor(UIColor.white,
                                size: UIConstants.smallAddressIconSize,
                                contentScale: UIScreen.main.scale)
    }

    func set(networkType: Chain) {
        let locale = localizationManager?.selectedLocale ?? Locale.current

        networkView.title = networkType.titleForLocale(locale)
        networkView.iconImage = networkType.icon
    }

    func set(cryptoType: CryptoType) {
        let locale = localizationManager?.selectedLocale ?? Locale.current
        cryptoTypeView.subtitle = cryptoType.titleForLocale(locale) + " | " + cryptoType.subtitleForLocale(locale)
    }
}

extension AccountInfoViewController: Localizable {
    func applyLocalization() {
        if isViewLoaded {
            setupLocalization()
        }
    }
}
