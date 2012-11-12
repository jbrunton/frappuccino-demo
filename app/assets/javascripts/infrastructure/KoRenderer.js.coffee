namespace "infrastructure"

# TODO: this should be replaced with the default Frappuccino renderer once implemented
# (see https://github.com/jbrunton/frappuccino-core/issues/20)
#    
class infrastructure.KoRenderer extends core.Renderer
            
    _registerTemplate: (name, content) ->
        content.attr( "id", name )
        $('body').append( content )
        
    render_template: ( template, data, target ) ->
        target.html $( "<div></div>" ).attr 'data-bind',
                "template: 'template:#{template}'"

        ko.applyBindings( data || {}, target[0] )