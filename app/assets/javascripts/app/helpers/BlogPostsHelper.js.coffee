namespace "app.helpers", ->

    class @BlogPostsHelper
    
        make_html: ( markdown ) =>
            if markdown && markdown.length
                converter = new Markdown.Converter()
                
                html = converter.makeHtml( markdown )
                
                content = $( "<div>#{html}</div>" )
                
                # TODO: how cross-browser is this?  would it be better to simply call prettyPrint()
                # after the template is rendered?
                content.find("pre code").each (i, el) ->
                    el.outerHTML = prettyPrintOne(el.outerHTML, null, true)

                content.html()
            else
                ""
                