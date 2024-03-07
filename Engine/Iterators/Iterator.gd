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

func until(pattern) -> UntilIterator:
	return UntilIterator.new(self, pattern)

func skip(number) -> SkipIterator:
	return SkipIterator.new(self, number)

func skip_until(pattern) -> SkipUntilIterator:
	return SkipUntilIterator.new(self, pattern)

func concat(other_iterator: Iterator) -> ConcatIterator:
	return ConcatIterator.new(self, other_iterator)

func alternate(other_iterator: Iterator) -> AlternateIterator:
	return AlternateIterator.new(self, other_iterator)

func zip(other_iterator: Iterator) -> ZipIterator:
	return ZipIterator.new(self, other_iterator)

func first() -> OptionIterator:
	return OptionIterator.new(next())

func for_each(for_each_function):
	var item = next()
	while item != null:
		for_each_function.call(item)
		item = next()

func reduce(accumulator, callable):
	var item = next()
	while item != null:
		accumulator = callable.call(accumulator, item)
		item = next()
	return accumulator

func find(pattern) -> OptionIterator:
	return skip_until(pattern).first()

func count(pattern = null) -> int:
	return reduce(0, func(accumulator, item):
		if pattern == null || pattern.call(item):
			return accumulator + 1
		return accumulator
	)

func compare(callable):
	var item = next()
	return reduce(item, callable)

func collect() -> Array:
	var result = []
	var value = next()
	while value != null:
		result.push_back(value)
		value = next()
	return result
