extends CanvasLayer

@onready var coin_label: Label = $Label

func _process(delta:float) -> void:
	coin_label.text = "Coin : " + str(Core.coin)
