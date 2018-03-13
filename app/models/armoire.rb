class Armoire < Node
  include Neo4j::ActiveNode

  has_many :in, :cases, origin: :armoire

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
