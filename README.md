# Luvy

Lightweight, functional array for Lua with a Ruby-inspired flavor.

## API Reference

- `new(...)`: Create a new Luvy.Array with optional initial elements.

  ```lua
  local arr = Luvy.Array(1, 2, 3)
  print(arr)  -- {1, 2, 3}
  ```

- `__add(other)`: Define addition behavior with `+` operator.

  ```lua
  local arr1 = Luvy.Array(1, 2, 3)
  local arr2 = Luvy.Array(4, 5, 6)
  local result = arr1 + arr2
  print(result)  -- {1, 2, 3, 4, 5, 6}
  ```

- `__sub(other)`: Define subtraction behavior with `-` operator.

  ```lua
  local arr1 = Luvy.Array(1, 2, 3, 4, 5)
  local arr2 = Luvy.Array(2, 4)
  local result = arr1 - arr2
  print(result)  -- {1, 3, 5}
  ```

- `__mul(n)`: Define multiplication behavior with `*` operator.

  ```lua
  local arr = Luvy.Array(1, 2, 3)
  local result = arr * 2
  print(result)  -- {1, 2, 3, 1, 2, 3}
  ```

- `__div(n)`: Define division behavior with `/` operator.

  ```lua
  local arr = Luvy.Array(1, 2, 3, 4, 5, 6)
  local result = arr / 2
  print(result)  -- {{1, 2}, {3, 4}, {5, 6}}
  ```

- `__unm()`: Define unary minus behavior with `-` operator.

  ```lua
  local arr = Luvy.Array(1, 2, 3)
  local result = -arr
  print(result)  -- {3, 2, 1}
  ```

- `__concat()`: Define concatenation behavior with `..` operator.

  ```lua
  local arr1 = Luvy.Array(1, 2, 3)
  local arr2 = Luvy.Array(4, 5, 6)
  local result = arr1 .. arr2
  print(result)  -- {1, 2, 3, 4, 5, 6}
  ```

- `__gt(other)`: Define greater than behavior with `>` operator.

  ```lua
  local arr1 = Luvy.Array(1, 2, 3, 4)
  local arr2 = Luvy.Array(1, 2, 3)
  print(arr1 > arr2)  -- true
  ```

- `__ge(other)`: Define greater than or equal to behavior with `>=` operator.

  ```lua
  local arr1 = Luvy.Array(1, 2, 3)
  local arr2 = Luvy.Array(1, 2, 3)
  print(arr1 >= arr2)  -- true
  ```

- `__lt(other)`: Define less than behavior with `<` operator.

  ```lua
  local arr1 = Luvy.Array(1, 2, 3)
  local arr2 = Luvy.Array(1, 2, 3, 4)
  print(arr1 < arr2)  -- true
  ```

- `__le(other)`: Define less than or equal to behavior with <= operator.

  ```lua
  local arr1 = Luvy.Array(1, 2, 3)
  local arr2 = Luvy.Array(1, 2, 3)
  print(arr1 <= arr2)  -- true
  ```

- `__len()`: Define length behavior with `#` operator.

  ```lua
  local arr = Luvy.Array(1, 2, 3)
  print(#arr)  -- 3
  ```

- `length()`: Return the number of elements in the array.

  ```lua
  local arr = Luvy.Array(1, 2, 3)
  print(arr:length())  -- 3
  ```

- `push(item)`: Add an element to the end of the array.

  ```lua
  local arr = Luvy.Array(1, 2)
  arr:push(3)
  print(arr)  -- {1, 2, 3}
  ```

- `pop()`: Remove and return the last element of the array.

  ```lua
  local arr = Luvy.Array(1, 2, 3)
  local last = arr:pop()
  print(last)  -- 3
  print(arr)   -- {1, 2}
  ```

- `shift()`: Remove and return the first element of the array.

  ```lua
  local arr = Luvy.Array(1, 2, 3)
  local first = arr:shift()
  print(first)  -- 1
  print(arr)    -- {2, 3}
  ```

- `unshift(item)`: Add an element to the beginning of the array.

  ```lua
  local arr = Luvy.Array(2, 3)
  arr:unshift(1)
  print(arr)  -- {1, 2, 3}
  ```

- `at(index)`: Retrieve an element at a specific index (supports negative indexing).

  ```lua
  local arr = Luvy.Array(10, 20, 30, 40)
  print(arr:at(1))   -- 10
  print(arr:at(-1))  -- 40
  ```

- `first()`: Return the first element of the array.

  ```lua
  local arr = Luvy.Array(10, 20, 30)
  print(arr:first())  -- 10
  ```

- `last()`: Return the last element of the array.

  ```lua
  local arr = Luvy.Array(10, 20, 30)
  print(arr:last())  -- 30
  ```

- `each(predicate)`: Iterate over each element and apply a function.

  ```lua
  local arr = Luvy.Array(1, 2, 3)
  local sum = 0
  arr:each(function(x) sum = sum + x end)
  print(sum)  -- 6
  ```

