#= require rich_text/piece
#= require rich_text/piece_list

class RichText.Text
  constructor: (string = "", attributes) ->
    piece = new RichText.Piece string, attributes
    @pieceList = new RichText.PieceList [piece]

  appendText: (text) ->
    @insertTextAtPosition(text, @getLength())

  insertTextAtPosition: (text, position) ->
    @pieceList.insertPieceListAtPosition(text.pieces, position)

  removeTextAtRange: (range) ->
    @pieceList.removePiecesInRange(range)

  replaceTextAtRange: (text, range) ->
    @removeTextAtRange(range)
    @insertTextAtPosition(text, range[0])

  addAttributesAtRange: (attributes, range) ->
    @pieceList.transformPiecesInRange range, (piece) ->
      piece.copyWithAdditionalAttributes(attributes)

  removeAttributeAtRange: (attribute, range) ->
    @pieceList.transformPiecesInRange range, (piece) ->
      piece.copyWithoutAttribute(attribute)

  setAttributesAtRange: (attributes, range) ->
    @pieceList.transformPiecesInRange range, (piece) ->
      piece.copyWithAttributes(attributes)

  getAttributesAtPosition: (position) ->
    @pieceList.getPieceAtPosition(position)?.getAttributes() ? {}

  getLength: ->
    @pieceList.getLength()

  eachRun: (callback) ->
    @pieceList.consolidate().eachPiece (piece) ->
      callback(piece.toString(), piece.getAttributes())

  inspect: ->
    @pieceList.inspect()
