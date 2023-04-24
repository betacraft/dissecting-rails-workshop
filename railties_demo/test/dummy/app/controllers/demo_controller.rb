class DemoController < ApplicationController
  skip_before_action :verify_authenticity_token
  def sample
    puts "Request params as seen in App code: \n #{request.params}"
    puts "Response as seen in App code: \n #{api_response}"
    render json: api_response
  end

  private

  def api_response
    if approved_user?
      {
        success: true,
        response_data: {
          approval_status: 'approved'
        }
      }.to_json
    else
      {
        success: true, #API returns success even if the user is not approved
        response_data: {
          approval_status: 'declined'
        }
      }.to_json
    end
  end

  def approved_user?
    first_name == 'ratnadeep'
  end

  def first_name
    user_params[:first_name]&.downcase
  end

  def user_params
    params.require(:demo).permit(:first_name)
  end
end
