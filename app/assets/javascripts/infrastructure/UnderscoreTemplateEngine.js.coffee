namespace "infrastructure"

# TODO: this is misnamed for now, but it should be replaced with the default Frappuccino
# engine once implemented (see https://github.com/jbrunton/frappuccino-core/issues/20)
#
class infrastructure.UnderscoreTemplateEngine extends ko.nativeTemplateEngine

    constructor: (@app) ->
        @allowTemplateRewriting = false
    
    bind_helpers: ( binding_context ) ->
        @app.bind_helper( "application", binding_context )
        
        controller_helper_name = @app.request.active_controller.name
        @app.bind_helper( controller_helper_name, binding_context )
        
    renderTemplateSource: (templateSource, bindingContext, options) ->
        @bind_helpers( bindingContext )           
        super(templateSource, bindingContext, options)