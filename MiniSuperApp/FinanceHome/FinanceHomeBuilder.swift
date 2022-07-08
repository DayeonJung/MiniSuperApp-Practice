import ModernRIBs

protocol FinanceHomeDependency: Dependency {
  // TODO: Declare the set of dependencies required by this RIB, but cannot be
  // created by this RIB.
}

final class FinanceHomeComponent: Component<FinanceHomeDependency>,
                                  SuperPayDashboardDependency,
                                  CardOnFileDashboardDependency,
                                  AddPaymentMethodDependency {
  var cardOnFileRepository: CardOnFileRepository
  var balance: ReadOnlyCurrentValuePublisher<Double> { balancePublisher }
  private let balancePublisher: CurrentValuePublisher<Double>
  
  init(
    dependency: FinanceHomeDependency,
    balance: CurrentValuePublisher<Double>,
    cardOnFileRepository: CardOnFileRepository
  ) {
    self.balancePublisher = balance
    self.cardOnFileRepository = cardOnFileRepository
    super.init(dependency: dependency)
  }
}

// MARK: - Builder

protocol FinanceHomeBuildable: Buildable {
  func build(withListener listener: FinanceHomeListener) -> FinanceHomeRouting
}

final class FinanceHomeBuilder: Builder<FinanceHomeDependency>, FinanceHomeBuildable {
  
  override init(dependency: FinanceHomeDependency) {
    super.init(dependency: dependency)
  }
  
  func build(withListener listener: FinanceHomeListener) -> FinanceHomeRouting {
    // FinanceHome에서 balance값이 정해지는 경우(하위 RIB으로 전달)
    let balancePublisher = CurrentValuePublisher<Double>(1000)
    
    // cardOnFileRepository: 바로 생성하여 하위에 전달
    let component = FinanceHomeComponent(
      dependency: dependency,
      balance: balancePublisher,
      cardOnFileRepository: CardOnFileRepositoryImp()
    )
    let viewController = FinanceHomeViewController()
    let interactor = FinanceHomeInteractor(presenter: viewController)
    interactor.listener = listener
      
    let superPayDashboardBuilder = SuperPayDashboardBuilder(dependency: component)
    let cardOnFileDashboardBuilder = CardOnFileDashboardBuilder(dependency: component)
    let addPaymentMethodBuilder = AddPaymentMethodBuilder(dependency: component)
    
    return FinanceHomeRouter(
        interactor: interactor,
        viewController: viewController,
        superPayDashboardBuildable: superPayDashboardBuilder,
        cardOnFileDashboardBuildable: cardOnFileDashboardBuilder,
        addPaymentMethodBuidlable: addPaymentMethodBuilder
    )
  }
}
