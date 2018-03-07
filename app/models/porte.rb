class Porte
  include Neo4j::ActiveNode
  property :allee, type: String
  property :entry, type: Boolean

  has_many :out, :leads_to, rel_class: :LeadsTo, model_class: :Marquage

end
