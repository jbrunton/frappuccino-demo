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
                    _html = el.outerHTML
                    _html = _html.replace /\n(\ *)/gi, (x, y) ->
                        "<br />" + new Array(y.length).join("&nbsp;")
                    el.outerHTML = prettyPrintOne(_html, null, true)

                content.html()
            else
                ""
                