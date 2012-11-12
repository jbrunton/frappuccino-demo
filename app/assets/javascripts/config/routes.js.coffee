namespace "config"

config.routes = ->
    
    @match '', controller: 'home', action: 'index'
    
    @match 'search/tag/:tag', controller: 'search', action: 'search_tag'
    @match 'search/:text', controller: 'search', action: 'search'

    @resource 'users'
    @resource 'blogs', path_names: { create: 'compose' }
    @resource 'blog_posts', except: ['create']
    @match 'blog_posts/:blog_id/compose', controller: 'blog_posts', action: 'create'
    
    