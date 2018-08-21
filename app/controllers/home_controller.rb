class HomeController < ApplicationController
  require 'open-uri'
  require 'json'
  require 'cgi'


  def landing
  end

  def index
    @condoms = Condom.all
  end

  def search_around
    results = get_infos(params[:search])
    respond_to do |format|
      format.json {
        render json: results
      }
    end
  end

  def search_center
    encoded = CGI::escape(params[:search])
    data = JSON.load(open("https://openapi.naver.com/v1/search/local.json?query=#{encoded}&start=1&display=1",
    "X-Naver-Client-Secret" => "NteRqJBSgR",
    "X-Naver-Client-Id" => "hoAJkV1ejgYLcx1aMVWu"))
    
    respond_to do |format|
      format.json {
        render json: data["items"][0]
      }
    end
  end

  def hot
    @comments = Comment.all
    @comment = Comment.new
  end

  def rating
    @comment = Comment.new(params.require(:comment).permit(:content, :score))
    @comment.save
  end
  
  private
   def get_infos(query)
    keywords = ["gs25","cu","미니스톱","세븐일레븐","올리브영","약국","성인용품","왓슨스","롭스"]
    results = {}
    nowTime = Time.now().to_a
    print(nowTime[2])
    keywords.each do |keyword|
      encodedQuery = CGI::escape(query + " 근처 " + keyword)
      data = JSON.load(open("https://openapi.naver.com/v1/search/local.json?query=#{encodedQuery}&start=1&display=50",
      "X-Naver-Client-Secret" => "NteRqJBSgR",
      "X-Naver-Client-Id" => "hoAJkV1ejgYLcx1aMVWu"))["items"]
      results[keyword] = {"list" => nil, "condoms" => []}
      results[keyword]["list"] = data
      if ["gs25","cu","미니스톱","세븐일레븐"].include?(keyword)
        results[keyword]["condoms"] = Condom.where({store: "conven"}).as_json.shuffle
        results[keyword]["time"] = "00:00 ~ 24:00"
        results[keyword]["open"] = true
      elsif ["올리브영", "왓슨스","롭스"].include?(keyword)
        results[keyword]["condoms"] = Condom.where({store: "drug"}).as_json.shuffle
        results[keyword]["time"] = "10:00 ~ 23:00"
        results[keyword]["open"] = nowTime[2] >= 10 && nowTime[2] < 23
      else
        results[keyword]["condoms"] = Condom.where({store: "drug"}).as_json.shuffle
        t = Time.new
        results[keyword]["open"] = false
        if t.wday >= 1 and t.wday <= 5
          results[keyword]["time"] = "10:00 ~ 20:00"
          results[keyword]["open"] = nowTime[2] >= 10 && nowTime[2] < 20
        else
          results[keyword]["time"] = "휴무"
        end
      end 
    end
    return results
   end

end
