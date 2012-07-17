class EmergencyContactsController < ApplicationController
  def create
    @contact = current_user.emergency_contacts.create(params[:emergency_contact])
    redirect_to user_path(current_user)
  end
  def destroy
    @em_contact = current_user.emergency_contacts.find(params[:id])
    @em_contact.destroy
    redirect_to user_path(current_user)
  end
end
