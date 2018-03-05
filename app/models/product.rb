class Product 
  include Neo4j::ActiveNode
  property :name, type: String
  property :weight, type: Integer



end
