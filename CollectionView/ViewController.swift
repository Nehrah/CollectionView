//
//  ViewController.swift
//  CollectionView
//
//  Created by Nethrah Ayyaswami on 10/13/20.
//

import UIKit

class ViewController: UIViewController {
    enum Section{
        case main
    }
    @IBOutlet weak var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section,Int>!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.collectionViewLayout = configureLayout()
        configureDataSource()
        // Do any additional setup after loading the view.
    }
    func configureLayout() -> UICollectionViewCompositionalLayout{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.2), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize:itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.2))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        return UICollectionViewCompositionalLayout(section: section)
        
    }
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section,Int>(collectionView: self.collectionView){
            (collectionView,indexPath,number) -> UICollectionViewCell?  in
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NumberCell.reuseIdentifier, for: indexPath) as? NumberCell else {
              fatalError("Cannot create new cell")
            }
            
            cell.collectionLabel?.text = number.description
            return cell
            
        }
        
        var initialSnapshot = NSDiffableDataSourceSnapshot<Section,Int>()
        initialSnapshot.appendSections([.main])
        initialSnapshot.appendItems(Array(1...100))
        dataSource.apply(initialSnapshot,animatingDifferences:false)

    }
    

}

