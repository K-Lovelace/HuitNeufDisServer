class Case
  include Neo4j::ActiveNode
  property :stock, type: Integer
  property :section, type: Integer
  property :etagere, type: Integer

  has_one :in, :article, origin: :cases
  has_one :out, :armoire, type: :IN, model_class: :Armoire

end
