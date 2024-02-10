extends Object
class_name Iterator

func next():
	return null

func filter(filter_function) -> FilterIterator:
	return FilterIterator.new(self, filter_function)

func limit(number: int) -> LimitIterator:
	return LimitIterator.new(self, number)

func peekable() -> PeekIterator:
	return PeekIterator.new(self)

func skip(number) -> SkipIterator:
	return SkipIterator.new(self, number)

func skip_until(pattern) -> SkipUntilIterator:
	return SkipUntilIterator.new(self, pattern)

func first() -> Option:
	return Option.new(next())

func for_each(for_each_function):
	var item = next()
	while item != null:
		for_each_function.call(item)
		item = next()