- `map(predicate)`: Create a new array by transforming each element.

  ```lua
  local arr = Luvy.Array(1, 2, 3)
  local doubled = arr:map(function(x) return x * 2 end)
  print(doubled)  -- {2, 4, 6}
  print(arr)      -- {1, 2, 3} (original unchanged)
  ```

- `map_(predicate)`: Modify the array in-place by transforming each element.

  ```lua
  local arr = Luvy.Array(1, 2, 3)
  arr:map_(function(x) return x * 2 end)
  print(arr)  -- {2, 4, 6}
  ```

- `select(predicate)`: Create a new array with elements that pass a test.

  ```lua
  local arr = Luvy.Array(1, 2, 3, 4, 5)
  local evens = arr:select(function(x) return x % 2 == 0 end)
  print(evens)  -- {2, 4}
  print(arr)    -- {1, 2, 3, 4, 5} (original unchanged)
  ```

- `select_(predicate)`: Modify the array in-place, keeping only elements that pass a test.

  ```lua
  local arr = Luvy.Array(1, 2, 3, 4, 5)
  arr:select_(function(x) return x % 2 == 0 end)
  print(arr)  -- {2, 4}
  ```

- `reject(predicate)`: Create a new array with elements that fail a test.

  ```lua
  local arr = Luvy.Array(1, 2, 3, 4, 5)
  local odds = arr:reject(function(x) return x % 2 == 0 end)
  print(odds)  -- {1, 3, 5}
  print(arr)   -- {1, 2, 3, 4, 5} (original unchanged)
  ```

- `reject_(predicate)`: Modify the array in-place, removing elements that pass a test.

  ```lua
  local arr = Luvy.Array(1, 2, 3, 4, 5)
  arr:reject_(function(x) return x % 2 == 0 end)
  print(arr)  -- {1, 3, 5}
  ```

- `reduce(accumulator, predicate)`: Reduce the array to a single value using a function.

  ```lua
  local arr = Luvy.Array(1, 2, 3, 4)
  local sum = arr:reduce(0, function(acc, x) return acc + x end)
  print(sum)  -- 10
  ```

- `join(separator)`: Convert the array to a string with a specified separator.

  ```lua
  local arr = Luvy.Array("a", "b", "c")
  print(arr:join(","))   -- "a,b,c"
  print(arr:join(" - "))  -- "a - b - c"
  ```

- `include(item)`: Check if the array contains a specific element.

  ```lua
  local arr = Luvy.Array(1, 2, 3)
  print(arr:include(2))  -- true
  print(arr:include(4))  -- false
  ```

- `clear()`: Remove all elements from the array.

  ```lua
  local arr = Luvy.Array(1, 2, 3)
  arr:clear()
  print(arr)  -- {}
  ```

- `empty()`: Check if the array has no elements.

  ```lua
  local arr1 = Luvy.Array()
  local arr2 = Luvy.Array(1, 2, 3)
  print(arr1:empty())  -- true
  print(arr2:empty())  -- false
  ```

- `all(predicate)`: Check if all elements pass a test.

  ```lua
  local arr1 = Luvy.Array(2, 4, 6)
  local arr2 = Luvy.Array(1, 2, 3)
  print(arr1:all(function(x) return x % 2 == 0 end))  -- true
  print(arr2:all(function(x) return x % 2 == 0 end))  -- false
  ```

- `any(predicate)`: Check if at least one element passes a test.

  ```lua
  local arr1 = Luvy.Array(1, 3, 5)
  local arr2 = Luvy.Array(1, 2, 3)
  print(arr1:any(function(x) return x % 2 == 0 end))  -- false
  print(arr2:any(function(x) return x % 2 == 0 end))  -- true
  ```

- `index_of(item)`: Find the first index of a specific element.

  ```lua
  local arr = Luvy.Array(10, 20, 30, 20)
  print(arr:index_of(20))  -- 2
  print(arr:index_of(40))  -- nil
  ```

- `count(predicate)`: Count total elements or elements passing a test.

  ```lua
  local arr = Luvy.Array(1, 2, 2, 3, 2)
  print(arr:count())                     -- 5
  print(arr:count(function(x) return x == 2 end))  -- 3
  ```

- `uniq()`: Remove duplicate elements from the array (non-destructive).

  ```lua
  local arr = Luvy.Array(1, 2, 2, 3, 3, 4)
  local unique = arr:uniq()
  print(unique)  -- {1, 2, 3, 4}
  ```

- `uniq_()`: Remove duplicate elements from the array (destructive).

  ```lua
  local arr = Luvy.Array(1, 2, 2, 3, 3, 4)
  arr:uniq_()
  print(arr)  -- {1, 2, 3, 4}
  ```

- `flatten()`: Remove nested array structures one level deep (non-destructive).

  ```lua
  local arr = Luvy.Array(1, Luvy.Array(2, 3), Luvy.Array(4, Luvy.Array(5, 6)))
  local flattened = arr:flatten()
  print(flattened)  -- {1, 2, 3, 4, {5, 6}}
  ```

- `flatten_()`: Remove nested array structures one level deep (destructive).

  ```lua
  local arr = Luvy.Array(1, Luvy.Array(2, 3), Luvy.Array(4, Luvy.Array(5, 6)))
  arr:flatten_()
  print(arr)  -- {1, 2, 3, 4, {5, 6}}
  ```

