class CreateSubscription < Neo4j::Migrations::Base
  def up
    add_constraint :Subscription, :uuid
  end

  def down
    drop_constraint :Subscription, :uuid
  end
end
