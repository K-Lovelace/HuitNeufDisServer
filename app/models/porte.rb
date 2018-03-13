class Porte < Node
  include Neo4j::ActiveNode
  property :entry, type: Boolean

  def build_name
    self.name = self.class.name + self.allee
  end
end
