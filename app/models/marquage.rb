class Marquage < Node
  include Neo4j::ActiveNode

  has_many :out, :leads_to, rel_class: :LeadsTo

end
