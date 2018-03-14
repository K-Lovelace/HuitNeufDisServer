class SubscriptionController < ApplicationController
  def create
    Subscription.create({
      json: params[:subscription]
    })
    head :ok
  end
end
