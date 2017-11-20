
# TODO - this file needs to be cleaned up, documented
# TODO - should this viewer be abstracted into a separate repository?
loadStl = do ->

  binaryVector3 = (view, offset) ->
    v = new (THREE.Vector3)
    v.x = view.getFloat32(offset + 0, true)
    v.y = view.getFloat32(offset + 4, true)
    v.z = view.getFloat32(offset + 8, true)
    v

  loadBinaryStl = (buffer) ->
    # binary STL
    view = new DataView(buffer)
    size = view.getUint32(80, true)
    geom = new (THREE.Geometry)
    offset = 84
    i = 0
    while i < size
      normal = binaryVector3(view, offset)
      geom.vertices.push binaryVector3(view, offset + 12)
      geom.vertices.push binaryVector3(view, offset + 24)
      geom.vertices.push binaryVector3(view, offset + 36)
      geom.faces.push new (THREE.Face3)(i * 3, i * 3 + 1, i * 3 + 2, normal)
      offset += 4 * 3 * 4 + 2
      i++
    geom

  m2vec3 = (match) ->
    v = new (THREE.Vector3)
    v.x = parseFloat(match[1])
    v.y = parseFloat(match[2])
    v.z = parseFloat(match[3])
    v

  toLines = (array) ->
    lines = []
    h = 0
    i = 0
    while i < array.length
      if array[i] == 10
        line = String.fromCharCode.apply(null, array.subarray(h, i))
        lines.push line
        h = i + 1
      i++
    lines.push String.fromCharCode.apply(null, array.subarray(h))
    lines

  loadTextStl = (buffer) ->
    lines = toLines(new Uint8Array(buffer))
    index = 0

    scan = (regexp) ->
      while lines[index].match(/^\s*$/)
        index++
      r = lines[index].match(regexp)
      r

    scanOk = (regexp) ->
      r = scan(regexp)
      if !r
        throw new Error('not text stl: ' + regexp.toString() + '=> (line ' + index - 1 + ')' + '[' + lines[index - 1] + ']')
      index++
      r

    facetReg = /^\s*facet\s+normal\s+([^\s]+)\s+([^\s]+)\s+([^\s]+)/
    vertexReg = /^\s*vertex\s+([^s]+)\s+([^\s]+)\s+([^\s]+)/
    geom = new (THREE.Geometry)
    scanOk /^\s*solid\s(.*)/
    while !scan(/^\s*endsolid/)
      normal = scanOk(facetReg)
      scanOk /^\s*outer\s+loop/
      v1 = scanOk(vertexReg)
      v2 = scanOk(vertexReg)
      v3 = scanOk(vertexReg)
      scanOk /\s*endloop/
      scanOk /\s*endfacet/
      base = geom.vertices.length
      geom.vertices.push m2vec3(v1)
      geom.vertices.push m2vec3(v2)
      geom.vertices.push m2vec3(v3)
      geom.faces.push new (THREE.Face3)(base, base + 1, base + 2, m2vec3(normal))
    geom

  (buffer) ->
    try
      console.log 'load as text stl'
      return loadTextStl(buffer)
    catch ex
      console.log ex
      console.log 'load as binary stl'
      return loadBinaryStl(buffer)
    return

# # # # #

# https://gist.github.com/bellbind/477817982584ac8473ef

# TODO - this file is a mess, needs lots of clean up
class STLViewer extends Mn.LayoutView
  template: require './templates/stl_viewer'
  className: 'row'

  ui:
    view:   '[data-region=stl-viewer]'

  events:
    'dragover @ui.view':  'onDragOver'
    'drop @ui.view':      'onDrop'

  # onInput: (e) =>
  #   @openFile(e.target.files[0])

  onDragOver: (e) ->
    e.stopPropagation()
    e.preventDefault()
    e.originalEvent.dataTransfer = 'copy'
    return

  onDrop: (e) ->
    e.stopPropagation()
    e.preventDefault()
    file = e.originalEvent.dataTransfer.files[0]
    @openFile(file)
    return

  # TODO - auto-load example STL?
  onRender: ->
    setTimeout( @buildScene, 10 )

    url = @model.get('views').stl

    console.log url

    Backbone.Radio.channel('background').request('file', url)
    .then (stlBuffer) =>
      console.log 'FETCHED FILE!'
      console.log stlBuffer
      # @openFile(stlBuffer)

      toArrayBuffer = (buf) ->
        ab = new ArrayBuffer(buf.length)
        view = new Uint8Array(ab)
        i = 0
        while i < buf.length
          view[i] = buf[i]
          ++i
        ab

      buffer = toArrayBuffer(stlBuffer)

      console.log 'ARRAY BUFFER'
      console.log buffer

      geom = loadSTL(buffer)

      # Removes current STL, inserts new
      @scene.remove(@currentObj)
      @currentObj = new (THREE.Mesh)(geom, @material)
      @scene.add(@currentObj)

    # @openFile(e.target.files[0])

  openFile: (stlBuffer) =>
    # New Reader
    reader = new FileReader()

    # onLoad callback
    onLoad = (e) =>
      buffer = e.target.result
      geom = loadSTL(buffer)

      # Removes current STL, inserts new
      @scene.remove(@currentObj)
      @currentObj = new (THREE.Mesh)(geom, @material)
      @scene.add(@currentObj)
      return

    # Load callback
    reader.addEventListener 'load', onLoad, false

    # Reads
    reader.readAsArrayBuffer(stlBuffer)
    return true

  # Configuration for Three.js scene
  sceneConfig:

    size:
      width:  800
      height: 800

    camera:
      pos:
        x: 0
        y: 0
        z: 80

    # Lights
    lights: [
        color: 0xffffff
        pos:
          x: 0
          y: 100
          z: 100
      ,
        color: 0xffffff
        pos:
          x: 0
          y: -100
          z: -100
    ]

    # Material
    material:
      color:    0x009199 # 0x339900
      specular: 0x030303

  # Builds Three.js scene from @sceneConfig
  buildScene: =>

    # Renderer
    renderer = new THREE.WebGLRenderer()
    renderer.setSize(@sceneConfig.size.width, @sceneConfig.size.height)

    # View
    view = @ui.view[0]
    view.appendChild(renderer.domElement)

    # Camera
    ratio = (@sceneConfig.size.width / @sceneConfig.size.height)
    camera = new (THREE.PerspectiveCamera)(45, ratio, 1, 1000) # TODO - what are these values?
    pos = @sceneConfig.camera.pos
    camera.position.set pos.x, pos.y, pos.z

    # Controls
    # TODO - what control scheme works best here?
    # controls = new (THREE.TrackballControls)(camera, view)
    controls = new (THREE.OrbitControls)(camera, view)

    # Scene
    @scene = new (THREE.Scene)
    @scene.add new (THREE.AmbientLight)(0x666666)

    # Lights
    for l in @sceneConfig.lights
      light = new (THREE.DirectionalLight)(l.color)
      light.position.set(l.pos.x, l.pos.y, l.pos.z)
      @scene.add light

    # Material
    @material = new (THREE.MeshPhongMaterial)(@sceneConfig.material)

    # Loads default object (???)
    @currentObj = new (THREE.Mesh)(new (THREE.Geometry), @material)
    @scene.add @currentObj

    # Renders view from controls input
    looper = =>
      requestAnimationFrame(looper)
      controls.update()
      renderer.clear()
      renderer.render @scene, camera
      return

    # Invokes looper
    looper()

    return


# # # # #

module.exports = STLViewer

