class Article
  include Neo4j::ActiveNode
  property :name, type: String
  property :weight, type: Float

  has_many :out, :commands, type: :IN, model_class: :Commands
  has_many :out, :cases, type: :IN, model_class: :Case

end
