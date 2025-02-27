/**
 * Copyright Soramitsu Co., Ltd. All Rights Reserved.
 * SPDX-License-Identifier: GPL-3.0
 */

import Foundation

final class ScanReceiverCommand {
    let resolver: ResolverProtocol

    var presentationStyle: WalletPresentationStyle = .push(hidesBottomBar: true)
    var animated: Bool = true

    init(resolver: ResolverProtocol) {
        self.resolver = resolver
    }
}

extension ScanReceiverCommand: WalletPresentationCommandProtocol {
    func execute() throws {

        guard !resolver.account.assets.filter({ $0.modes.contains(.transfer) }).isEmpty else {
            throw CommandError.noAssets
        }

        guard
            let scanView = InvoiceScanAssembly.assembleView(with: resolver),
            let navigation = resolver.navigation else {
            return
        }

        present(view: scanView.controller, in: navigation, animated: animated)
    }
    
    func getModelsExecute(contactBlock: (ContactListViewModelProtocol, WalletAsset, ContactsPresenter) -> Void) throws {
        
    }
    
    func confirmTransaction() -> WalletNewFormViewController? {
        return nil
    }
}
