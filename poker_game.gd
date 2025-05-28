extends Node2D

const RANKS = ["02", "03", "04", "05", "06", "07", "08", "09", "10", "J", "Q", "K", "A"]
const SUITS = ["clubs", "diamonds", "hearts", "spades"]

@export var card_scene: PackedScene

var deck: Array = []

func _ready():
	_create_deck()
	_shuffle_deck()

	# Por ejemplo: repartir 5 cartas en la mesa
	var spacing = 100
	for i in range(5):
		var card_data = draw_card()
		if card_data == null:
			print("No hay más cartas en el mazo.")
			return
		var card = card_scene.instantiate()
		add_child(card)
		card.position = Vector2(100 + spacing * i, 200)
		card.set_card(card_data.rank, card_data.suit)

# Crear el mazo sin repeticiones
func _create_deck():
	deck.clear()
	for suit in SUITS:
		for rank in RANKS:
			deck.append({ "rank": rank, "suit": suit })

# Barajar el mazo
func _shuffle_deck():
	deck.shuffle()

# Robar una carta del mazo (la elimina del mazo)
func draw_card():
	if deck.is_empty():
		return null
	var data = deck.pop_back() # pop_back() es como robar la carta del final
	return CardData.new(data["rank"], data["suit"])

# Clase auxiliar para representar la carta
class CardData:
	var rank: String
	var suit: String

	func _init(r, s):
		rank = r
		suit = s
