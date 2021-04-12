// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class ProducListsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query ProducLists {
      productLists {
        __typename
        name
        emoji
        product(orderBy: {order: asc}) {
          __typename
          name
          price
        }
      }
    }
    """

  public let operationName: String = "ProducLists"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("productLists", type: .nonNull(.list(.nonNull(.object(ProductList.selections))))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(productLists: [ProductList]) {
      self.init(unsafeResultMap: ["__typename": "Query", "productLists": productLists.map { (value: ProductList) -> ResultMap in value.resultMap }])
    }

    public var productLists: [ProductList] {
      get {
        return (resultMap["productLists"] as! [ResultMap]).map { (value: ResultMap) -> ProductList in ProductList(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: ProductList) -> ResultMap in value.resultMap }, forKey: "productLists")
      }
    }

    public struct ProductList: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["ProductList"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("name", type: .nonNull(.scalar(String.self))),
          GraphQLField("emoji", type: .scalar(String.self)),
          GraphQLField("product", arguments: ["orderBy": ["order": "asc"]], type: .nonNull(.list(.nonNull(.object(Product.selections))))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(name: String, emoji: String? = nil, product: [Product]) {
        self.init(unsafeResultMap: ["__typename": "ProductList", "name": name, "emoji": emoji, "product": product.map { (value: Product) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var name: String {
        get {
          return resultMap["name"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "name")
        }
      }

      public var emoji: String? {
        get {
          return resultMap["emoji"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "emoji")
        }
      }

      public var product: [Product] {
        get {
          return (resultMap["product"] as! [ResultMap]).map { (value: ResultMap) -> Product in Product(unsafeResultMap: value) }
        }
        set {
          resultMap.updateValue(newValue.map { (value: Product) -> ResultMap in value.resultMap }, forKey: "product")
        }
      }

      public struct Product: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Product"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("name", type: .nonNull(.scalar(String.self))),
            GraphQLField("price", type: .nonNull(.scalar(Int.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(name: String, price: Int) {
          self.init(unsafeResultMap: ["__typename": "Product", "name": name, "price": price])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var name: String {
          get {
            return resultMap["name"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "name")
          }
        }

        public var price: Int {
          get {
            return resultMap["price"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "price")
          }
        }
      }
    }
  }
}
