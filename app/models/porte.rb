class Porte < Node
  include Neo4j::ActiveNode
  property :entry, type: Boolean

  has_many :out, :leads_to, rel_class: :LeadsTo, model_class: :Marquage

  def build_name
    self.name = self.class.name + self.allee
  end
end
