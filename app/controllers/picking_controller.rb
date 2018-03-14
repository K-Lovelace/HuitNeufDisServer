class PickingController < ApplicationController
  def stock
    @cases = Case.as(:c).where('c.stock <= 1').pluck(:c)
    @cases.map!{|c| {
      id: c.id,
      name: c.name,
      stock: c.stock
    }}

    @cases.sort_by! {:name}

    @decodedVapidPublicKey = Base64.urlsafe_decode64(Rails.application.config.notifications[:public_key]).bytes
  end

  def supervisor
  end

  def push
    Webpush.payload_send(
      message: params[:message],
      endpoint: params[:subscription][:endpoint],
      p256dh: params[:subscription][:keys][:p256dh],
      auth: params[:subscription][:keys][:auth],
      ttl: 24 * 60 * 60,
      vapid: {
        public_key: Rails.application.config.notifications[:public_key],
        private_key: Rails.application.config.notifications[:private_key]
      }
    )
  end
end