- `deep_flatten()`: Recursively flattens all nested arrays (non-destructive).

  ```lua
  local arr = Luvy.Array(1, Luvy.Array(2, 3), Luvy.Array(4, Luvy.Array(5, 6)))
  local flattened = arr:flatten()
  print(flattened)  -- {1, 2, 3, 4, 5, 6}
  ```

- `deep_flatten_()`: Recursively flattens all nested arrays (destructive).

  ```lua
  local arr = Luvy.Array(1, Luvy.Array(2, 3), Luvy.Array(4, Luvy.Array(5, 6)))
  arr:flatten_()
  print(arr)  -- {1, 2, 3, 4, 5, 6}
  ```

- `reverse()`: Reverse array order (non-destructive).

  ```lua
  local arr = Luvy.Array(1, 2, 3, 4)
  local reversed = arr:reverse()
  print(reversed)  -- {4, 3, 2, 1}
  ```

- `reverse_()`: Reverse array order (destructive).

  ```lua
  local arr = Luvy.Array(1, 2, 3, 4)
  arr:reverse_()
  print(arr)  -- {4, 3, 2, 1}
  ```

- `sort()`: Sort array elements (non-destructive).

  ```lua
  local arr = Luvy.Array(3, 1, 4, 2)
  local sorted = arr:sort()
  print(sorted)  -- {1, 2, 3, 4}
  ```

- `sort_()`: Sort array elements (destructive).

  ```lua
  local arr = Luvy.Array(3, 1, 4, 2)
  arr:sort_()
  print(arr)  -- {1, 2, 3, 4}
  ```

- `intersection(other)`: Find common elements between arrays.

  ```lua
  local arr1 = Luvy.Array(1, 2, 3, 4)
  local arr2 = Luvy.Array(3, 4, 5, 6)
  local common = arr1:intersection(arr2)
  print(common)  -- {3, 4}
  ```

- `union(other)`: Combine unique elements from two arrays.

  ```lua
  local arr1 = Luvy.Array(1, 2, 3)
  local arr2 = Luvy.Array(3, 4, 5)
  local combined = arr1:union(arr2)
  print(combined)  -- {1, 2, 3, 4, 5}
  ```

- `difference(other)`: Elements in the first array not in the second.

  ```lua
  local arr1 = Luvy.Array(1, 2, 3, 4)
  local arr2 = Luvy.Array(3, 4, 5, 6)
  local diff = arr1:difference(arr2)
  print(diff)  -- {1, 2}
  ```

- `slice(start_idx, end_idx)`: Extract a portion of the array.

  ```lua
  local arr = Luvy.Array(1, 2, 3, 4, 5)
  local portion = arr:slice(2, 4)
  print(portion)  -- {2, 3, 4}
  ```

- `take(n)`: Get the first n elements.

  ```lua
  local arr = Luvy.Array(1, 2, 3, 4, 5)
  local first = arr:take(3)
  print(first)  -- {1, 2, 3}
  ```

- `drop(n)`: Skip the first n elements.

  ```lua
  local arr = Luvy.Array(1, 2, 3, 4, 5)
  local remaining = arr:drop(2)
  print(remaining)  -- {3, 4, 5}
  ```

- `chunk(predicate)`: Divide the array into chunks.

  ```lua
  local arr = Luvy.Array(1, 2, 3, 4, 5, 6)
  local chunked = arr:chunk(2)
  print(chunked)  -- {{1, 2}, {3, 4}, {5, 6}}
  ```

- `transpose()`: Assumes that self is an array of arrays and convert rows to columns (non-destructive).

  ```lua
  local arr = Luvy.Array(Luvy.Array(1, 2, 3), Luvy.Array(4, 5, 6))
  local transposed = arr:transpose()
  print(transposed)  -- {{1, 4}, {2, 5}, {3, 6}}
  ```

- `transpose_()`: Assumes that self is an array of arrays and convert rows to columns (destructive).

  ```lua
  local arr = Luvy.Array(Luvy.Array(1, 2, 3), Luvy.Array(4, 5, 6))
  arr:transpose_()
  print(arr)  -- {{1, 4}, {2, 5}, {3, 6}}
  ```

- `zip()`: Merges elements by pairing columns from the current array with columns from other arrays.

  ```lua
  local a = Luvy.Array(4, 5, 6)
  local b = Luvy.Array(7, 8, 9)
  local zipped = Luvy.Array(1, 2, 3):zip(a, b)
  print(zipped)  -- {{1, 4, 7}, {2, 5, 8}, {3, 6, 9}}
  local c = Luvy.Array(8)
  local zipped2 = a:zip(Luvy.Array(1, 2), c)
  print(zipped2) -- {{4, 1, 8}, {5, 2, nil}, {6}}
  ```

### Destructive vs Non-Destructive Methods

Most methods come in two variants:

- Non-destructive: Returns a new array (e.g., `map()`)
- Destructive: Modifies the original array (e.g., `map_()`)
