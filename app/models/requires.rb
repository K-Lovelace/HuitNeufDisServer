class Requires
  include Neo4j::ActiveRel
  property :quantity, type: Integer, default: 1
  property :quantity_left, type: Integer

  from_class :Command
  to_class :Article
  type 'REQUIRES'

  before_create :initialize_quantity_left

  after_update :update_command

  def initialize_quantity_left
    self.quantity_left = self.quantity
  end

  def update_command
    from_node.compute_articles
    from_node.save
  end

end
