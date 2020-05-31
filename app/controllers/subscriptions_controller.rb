# frozen_string_literal: true

class SubscriptionsController < ApplicationController
  before_action :authenticate_user!

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
    params.permit(:url)
  end

  def destroy
    @subscription = Subscription.find(params[:id])
    @subscription.destroy
    redirect_to subscriptions_path
  end

  def show
    # TODO:
    # add pagination
    @subscription = current_user.subscriptions.find_by(id: params[:id])
    @contents = @subscription.contents.reverse
  end
end
