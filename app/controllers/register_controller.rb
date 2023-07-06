class RegisterController < ApplicationController
  def index
    @user = User.new
  end
  def create
    render plain: "Thanks"
  end
end
