import ModernRIBs

public protocol AppHomeDependency: Dependency {
}

final class AppHomeComponent: Component<AppHomeDependency>, TransportHomeDependency {
    // 리블렛에 로직이 추가될 때 로직에 필요한 객체를 담는 바구니
}

// MARK: - Builder

public protocol AppHomeBuildable: Buildable {
    func build(withListener listener: AppHomeListener) -> ViewableRouting
}

public final class AppHomeBuilder: Builder<AppHomeDependency>, AppHomeBuildable {
    
    public override init(dependency: AppHomeDependency) {
        super.init(dependency: dependency)
    }
    
    // 리스너를 통해 델리게이트 패턴 구현
    public func build(withListener listener: AppHomeListener) -> ViewableRouting {
        let component = AppHomeComponent(dependency: dependency)
        let viewController = AppHomeViewController()
        let interactor = AppHomeInteractor(presenter: viewController)
        interactor.listener = listener
        
        let transportHomeBuilder = TransportHomeBuilder(dependency: component)
        
        return AppHomeRouter(
            interactor: interactor,
            viewController: viewController,
            transportHomeBuildable: transportHomeBuilder
        )
    }
}
