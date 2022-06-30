//
//  SuperPayDashboardInteractor.swift
//  MiniSuperApp
//
//  Created by Dayeon Jung on 2022/06/30.
//

import ModernRIBs
import Combine
import Foundation

protocol SuperPayDashboardRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol SuperPayDashboardPresentable: Presentable {
    var listener: SuperPayDashboardPresentableListener? { get set }
    
  func updateBalance(_ balance: String)
}

protocol SuperPayDashboardListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

// Interactor에 필요한 여러값을 모아 정의
protocol SuperPayDashboardInteractorDependency {
  var balance: ReadOnlyCurrentValuePublisher<Double> { get }
  var balanceFormatter: NumberFormatter { get }
}

final class SuperPayDashboardInteractor: PresentableInteractor<SuperPayDashboardPresentable>, SuperPayDashboardInteractable, SuperPayDashboardPresentableListener {

    weak var router: SuperPayDashboardRouting?
    weak var listener: SuperPayDashboardListener?
  
  // presenter에 반영할 처리를 하기 위해 생성
  private let dependency: SuperPayDashboardInteractorDependency
  private var cancellables: Set<AnyCancellable>

    init(
      presenter: SuperPayDashboardPresentable,
      dependency: SuperPayDashboardInteractorDependency
    ) {
      self.dependency = dependency
      self.cancellables = .init()
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        
      dependency.balance.sink { [weak self] balance in
        self?.dependency.balanceFormatter.string(from: NSNumber(value: balance)).map({
          self?.presenter.updateBalance($0)
        })
      }.store(in: &cancellables)
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
}
