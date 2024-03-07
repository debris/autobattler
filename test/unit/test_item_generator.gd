extends GutTest

var item_generator: ItemGenerator

func test_item_generator_number_of_properties():
	item_generator = ItemGenerator.new()
	for tier in 10:
		var item = item_generator.generate_item(tier)
		assert_true(item.properties.size() >= 1)
		assert_true(item.properties.size() <= 4)