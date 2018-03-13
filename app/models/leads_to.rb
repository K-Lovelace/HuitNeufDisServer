class LeadsTo
  include Neo4j::ActiveRel
  property :change_ally, type: Boolean

  before_create :set_prop

  from_class [:Armoire, :Porte, :Marquage]
  to_class [:Armoire, :Porte, :Marquage]
  type 'LEADS-TO'
  creates_unique

  def set_prop
    self.change_ally = from_node.is_a?(Marquage) && to_node.is_a?(Marquage)
  end
end
