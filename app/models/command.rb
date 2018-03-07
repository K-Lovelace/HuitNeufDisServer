class Command
  include Neo4j::ActiveNode
  property :nb_articles, type: Integer
  property :total_weight, type: Float
  property :max_weight, type: Float

  has_one :in, :preparateur, origin: :commands
  has_many :in, :articles, origin: :commands

end
