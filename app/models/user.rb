class User
  include Neo4j::ActiveNode
  property :name, type: String
  property :max_push, type: Float
  property :max_carry, type: Float
  property :role, type: String

  has_many :out, :commands, type: :PREPARES, model_class: :Command

  def get_commands!
    self.commands = []
    current_max_push = self.max_push

    while current_max_push > 0
      commands = Command.as(:c).where('NOT (c)<-[:PREPARES]-(:User)')
      .where("c.max_carry_weight < #{self.max_carry}")
      .where("c.total_weight < #{current_max_push}")
      .order(:created_at).limit(5).pluck(:c)

      commands.each do |c|
        if c.total_weight <= current_max_push
          self.commands << c
          current_max_push -= c.total_weight
        end
      end

      # if no command were found
      if commands.length == 0
        self.commands << commands.first if current_max_push == self.max_push #add the first command if no other command were added
        current_max_push = 0
      end
    end
  end
end
