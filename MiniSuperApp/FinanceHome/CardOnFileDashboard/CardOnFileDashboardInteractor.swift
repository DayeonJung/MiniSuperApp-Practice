//
//  CardOnFileDashboardInteractor.swift
//  MiniSuperApp
//
//  Created by Dayeon Jung on 2022/07/05.
//

import ModernRIBs
import Combine

protocol CardOnFileDashboardRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol CardOnFileDashboardPresentable: Presentable {
    var listener: CardOnFileDashboardPresentableListener? { get set }

  func update(with viewModels: [PaymentMethodViewModel])
}

protocol CardOnFileDashboardListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

protocol CardOnFileDashboardInteractorDependency {
  var cardOnFileRepository: CardOnFileRepository { get }
}

final class CardOnFileDashboardInteractor: PresentableInteractor<CardOnFileDashboardPresentable>, CardOnFileDashboardInteractable, CardOnFileDashboardPresentableListener {

    weak var router: CardOnFileDashboardRouting?
    weak var listener: CardOnFileDashboardListener?

  private let dependency: CardOnFileDashboardInteractorDependency
  private var cancellables: Set<AnyCancellable>
  
    init(
      presenter: CardOnFileDashboardPresentable,
      dependency: CardOnFileDashboardInteractorDependency
    ) {
      self.dependency = dependency
      self.cancellables = .init()
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        
      dependency.cardOnFileRepository.cardOnFile.sink { methods in
        let viewModels = methods.prefix(5).map(PaymentMethodViewModel.init)
        self.presenter.update(with: viewModels)
      }.store(in: &cancellables)
    }

    override func willResignActive() {
        super.willResignActive()
        
      // sink 할 때, retain cycle이 발생할 수 있으므로
      cancellables.forEach{ $0.cancel() }
      cancellables.removeAll()
    }
}
