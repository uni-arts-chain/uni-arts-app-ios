import Foundation
import SoraKeystore
import SoraFoundation

class PinViewFactory: PinViewFactoryProtocol {
    static func createPinSetupView(navigationController: UINavigationController?) -> PinSetupViewProtocol? {
        let pinSetupView = PinSetupViewController()

        pinSetupView.mode = .create

        pinSetupView.title = "创建密码"

        let presenter = PinSetupPresenter()
        let interactor = PinSetupInteractor(secretManager: KeychainManager.shared,
                                            settingsManager: SettingsManager.shared,
                                            biometryAuth: BiometryAuth(),
                                            locale: LocalizationManager.shared.selectedLocale)
        let wireframe = PinSetupWireframe()

        pinSetupView.presenter = presenter
        presenter.view = pinSetupView
        presenter.interactor = interactor
        presenter.wireframe = wireframe
        presenter.navigationController = navigationController

        interactor.presenter = presenter

        pinSetupView.localizationManager = LocalizationManager.shared

        return pinSetupView
    }

    static func createPinChangeView() -> PinSetupViewProtocol? {
        let pinChangeView = PinSetupViewController()

        pinChangeView.mode = .create

        pinChangeView.title = "修改密码"

        let presenter = PinSetupPresenter()
        let interactor = PinChangeInteractor(secretManager: KeychainManager.shared)
        let wireframe = PinChangeWireframe(localizationManager: LocalizationManager.shared)

        pinChangeView.presenter = presenter
        presenter.view = pinChangeView
        presenter.interactor = interactor
        presenter.wireframe = wireframe

        interactor.presenter = presenter

        pinChangeView.localizationManager = LocalizationManager.shared

        return pinChangeView
    }

    static func createSecuredPinView() -> PinSetupViewProtocol? {
        let pinVerifyView = PinSetupViewController()

        pinVerifyView.mode = .securedInput

        let presenter = LocalAuthPresenter()
        let interactor = LocalAuthInteractor(secretManager: KeychainManager.shared,
                                             settingsManager: SettingsManager.shared,
                                             biometryAuth: BiometryAuth(),
                                             locale: LocalizationManager.shared.selectedLocale)
        let wireframe = PinSetupWireframe()

        pinVerifyView.presenter = presenter
        presenter.interactor = interactor
        presenter.view = pinVerifyView
        presenter.wireframe = wireframe

        interactor.presenter = presenter

        pinVerifyView.localizationManager = LocalizationManager.shared

        return pinVerifyView
    }

    static func createScreenAuthorizationView(with wireframe: ScreenAuthorizationWireframeProtocol, cancellable: Bool)
        -> PinSetupViewProtocol? {
        let pinVerifyView = PinSetupViewController()
        pinVerifyView.cancellable = cancellable

        pinVerifyView.mode = .securedInput

        let presenter = ScreenAuthorizationPresenter()
        let interactor = LocalAuthInteractor(secretManager: KeychainManager.shared,
                                             settingsManager: SettingsManager.shared,
                                             biometryAuth: BiometryAuth(),
                                             locale: LocalizationManager.shared.selectedLocale)

        pinVerifyView.presenter = presenter
        presenter.interactor = interactor
        presenter.view = pinVerifyView
        presenter.wireframe = wireframe

        interactor.presenter = presenter

        pinVerifyView.localizationManager = LocalizationManager.shared

        return pinVerifyView
    }
}
