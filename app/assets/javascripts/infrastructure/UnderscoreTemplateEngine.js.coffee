namespace "infrastructure", ->

    class @UnderscoreTemplateEngine extends ko.templateEngine
    
        constructor: (@app) ->
        
        bind_helpers: ( binding_context ) ->
            @app.bind_helper( "application", binding_context )
            
            controller_helper_name = app.request.active_controller.name
            @app.bind_helper( controller_helper_name, binding_context )
            
        renderTemplateSource: (templateSource, bindingContext, options) ->
            
            # Precompile and cache the templates for efficiency
            precompiled = templateSource['data']( 'precompiled' )
            
            if (!precompiled)
                precompiled = _.template( "{[ with($data) { ]} #{templateSource.text()} {[ } ]}" )
                templateSource['data']( 'precompiled', precompiled )
            
            bindingContext['$app'] = @app
            
            @bind_helpers( bindingContext )
                        
            # @app.bind_helper( "UrlHelper", bindingContext )
            
            # Run the template and parse its output into an array of DOM elements
            renderedMarkup = precompiled( bindingContext ).replace( /\s+/g, " " )
            ko.utils.parseHtmlFragment( renderedMarkup )
        
        createJavaScriptEvaluatorBlock: (script) ->
            "{{ #{script} }}"