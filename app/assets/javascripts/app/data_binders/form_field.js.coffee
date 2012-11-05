ko.bindingHandlers.formField =
    init: ko.bindingHandlers.template.init,
    
    update: (element, valueAccessor, allBindingsAccessor, viewModel, context) ->
        options = ko.utils.unwrapObservable(valueAccessor())
        
        options.name = 'template:shared/form_field'
        context = context.createChildContext({ $field: options.field, $label: options.label }, context.$data)
        context.$data = options.data unless not options.data?
        
        ko.bindingHandlers.template.update( element, valueAccessor, allBindingsAccessor, viewModel, context )
