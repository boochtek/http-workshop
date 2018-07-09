class MainController < ApplicationController

  def index
   render plain: "Hello, World!\n"
  end

  def slides
    redirect_to "https://rawgit.com/booch/presentations/master/HTTP_Exploration/slides.html"
  end

  def reflect
    request_headers = request.headers.select{|k,v| k =~ /^HTTP_/}.reject{|k,v| k == 'HTTP_VERSION'}
    request_headers = request_headers.map{|k,v| "#{k.sub('HTTP_', '').titlecase.tr(' ', '-')}: #{v}"}.join("\n")
    render plain: "#{request_headers}\n"
  end

  def redirect
    redirect_to "https://raw.githubusercontent.com/boochtek/http-workshop/master/app/controllers/main_controller.rb"
  end

  # Don't require a CSRF token to POST to `/post`.
  protect_from_forgery except: :post

  def post
    post_params = params.permit!.to_h.reject{|k,v| %w[controller action].include?(k)}
    post_params = post_params.map{|k,v| "#{k}: #{v}"}.join("\n")
    render plain: "#{post_params}\n"
  end

  def etag
    resource = Struct.new(:id, :updated_at).new(123, Time.parse("2018-07-11"))
    return if fresh_when(resource, public: true, template: false)
    render plain: "Resource ID: #{resource.id}\n"
  end

end
