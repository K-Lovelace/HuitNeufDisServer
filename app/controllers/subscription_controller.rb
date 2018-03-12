class SubscriptionController < ApplicationController
  def create
    session[:subscription] = JSON.dump(params.fetch(:subscription, {}))

    head :ok
  end
end
