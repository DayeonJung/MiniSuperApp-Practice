//
//  SuperPayDashboardBuilder.swift
//  MiniSuperApp
//
//  Created by Dayeon Jung on 2022/06/30.
//

import ModernRIBs
import Foundation

// 부모로부터 전달받고자 하는 디펜던시
protocol SuperPayDashboardDependency: Dependency {
  var balance: ReadOnlyCurrentValuePublisher<Double> { get }
}

final class SuperPayDashboardComponent: Component<SuperPayDashboardDependency>, SuperPayDashboardInteractorDependency {
  var balance: ReadOnlyCurrentValuePublisher<Double> { dependency.balance }
  var balanceFormatter: NumberFormatter { Formatter.balanceFormatter }
}

// MARK: - Builder

protocol SuperPayDashboardBuildable: Buildable {
    func build(withListener listener: SuperPayDashboardListener) -> SuperPayDashboardRouting
}

final class SuperPayDashboardBuilder: Builder<SuperPayDashboardDependency>, SuperPayDashboardBuildable {

    override init(dependency: SuperPayDashboardDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: SuperPayDashboardListener) -> SuperPayDashboardRouting {
        let component = SuperPayDashboardComponent(dependency: dependency)
        let viewController = SuperPayDashboardViewController()
        let interactor = SuperPayDashboardInteractor(
          presenter: viewController,
          dependency: component
        )
        interactor.listener = listener
        return SuperPayDashboardRouter(interactor: interactor, viewController: viewController)
    }
}
