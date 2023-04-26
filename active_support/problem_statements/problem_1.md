# Problem 1

Extract name from each element of an enumerable

```ruby
products =[
  { name: 'Samsung', category: 'TV', rating: 4.5 },
  { name: 'Apple', category: 'Smartphone', rating: 4.8 },
  { name: 'Nike', category: 'Running Shoes', rating: 4.6 },
  { name: 'Sony', category: 'Headphones', rating: 4.4 },
  { name: 'Amazon', category: 'E-commerce', rating: 4.7 },
  { name: 'Microsoft', category: 'Laptop', rating: 4.3 },
  { name: 'Canon', category: 'Camera', rating: 4.5 },
  { name: 'LG', category: 'Appliances', rating: 4.2 },
  { name: 'Toyota', category: 'Automobiles', rating: 4.5 },
  { name: 'Adidas', category: 'Athletic Wear', rating: 4.7 }
]

```

## Solution

```ruby
products.each do |product|
  name_list << product[:name]
end
```

## Solution using active support

```ruby
products.pluck(:name)
```
