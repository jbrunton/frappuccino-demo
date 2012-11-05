class Api::SearchController < ApiController
    respond_to :json
    
    def index
        search_text = "%#{params[:search_text]}%"
        query = "lower(content) LIKE lower(?) or lower(title) LIKE lower(?)" 

        blog_posts = BlogPost.where([query, search_text, search_text])
            .limit(params[:limit] || 10)
            .offset(params[:offset] || 0)

        respond_with( blog_posts )
    end

    def tag
        blog_posts = BlogPost.joins(:tags).where(:tags => {:tag => params[:tag]})
        respond_with( blog_posts )
    end
    
    def trending
        tags = BlogPost.joins(:tags).
            select("tag, count(*) as count").
            group("tag").
            order("count DESC").
            limit(5)

        respond_with( tags )
    end

end