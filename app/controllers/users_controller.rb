class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
  end

  def update
    name = params[:name]
    if(name && !name.strip.empty?)
      person = Person.find_or_create_by(name: name)
      current_user.person = person
      current_user.save

      if(current_user.errors.any?)
        flash[:error] = current_user.errors.full_messages.join(' ')
      else
        flash[:success] = "You will henceforth be known as: #{name}"
      end
    end

    redirect_to edit_user_registration_path
  end
end
