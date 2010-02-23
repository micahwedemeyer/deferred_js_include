module DeferredJsInclude
  def deferred_js(*sources)
    @deferred_javascripts ||= []
    @deferred_javascripts += sources
  end
  
  def include_deferred_js(*opts)
    js = @deferred_javascripts.collect {|x| x.to_s}
    js.uniq!
    
    # If they want caching, we'll do it for the entire set of files
    options = opts.extract_options!.stringify_keys
    cache = options.delete("cache")
    if cache
      # If they passed 'true' then we create the name, otherwise we pass along the string/symbol they passed
      options[:cache] = (cache == true) ? js.join("_") : cache
    end
    
    js << options
    javascript_include_tag(*js)
  end
end