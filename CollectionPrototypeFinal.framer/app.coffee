# This imports all the layers for "CollectionPrototype" into collectionprototypeLayers
s = Framer.Importer.load "imported/CollectionPrototype"



Framer.Defaults.Animation = {
	curve: 'cubic-bezier(0.4, 0, 0.2, 1)'
	time: .2
}

curve =
	spring: 'spring(400,30,0)'

color =
	canopy_green: "#23DEBF"
	scrim: "rgba(0,0,0,.03)"

animation =
	add: null
	remove: null

class CollectionRow extends Layer
	constructor: (options) ->
		super options

		@inCollection = true

		@width = Screen.width
		@height = 190
		@y = 720
		@backgroundColor = null

		@scrim = new Layer
			width: Screen.width
			height: @height
			superLayer: @
			backgroundColor: color.scrim
		@scrim.bringToFront()
		@scrim.opacity = 0

		@on Events.Click, =>
			if @inCollection
				@removeProduct()
			else
				@addProduct()

	stopAnimations: () =>
		s.OtherProducts.animateStop()
		s.ProductImageSmall.animateStop()
		@scrim.animateStop()

	addProduct: () =>
		@inCollection = true
		@stopAnimations()

		@productImageAnimation = s.ProductImageSmall.animate
			properties:
				scale: 1
				opacity: 1
# 				x: 36
			curve: curve.spring

		@scrim.animate
			properties:
				opacity: 0

		s.OtherProducts.animate
			properties:
				x: 152
			curve: curve.spring

	removeProduct: () =>
		@inCollection = false
		@stopAnimations()

		@productImageAnimation = s.ProductImageSmall.animate
			properties:
				scale: 0
				opacity: 0
# 				x: 0
			curve: curve.spring

		@scrim.animate
			properties:
				opacity: 1

		s.OtherProducts.animate
			properties:
				x: 32
			curve: curve.spring


activeRow = new CollectionRow

class OutlinedButton extends Layer
	constructor: (options) ->
		super options

		@backgroundColor = null
		@style =
			borderRadius: "8px"
			border: "2px solid #23DEBF"

# 		@touchButton = new Layer
# 			height: options.height
# 			width: options.width
# 			superLayer: @
# 			backgroundColor: color.canopy_green
# 			opacity: 0
# 		@touchButton.style =
# 			border: "2px solid #23DEBF"

		@buttonText = new Layer
			color: color.canopy_green
			width: @width
			superLayer: @
			backgroundColor: null
		@buttonText.html = "Create new collection"
		@buttonText.style =
			textAlign: "center"
			fontFamily: "Europa"
			lineHeight: @height - 6 + "px"

		@on Events.TouchStart, =>
			@backgroundColor = color.canopy_green
			@buttonText.color = "white"

		@on Events.TouchEnd, =>
			@backgroundColor = null
			@buttonText.color = color.canopy_green

createCollectionButton = new OutlinedButton
		width: 390
		height: 70
		y: 614
createCollectionButton.centerX()

s.RowScrim2.bringToFront()