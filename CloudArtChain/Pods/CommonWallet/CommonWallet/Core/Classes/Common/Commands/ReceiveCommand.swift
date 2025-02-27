/**
 * Copyright Soramitsu Co., Ltd. All Rights Reserved.
 * SPDX-License-Identifier: GPL-3.0
 */

import Foundation

final class ReceiveCommand {
    let resolver: ResolverProtocol

    var presentationStyle: WalletPresentationStyle = .modal(inNavigation: true)
    var animated: Bool = true

    let selectedAssetId: String?

    init(resolver: ResolverProtocol, selectedAssetId: String? = nil) {
        self.resolver = resolver
        self.selectedAssetId = selectedAssetId
    }
}

extension ReceiveCommand: WalletPresentationCommandProtocol {
    func execute() throws {
        let eligibleAssets = resolver.account.assets.filter { $0.modes.contains(.transfer) }

        guard let assetId = selectedAssetId ?? eligibleAssets.first?.identifier else {
            throw CommandError.noAssets
        }

        guard let asset = resolver.account.asset(for: assetId) else {
            throw CommandError.invalidAssetId
        }

        guard asset.modes.contains(.transfer) else {
            throw CommandError.notEligibleAsset
        }

        guard
            let contactsView = ReceiveAmountAssembly.assembleView(resolver: resolver, selectedAsset: asset),
            let navigation = resolver.navigation else {
            return
        }

        present(view: contactsView.controller, in: navigation, animated: animated)
    }
    
    func getModelsExecute(contactBlock: (ContactListViewModelProtocol, WalletAsset, ContactsPresenter) -> Void) throws {
        
    }
    
    func confirmTransaction() -> WalletNewFormViewController? {
        return nil
    }
}
