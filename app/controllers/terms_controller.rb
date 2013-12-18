class TermsController < ApplicationController
  inherit_resources

  def create
    create! { terms_path }
  end

  def update
    update! { terms_path }
  end

  def preview
    @term = current_user.terms.find(params[:id])
  end


  protected

  def begin_of_association_chain
    current_user
  end


  private

  def permitted_params
    params.permit(:term => [:term])
  end

end