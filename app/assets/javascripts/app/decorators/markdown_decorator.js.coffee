namespace "app.decorators"

class app.decorators.MarkdownDecorator

    make_html: ( markdown ) =>
        if markdown && markdown.length
            converter = new Markdown.Converter()                
            converter.makeHtml( markdown )
        else
            ""
    
    prettify_code: ( html ) =>
        content = $( "<div>#{html}</div>" )
        
        # TODO: how cross-browser is this?  would it be better to simply call prettyPrint()
        # after the template is rendered?
        content.find("pre code").each (i, el) ->
            # this string replacement appears to be required on webkit browsers - though
            # the differences appear before the source is rendered by the browser (ie,
            # string comparison of the JS-generated prettified markdown differs)
            html = el.outerHTML.replace /\n(\ *)/gi, (x, y) ->
                "<br />" + new Array(y.length).join("&nbsp;")
            el.outerHTML = prettyPrintOne(html, null, true)

        content.html()
    
    make_and_prettify_code: ( markdown ) =>
        @prettify_code( @make_html( markdown ) )