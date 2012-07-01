namespace "app.helpers", ->

    class @BlogPostsHelper
    
        make_html: ( markdown ) =>
            if markdown && markdown.length
                converter = new Markdown.Converter()
                converter.makeHtml( markdown )
            else
                ""
        