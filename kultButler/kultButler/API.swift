// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public struct OrderItemInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - perUnitPrice
  ///   - name
  ///   - amount
  ///   - listId
  ///   - note
  public init(perUnitPrice: Int, name: String, amount: Int, listId: Swift.Optional<Int?> = nil, note: Swift.Optional<String?> = nil) {
    graphQLMap = ["perUnitPrice": perUnitPrice, "name": name, "amount": amount, "listId": listId, "note": note]
  }

  public var perUnitPrice: Int {
    get {
      return graphQLMap["perUnitPrice"] as! Int
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "perUnitPrice")
    }
  }

  public var name: String {
    get {
      return graphQLMap["name"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "name")
    }
  }

  public var amount: Int {
    get {
      return graphQLMap["amount"] as! Int
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "amount")
    }
  }

  public var listId: Swift.Optional<Int?> {
    get {
      return graphQLMap["listId"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "listId")
    }
  }

  public var note: Swift.Optional<String?> {
    get {
      return graphQLMap["note"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "note")
    }
  }
}

public enum OrderPayment: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  case cash
  case bon
  case sumUp
  case voucher
  case freeCrew
  case freeBand
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "CASH": self = .cash
      case "BON": self = .bon
      case "SUM_UP": self = .sumUp
      case "VOUCHER": self = .voucher
      case "FREE_CREW": self = .freeCrew
      case "FREE_BAND": self = .freeBand
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .cash: return "CASH"
      case .bon: return "BON"
      case .sumUp: return "SUM_UP"
      case .voucher: return "VOUCHER"
      case .freeCrew: return "FREE_CREW"
      case .freeBand: return "FREE_BAND"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: OrderPayment, rhs: OrderPayment) -> Bool {
    switch (lhs, rhs) {
      case (.cash, .cash): return true
      case (.bon, .bon): return true
      case (.sumUp, .sumUp): return true
      case (.voucher, .voucher): return true
      case (.freeCrew, .freeCrew): return true
      case (.freeBand, .freeBand): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [OrderPayment] {
    return [
      .cash,
      .bon,
      .sumUp,
      .voucher,
      .freeCrew,
      .freeBand,
    ]
  }
}

public final class CreateOrderMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation CreateOrder($products: [OrderItemInput!]!, $payment: OrderPayment!, $deposit: Int!, $clientId: String, $deviceTime: DateTime!) {
      createOrder(
        products: $products
        payment: $payment
        deposit: $deposit
        clientId: $clientId
        deviceTime: $deviceTime
      ) {
        __typename
        id
      }
    }
    """

  public let operationName: String = "CreateOrder"

  public var products: [OrderItemInput]
  public var payment: OrderPayment
  public var deposit: Int
  public var clientId: String?
  public var deviceTime: String

  public init(products: [OrderItemInput], payment: OrderPayment, deposit: Int, clientId: String? = nil, deviceTime: String) {
    self.products = products
    self.payment = payment
    self.deposit = deposit
    self.clientId = clientId
    self.deviceTime = deviceTime
  }

  public var variables: GraphQLMap? {
    return ["products": products, "payment": payment, "deposit": deposit, "clientId": clientId, "deviceTime": deviceTime]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("createOrder", arguments: ["products": GraphQLVariable("products"), "payment": GraphQLVariable("payment"), "deposit": GraphQLVariable("deposit"), "clientId": GraphQLVariable("clientId"), "deviceTime": GraphQLVariable("deviceTime")], type: .object(CreateOrder.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(createOrder: CreateOrder? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "createOrder": createOrder.flatMap { (value: CreateOrder) -> ResultMap in value.resultMap }])
    }

    public var createOrder: CreateOrder? {
      get {
        return (resultMap["createOrder"] as? ResultMap).flatMap { CreateOrder(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "createOrder")
      }
    }

    public struct CreateOrder: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Order"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(Int.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: Int) {
        self.init(unsafeResultMap: ["__typename": "Order", "id": id])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: Int {
        get {
          return resultMap["id"]! as! Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }
    }
  }
}

public final class ProducListsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query ProducLists {
      productLists {
        __typename
        id
        name
        emoji
        product(orderBy: {order: asc}) {
          __typename
          id
          name
          price
          requiresDeposit
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
          GraphQLField("id", type: .nonNull(.scalar(Int.self))),
          GraphQLField("name", type: .nonNull(.scalar(String.self))),
          GraphQLField("emoji", type: .scalar(String.self)),
          GraphQLField("product", arguments: ["orderBy": ["order": "asc"]], type: .nonNull(.list(.nonNull(.object(Product.selections))))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: Int, name: String, emoji: String? = nil, product: [Product]) {
        self.init(unsafeResultMap: ["__typename": "ProductList", "id": id, "name": name, "emoji": emoji, "product": product.map { (value: Product) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: Int {
        get {
          return resultMap["id"]! as! Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
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
            GraphQLField("id", type: .nonNull(.scalar(Int.self))),
            GraphQLField("name", type: .nonNull(.scalar(String.self))),
            GraphQLField("price", type: .nonNull(.scalar(Int.self))),
            GraphQLField("requiresDeposit", type: .nonNull(.scalar(Bool.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: Int, name: String, price: Int, requiresDeposit: Bool) {
          self.init(unsafeResultMap: ["__typename": "Product", "id": id, "name": name, "price": price, "requiresDeposit": requiresDeposit])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: Int {
          get {
            return resultMap["id"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
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

        public var requiresDeposit: Bool {
          get {
            return resultMap["requiresDeposit"]! as! Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "requiresDeposit")
          }
        }
      }
    }
  }
}
