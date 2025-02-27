import Foundation
import CommonWallet
import SoraFoundation
import FearlessUtils

final class TransactionDetailsViewModelFactory {
    let address: String
    let amountFormatterFactory: NumberFormatterFactoryProtocol
    let dateFormatter: LocalizableResource<DateFormatter>
    let assets: [WalletAsset]

    let iconGenerator: PolkadotIconGenerator = PolkadotIconGenerator()

    init(address: String,
         assets: [WalletAsset],
         dateFormatter: LocalizableResource<DateFormatter>,
         amountFormatterFactory: NumberFormatterFactoryProtocol) {
        self.address = address
        self.assets = assets
        self.dateFormatter = dateFormatter
        self.amountFormatterFactory = amountFormatterFactory
    }

    private func populateStatus(into viewModelList: inout [WalletFormViewBindingProtocol],
                                data: AssetTransactionData,
                                locale: Locale) {
        let viewModel: WalletNewFormDetailsViewModel

        let title = "Status"

        switch data.status {
        case .commited:
            let details = "Completed"
            viewModel = WalletNewFormDetailsViewModel(title: title,
                                                      titleIcon: nil,
                                                      details: details,
                                                      detailsIcon: UIImage(named: "iconValid"))
        case .pending:
            let details = "Pending"
            viewModel = WalletNewFormDetailsViewModel(title: title,
                                                      titleIcon: nil,
                                                      details: details,
                                                      detailsIcon: UIImage(named: "iconTxPending"))
        case .rejected:
            let details = "Failed"
            viewModel = WalletNewFormDetailsViewModel(title: title,
                                                      titleIcon: nil,
                                                      details: details,
                                                      detailsIcon: UIImage(named: "iconInvalid"))
        }

        let separator = WalletFormSeparatedViewModel(content: viewModel, borderType: [.bottom])
        viewModelList.append(separator)
    }

    private func populateTime(into viewModelList: inout [WalletFormViewBindingProtocol],
                              data: AssetTransactionData,
                              locale: Locale) {
        let transactionDate = Date(timeIntervalSince1970: TimeInterval(data.timestamp))

        let timeDetails = dateFormatter.value(for: locale).string(from: transactionDate)

        let title = "Date"
        let viewModel = WalletNewFormDetailsViewModel(title: title,
                                                      titleIcon: nil,
                                                      details: timeDetails,
                                                      detailsIcon: nil)

        let separator = WalletFormSeparatedViewModel(content: viewModel, borderType: [.bottom])
        viewModelList.append(separator)
    }

    private func populateAmount(into viewModelList: inout [WalletFormViewBindingProtocol],
                                data: AssetTransactionData,
                                locale: Locale) {
        guard let asset = assets.first(where: { $0.identifier == data.assetId }) else {
            return
        }

        let amount = data.amount.decimalValue

        let formatter = amountFormatterFactory.createTokenFormatter(for: asset)

        guard let displayAmount = formatter.value(for: locale).string(from: amount) else {
            return
        }

        let title = "Amount"
        let viewModel = WalletNewFormDetailsViewModel(title: title,
                                                      titleIcon: nil,
                                                      details: displayAmount,
                                                      detailsIcon: nil)

        let separator = WalletFormSeparatedViewModel(content: viewModel, borderType: [.bottom])
        viewModelList.append(separator)
    }

    private func populateFeeAmount(in viewModelList: inout [WalletFormViewBindingProtocol],
                                   data: AssetTransactionData,
                                   locale: Locale) {
        let asset = assets.first(where: { $0.identifier == data.assetId })

        let formatter = amountFormatterFactory.createTokenFormatter(for: asset).value(for: locale)

        for fee in data.fees where fee.assetId == data.assetId {

            guard let amount = formatter.string(from: fee.amount.decimalValue) else {
                continue
            }

            let title = "Transfer fee"

            let viewModel = WalletNewFormDetailsViewModel(title: title,
                                                          titleIcon: nil,
                                                          details: amount,
                                                          detailsIcon: nil)

            let separator = WalletFormSeparatedViewModel(content: viewModel, borderType: [.bottom])
            viewModelList.append(separator)
        }
    }

    private func populateTransactionId(in viewModelList: inout [WalletFormViewBindingProtocol],
                                       data: AssetTransactionData,
                                       chain: Chain,
                                       commandFactory: WalletCommandFactoryProtocol,
                                       locale: Locale) {
        let title = "Extrinsic Hash"

        let actionIcon = UIImage(named: "iconMore")

        let command = WalletExtrinsicOpenCommand(extrinsicHash: data.transactionId,
                                                 chain: chain,
                                                 commandFactory: commandFactory,
                                                 locale: locale)

        let viewModel = WalletCompoundDetailsViewModel(title: title,
                                                       details: data.transactionId,
                                                       mainIcon: nil,
                                                       actionIcon: actionIcon,
                                                       command: command,
                                                       enabled: true)
        viewModelList.append(viewModel)
    }

