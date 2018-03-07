class Marquage
  include Neo4j::ActiveNode
  property :numero, type: String # LettreINuméro (AI1, BI3)

  has_many :out, :leads_to, rel_class: :LeadsTo

end
