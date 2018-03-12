class Node
  include Neo4j::ActiveNode
  property :allee, type: String
  property :numero, type: Integer
  property :name, type: String

  before_create :build_name

  def build_name
    self.name = self.class.name + self.allee + self.numero.to_s
  end

end
