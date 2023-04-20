require 'json'
class SampleApp
  def call(env)
    @request = Rack::Request.new(env)
    [200, {}, [api_response]]
  end

  private

  attr_reader :request

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
    request.params['first_name']&.downcase == 'ratnadeep'
  end
end
