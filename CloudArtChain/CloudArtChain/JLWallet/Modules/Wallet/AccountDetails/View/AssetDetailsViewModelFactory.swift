import Foundation
import CommonWallet

final class AssetDetailsViewModelFactory: BaseAssetViewModelFactory {
    let amountFormatterFactory: NumberFormatterFactoryProtocol
    let priceAsset: WalletAsset

    init(address: String,
         chain: Chain,
         purchaseProvider: PurchaseProviderProtocol,
         amountFormatterFactory: NumberFormatterFactoryProtocol,
         priceAsset: WalletAsset) {
        self.amountFormatterFactory = amountFormatterFactory
        self.priceAsset = priceAsset

        super.init(address: address, chain: chain, purchaseProvider: purchaseProvider)
    }

    override func createAssetViewModel(for asset: WalletAsset,
                              balance: BalanceData,
                              commandFactory: WalletCommandFactoryProtocol,
                              locale: Locale) -> WalletViewModelProtocol? {
        let amountFormatter = amountFormatterFactory.createTokenFormatter(for: asset)
            .value(for: locale)

        let priceFormater = amountFormatterFactory.createTokenFormatter(for: priceAsset)
            .value(for: locale)

        let decimalBalance = balance.balance.decimalValue
        let amount: String

        if let balanceString = amountFormatter.string(from: decimalBalance) {
            amount = balanceString
        } else {
            amount = balance.balance.stringValue
        }

        let balanceContext = BalanceContext(context: balance.context ?? [:])

        let priceString = priceFormater.string(from: balanceContext.price) ?? ""

        let totalPrice = balanceContext.price * balance.balance.decimalValue
        let totalPriceString = priceFormater.string(from: totalPrice) ?? ""

        let priceChangeString = NumberFormatter.percent
            .localizableResource()
            .value(for: locale)
            .string(from: balanceContext.priceChange as NSNumber) ?? ""

        let priceChangeViewModel = balanceContext.priceChange >= 0.0 ?
            WalletPriceChangeViewModel.goingUp(displayValue: priceChangeString) :
            WalletPriceChangeViewModel.goingDown(displayValue: priceChangeString)

        let context = BalanceContext(context: balance.context ?? [:])

        let numberFormatter = amountFormatterFactory.createDisplayFormatter(for: asset)

        let leftTitle = "Available"

        let rightTitle = "Frozen"

        let leftDetails = numberFormatter
            .value(for: locale)
            .string(from: context.available as NSNumber) ?? ""

        let rightDetails = numberFormatter
            .value(for: locale)
            .string(from: context.frozen as NSNumber) ?? ""

        let imageViewModel: WalletImageViewModelProtocol?

        if let assetId = WalletAssetId(rawValue: asset.identifier), let icon = assetId.assetIcon {
            imageViewModel = WalletStaticImageViewModel(staticImage: icon)
        } else {
            imageViewModel = nil
        }

        let title = asset.platform?.value(for: locale) ?? ""

        let infoDetailsCommand = WalletAccountInfoCommand(balanceContext: balanceContext,
                                                          amountFormatter: numberFormatter,
                                                          commandFactory: commandFactory)

        return AssetDetailsViewModel(title: title,
                                     imageViewModel: imageViewModel,
                                     amount: amount,
                                     price: priceString,
                                     priceChangeViewModel: priceChangeViewModel,
                                     totalVolume: totalPriceString,
                                     leftTitle: leftTitle,
                                     leftDetails: leftDetails,
                                     rightTitle: rightTitle,
                                     rightDetails: rightDetails,
                                     infoDetailsCommand: infoDetailsCommand)
    }
}
