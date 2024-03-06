extends Object
class_name ItemGenerator

# item can be described by a few adjectives, but they will always be displayed in order of occurance here
static var adjectives: Array[String] = [
	"big",
]

var inner: RandomNumberGenerator

func _init(s: int = 0):
	inner = RandomNumberGenerator.new()
	inner.seed = s

func generate_item(tier: int) -> Item:
	var item = Item.new()

	# 1. TODO: perform 2-4 in a loop [1-4 times]
	var properties = randi_range(1, 4)

	for i in properties:
		# 2. TODO: pick random property (from seed)
		var property = random_property()	

		# 3. TODO: replace 0 with seed
		var generated_property = property._create_for_tier_and_seed(tier, randi())

		# 4. add property to the item
		item.properties.push_back(generated_property)

	return item

func random_property() -> ItemProperty:
	var max_index = ItemProperties.all.size() - 1
	var property = ItemProperties.all[inner.randi_range(0, max_index)]
	var reroll_value = inner.randi_range(1, 99)
	while reroll_value <= property.reroll:
		property = ItemProperties.all[inner.randi_range(0, max_index)]
		reroll_value = inner.randi_range(1, 99)
	return property
