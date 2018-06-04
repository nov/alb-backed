class EnvController < ApplicationController
  def show
    render json: request.env
  end
end
