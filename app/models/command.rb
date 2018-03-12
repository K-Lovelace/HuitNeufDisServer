class Command
  include Neo4j::ActiveNode
  include Neo4j::Timestamps
  property :nb_articles, type: Integer, default: 0
  property :total_weight, type: Float, default: 0.0
  property :max_carry_weight, type: Float, default: 0.0

  has_one :in, :preparateur, origin: :commands
  has_many :out, :articles, rel_class: :Requires

  before_save :compute_articles

  def compute_articles
    self.nb_articles = self.articles.each_rel.sum(&:quantity)
    self.max_carry_weight = self.articles.max_by(&:weight).try(:weight) || 0.0
    self.total_weight = self.articles.each_with_rel.sum {|a, rel| a.weight * rel.quantity }
  end

end
