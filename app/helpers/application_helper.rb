module ApplicationHelper

    def load_templates( opts = {} )
        templates = []
        
        if opts[:views].nil?
            views_dir = "*"
        else
            views_dir = opts[:views]
        end
        
        if opts[:rel].nil?
            rel_path = "**/"
        else
            rel_path = "#{opts[:rel]}/**/"
        end
        
        search_path = "app/views/#{views_dir}/templates/#{rel_path}*.*"
        
        Dir.glob(search_path).each do |file_name|
            matches = /app\/views\/(.*)\/templates\/(.*?)_([\w\.]+)\.html\.(haml|erb)/.match file_name
            
            if matches
                tmpl_views_dir = "#{matches[1]}"
                tmpl_name = "#{matches[2]}#{matches[3]}"
                tmpl_content = render :partial => "#{tmpl_views_dir}/templates/#{tmpl_name}"
                
                templates << { :id => "template:#{tmpl_name}", :content => tmpl_content }
            end
        end
        
        templates
    end

    def render_templates( opts = {} )
        templates = load_templates( opts )
        templates = templates.collect do |t|
            "<script type='text/template' id='#{t[:id]}'>#{t[:content]}</script>"
        end
        
        raw( templates.join )
    end
    
end