    private func populateSender(in viewModelList: inout [WalletFormViewBindingProtocol],
                                address: String,
                                chain: Chain,
                                commandFactory: WalletCommandFactoryProtocol,
                                locale: Locale) {
        let title = "From"
        populatePeerViewModel(in: &viewModelList,
                              title: title,
                              address: address,
                              chain: chain,
                              commandFactory: commandFactory,
                              locale: locale)
    }

    private func populateReceiver(in viewModelList: inout [WalletFormViewBindingProtocol],
                                  address: String,
                                  chain: Chain,
                                  commandFactory: WalletCommandFactoryProtocol,
                                  locale: Locale) {
        let title = "To"
        populatePeerViewModel(in: &viewModelList,
                              title: title,
                              address: address,
                              chain: chain,
                              commandFactory: commandFactory,
                              locale: locale)
    }

    private func populatePeerViewModel(in viewModelList: inout [WalletFormViewBindingProtocol],
                                       title: String,
                                       address: String,
                                       chain: Chain,
                                       commandFactory: WalletCommandFactoryProtocol,
                                       locale: Locale) {
        let icon: UIImage? = try? iconGenerator.generateFromAddress(address)
            .imageWithFillColor(UIColor.white,
                                size: UIConstants.smallAddressIconSize,
                                contentScale: UIScreen.main.scale)

        let actionIcon = UIImage(named: "iconMore")

        let command = WalletAccountOpenCommand(address: address,
                                               chain: chain,
                                               commandFactory: commandFactory,
                                               locale: locale)

        let viewModel = WalletCompoundDetailsViewModel(title: title,
                                                       details: address,
                                                       mainIcon: icon,
                                                       actionIcon: actionIcon,
                                                       command: command,
                                                       enabled: true)
        viewModelList.append(viewModel)
    }
}

extension TransactionDetailsViewModelFactory: WalletTransactionDetailsFactoryOverriding {
    func createViewModelsFromTransaction(data: AssetTransactionData,
                                         commandFactory: WalletCommandFactoryProtocol,
                                         locale: Locale) -> [WalletFormViewBindingProtocol]? {
        guard let chain = WalletAssetId(rawValue: data.assetId)?.chain else {
            return nil
        }

        var viewModels: [WalletFormViewBindingProtocol] = []

        populateStatus(into: &viewModels, data: data, locale: locale)
        populateTime(into: &viewModels, data: data, locale: locale)
        populateAmount(into: &viewModels, data: data, locale: locale)
        populateFeeAmount(in: &viewModels, data: data, locale: locale)
        populateTransactionId(in: &viewModels,
                              data: data,
                              chain: chain,
                              commandFactory: commandFactory,
                              locale: locale)

        guard let type = TransactionType(rawValue: data.type), let peerAddress = data.peerName else {
            return viewModels
        }

        if type == .incoming {
            populateSender(in: &viewModels,
                           address: peerAddress,
                           chain: chain,
                           commandFactory: commandFactory,
                           locale: locale)
            populateReceiver(in: &viewModels,
                             address: address,
                             chain: chain,
                             commandFactory: commandFactory,
                             locale: locale)
        } else {
            populateSender(in: &viewModels,
                           address: address,
                           chain: chain,
                           commandFactory: commandFactory,
                           locale: locale)
            populateReceiver(in: &viewModels,
                             address: peerAddress,
                             chain: chain,
                             commandFactory: commandFactory,
                             locale: locale)
        }

        return viewModels
    }

    func createAccessoryViewModelFromTransaction(data: AssetTransactionData,
                                                 commandFactory: WalletCommandFactoryProtocol,
                                                 locale: Locale) -> AccessoryViewModelProtocol? {
        guard let asset = assets.first(where: { $0.identifier == data.assetId }) else {
            return nil
        }

        let title = "Total"

        var decimalAmount = data.amount.decimalValue

        for fee in data.fees {
            decimalAmount += fee.amount.decimalValue
        }

        let formatter = amountFormatterFactory.createTokenFormatter(for: asset)

        guard let amount = formatter.value(for: locale).string(from: decimalAmount) else {
            return nil
        }

        let icon: UIImage?

        if let address = data.peerName {
            icon = try? iconGenerator.generateFromAddress(address)
                .imageWithFillColor(UIColor.white,
                                    size: CGSize(width: 32.0, height: 32.0),
                                    contentScale: UIScreen.main.scale)
        } else {
            icon = nil
        }

        let receiverInfo = ReceiveInfo(accountId: data.peerId,
                                       assetId: asset.identifier,
                                       amount: nil,
                                       details: nil)

        let transferPayload = TransferPayload(receiveInfo: receiverInfo,
                                              receiverName: data.peerName ?? "")
        let command = commandFactory.prepareTransfer(with: transferPayload)
        command.presentationStyle = .push(hidesBottomBar: true)

        return TransactionDetailsAccessoryViewModel(title: title,
                                                    amount: amount,
                                                    action: data.peerName ?? "",
                                                    icon: icon,
                                                    command: command)
    }
}
