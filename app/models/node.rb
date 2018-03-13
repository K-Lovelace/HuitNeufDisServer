class Node
  include Neo4j::ActiveNode
  property :allee, type: String
  property :numero, type: Integer
  property :name, type: String

  has_many :out, :leads_to, rel_class: :LeadsTo

  before_create :build_name

  def build_name
    self.name = self.class.name + self.allee + self.numero.to_s
  end

  def next_in_allee
    self.leads_to(:lt).where("lt.allee = '#{self.allee}'").pluck(:lt).first
  end

  def next_allee
    self.leads_to(:lt, :rel).where('rel.change_ally = true').pluck(:lt).first
  end

  def path_to(other_node)
    result = []
    Rails.logger.info [self, other_node].to_json
    if self.leads_to?(other_node)
      # next_step
      next_step = nil
      # if the other node is in down lane (B, D, F...), self number should be above
      # else if the other node is in up lane (A, C, E...), self number should be below
      change_allee = other_node.direction == 'down' ? self.numero > other_node.numero : self.numero < other_node.numero
      # change of lane if you are in the same direction than the destination or if needed
      change_allee = change_allee || self.direction == other_node.direction
      # don't change line if you are on the right one!
      next_step = self.next_allee if change_allee && self.allee != other_node.allee
      # can't change or won't change? keep swimming forward (° >< |
      next_step = self.next_in_allee if next_step.nil?

      result << {
        node: next_step
      }
      result += next_step.path_to(other_node) unless next_step.nil?
    end


    result
  end

  def leads_to?(other_node)
    self.leads_to.match_to(other_node).length == 0
  end

  def direction
    (self.allee.upcase.ord - 'A'.ord + 1) % 2 == 0 ? 'down' : 'up'
  end

  def <=>(other_item)
    return self.allee <=> other_item.allee if self.allee != other_item.allee

    if self.direction == 'up'
      return self.numero <=> other_item.numero
    else
      return other_item.numero <=> self.numero
    end
  end
end
