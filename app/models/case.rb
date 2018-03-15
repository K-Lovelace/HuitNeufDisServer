class Case
  include Neo4j::ActiveNode
  property :stock, type: Integer
  property :section, type: Integer
  property :etagere, type: Integer

  has_one :in, :article, origin: :cases
  has_one :out, :armoire, type: :IN, model_class: :Armoire

  after_update :check_stock

  def check_stock
    if self.stock <= 0
      message = {
          title: "Stock critique!",
          body: self.name,
          tag: "new-message"
      }
      Subscription.all.each do |subsc|
        subscription = JSON.parse(subsc[:json])
        begin
          Webpush.payload_send(
            message: JSON.generate(message),
            endpoint: subscription["endpoint"],
            p256dh: subscription["keys"]["p256dh"],
            auth: subscription["keys"]["auth"],
            ttl: 15,
            vapid: {
                subject: 'mailto:admin@example.com',
            public_key: Rails.application.config.notifications[:public_key],
            private_key: Rails.application.config.notifications[:private_key]
          })
        rescue e
          subsc.destroy # if there is any problem, just destroy it
        end
      end
    end
  end

  def name
    "#{self.armoire.name} S#{self.section}E#{self.etagere} "
  end

end
