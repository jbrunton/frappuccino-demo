namespace "app", ->

    class @Bootstrapper extends core.Bootstrapper
    
        # TODO: remove app param, and register Renderer as a singleton type
        configure_container: ( application ) ->
            container = super( application )
            
            # container.registerClass "Application", app.Application, singleton: true
            container.register_class "Renderer", infrastructure.KoRenderer, singleton: true
            container.register_class "Router", infrastructure.BackboneRouter, singleton: true
            container.register_class "PropertyFactory", core.types.KoPropertyFactory, singleton: true
            container.register_class "ModelRepository", core.resources.HttpRepository, singleton: true

            # TODO: move this to a resources controller which reads from the api feed
            env = container.resolve "Environment"
            
            env.defineSimpleType "number"
            env.defineSimpleType "string"

            # TODO: replace the date formatting with moment.js
            formatDate = (date) ->
                if date
                    date.toString()
                else
                    null
        
            parseDate = (value) ->
                # 2012-03-15T23:02:29Z
                regex = /^(\d{4})-(\d{2})-(\d{2})T(\d{2}):(\d{2}):(\d{2})Z$/
        
                if (value)
                    match = value.match(regex)
                    new Date(
                        parseInt(match[1]),
                        parseInt(match[2]),
                        parseInt(match[3]),
                        parseInt(match[4]),
                        parseInt(match[5]),
                        parseInt(match[6]))
                else
                    null

            env.defineSimpleType "datetime", formatDate, parseDate
                                            
            container
            
        initialize: ->
            # random final initialization phase
            # TODO: there's probably somewhere better to put this
            ko.setTemplateEngine( new infrastructure.UnderscoreTemplateEngine( @application ) )
            _.templateSettings =
                interpolate: /\{\{(.+?)\}\}/g
                evaluate: /\{\[(.+?)\]\}/g