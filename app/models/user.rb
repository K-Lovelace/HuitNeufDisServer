class User
  include Neo4j::ActiveNode
  property :name, type: String
  property :max_push, type: Float
  property :max_carry, type: Float
  property :role, type: String

  has_many :out, :commands, type: :PREPARES, model_class: :Command

end
