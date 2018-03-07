class Armoire
  include Neo4j::ActiveNode
  property :allee, type: String
  property :numero, type: Integer

  has_many :in, :cases, origin: :armoire
  has_many :out, :leads_to, rel_class: :LeadsTo, model_class: :Marquage

  after_create :build_cases

  def build_cases
    1.upto(3) do |section|
      1.upto(6) do |etagere|
        new_case = Case.create({
          section: section,
          etagere: etagere,
          stock: 0
        })
        new_case.armoire = self
      end
    end
  end
end
