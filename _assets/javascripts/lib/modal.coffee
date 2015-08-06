do ->

  buildOut = ->
    content = undefined
    contentHolder = undefined
    docFrag = undefined

    if typeof @options.content == 'string'
      content = @options.content
    else
      content = @options.content.innerHTML
    # Create a DocumentFragment to build with
    docFrag = document.createDocumentFragment()
    # Create modal element
    @modal = document.createElement('div')
    @modal.className = 'modal ' + @options.className
    @modal.style.minWidth = @options.minWidth + 'px'
    @modal.style.maxWidth = @options.maxWidth + 'px'
    # If closeButton option is true, add a close button
    if @options.closeButton == true
      @closeButton = document.createElement('button')
      @closeButton.className = 'modal-close close-button'
      @closeButton.innerHTML = '×'
      @modal.appendChild @closeButton
    # If overlay is true, add one
    if @options.overlay == true
      @overlay = document.createElement('div')
      @overlay.className = 'modal-overlay ' + @options.className
      docFrag.appendChild @overlay
    # Create content area and append to modal
    contentHolder = document.createElement('div')
    contentHolder.className = 'modal-content'
    contentHolder.innerHTML = content
    @modal.appendChild contentHolder
    # Append modal to DocumentFragment
    docFrag.appendChild @modal
    # Append DocumentFragment to body
    document.body.appendChild docFrag
    return

  extendDefaults = (source, properties) ->
    property = undefined
    for property of properties
      `property = property`
      if properties.hasOwnProperty(property)
        source[property] = properties[property]
    source

  initializeEvents = ->
    if @closeButton
      @closeButton.addEventListener 'click', @close.bind(this)
    if @overlay
      @overlay.addEventListener 'click', @close.bind(this)
    return

  transitionSelect = ->
    el = document.createElement('div')
    if el.style.WebkitTransition
      return 'webkitTransitionEnd'
    if el.style.OTransition
      return 'oTransitionEnd'
    'transitionend'

  @Modal = ->
    # Create global element references
    @closeButton = null
    @modal = null
    @overlay = null
    # Determine proper prefix
    @transitionEnd = transitionSelect()
    # Define option defaults
    defaults =
      className: 'fade-and-drop'
      closeButton: true
      content: ''
      maxWidth: 600
      minWidth: 280
      overlay: true
    # Create options by extending defaults with the passed in arugments
    if arguments[0] and typeof arguments[0] == 'object'
      @options = extendDefaults(defaults, arguments[0])
    return

  # Public Methods

  Modal::close = ->
    _ = this
    @modal.className = @modal.className.replace(' modal-open', '')
    @overlay.className = @overlay.className.replace(' modal-open', '')
    @modal.addEventListener @transitionEnd, ->
      _.modal.parentNode.removeChild _.modal
      return
    @overlay.addEventListener @transitionEnd, ->
      if _.overlay.parentNode
        _.overlay.parentNode.removeChild _.overlay
      return
    return

  Modal::open = ->
    buildOut.call this
    initializeEvents.call this
    window.getComputedStyle(@modal).height
    @modal.className = @modal.className + (if @modal.offsetHeight > window.innerHeight then ' modal-open modal-anchored' else ' modal-open')
    @overlay.className = @overlay.className + ' modal-open'
    return

  return
