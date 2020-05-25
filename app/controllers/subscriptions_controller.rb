# frozen_string_literal: true

class SubscriptionsController < ApplicationController
  def index
    @subscriptions = current_user.subscriptions
  end

  def create
    @subscription = Subscription.new(subscription_params)
    @subscription.user_id = current_user.id

    if @subscription.save
      redirect_to subscriptions_path
    else
      render json: @subscription.errors
    end
  end

  def new
    @subscription = Subscription.new
  end

  def subscription_params
    params.permit(:url, :authenticity_token)
  end

  def destroy
    @subscription = Subscription.find(params[:id])
    @subscription.destroy
    redirect_to subscriptions_path
  end
end
