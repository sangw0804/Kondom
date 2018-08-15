class HomeController < ApplicationController
  require 'open-uri'
  require 'json'
  require 'cgi'

  def landing
  end

  def index
  end

  def search
    encoded = CGI::escape(params[:search])
    data = JSON.load(open("https://openapi.naver.com/v1/search/local.json?query=#{encoded}&start=1&display=1",
    "X-Naver-Client-Secret" => "NteRqJBSgR",
    "X-Naver-Client-Id" => "hoAJkV1ejgYLcx1aMVWu"))
    results = get_infos(params[:search])
    results["current"] = data["items"][0]
    respond_to do |format|
      format.json {
        render json: results
      }
    end
  end

  private
   def get_infos(query)
    keywords = ["gs25","cu","미니스톱","세븐일레븐","올리브영","약국","성인용품","왓슨스","롭스"]
    results = {}
    keywords.each do |keyword|
      encodedQuery = CGI::escape(query + " " + keyword)
      data = JSON.load(open("https://openapi.naver.com/v1/search/local.json?query=#{encodedQuery}&start=1&display=50",
      "X-Naver-Client-Secret" => "NteRqJBSgR",
      "X-Naver-Client-Id" => "hoAJkV1ejgYLcx1aMVWu"))["items"]
      results[keyword] = data
    end
    return results
   end
end
