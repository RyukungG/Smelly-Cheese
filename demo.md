consult('Smelly_cheese.pl').

0. Competency Question

1. What is the type of X cheese?

// isSoftCheese(X): cheeses X is soft and not hard.
```
isSoftCheese(feta).
```

// isSoftCheese(X): cheeses X is soft and not hard and 
                    has a component of white safe for consumption mold.
```
isSoftCheese(brie).
```

// isSemiFirmCheese(X): cheese X is soft and hard at the same time.
```
isSemiFirmCheese(cheddar).
```

// isHardCheese(X): cheese X is hard but not soft
```
isHardCheese(parmesan).
```

// isAgedCheese(X): cheese X is aged and not fresh
```
isAgedCheese(parmigiano).
```

// isFreshCheese(X): cheese X is soft and fresh but not hard
```
isFreshCheese(feta).
```

// isBlueCheese(X): cheese X is aged and contain safe for consumption blue mold.
```
isBlueCheese(gorgonzola).
```

2. Can we determine if X cheese tastes mild or sharp?

// isSharpTasting(X): aged cheese
```
isSharpTasting(brie).
```

// isMildTasting(X): not aged cheese
```
isMildTasting(almond_cheese).
```

3. Can vegetarian X eat Y cheese?
Person who is vegetarian can only eat cheese that does not contain animal based rennet.
```
canConsume(pakorn, brie).
```

4. Can vegan X eat Y cheese?
Person who is vegan can only eat cheese 
that does not contain animal milk and animal based rennet.
```
canConsume(karen, cottage_cheese). // F ( / rennet X milk )
canConsume(karen, cashew_cheese). // T ( / rennet / milk )
```

5. Can lactose-intolerance people X eat Y cheese?
Person who has lactose intolerance can eat cheese that does not contian 
milk from animal which always have lactose
```
canConsume(pawitchaya, almond_cheese). // T
canConsume(pawitchaya, cottage_cheese). // F ( cow milkd detected )
```

6. Can X cheese be stored in place Y?
In order to store cheese, the place temperature should be 
lower than the cheese melting point.
```
canBeStoredIn(almond_cheese, cellar). // T
canBeStoredIn(cheddar, heated_oven). // F
canBeStoredIn(parmesan, room_with_no_air_conditioner). // T
```

7. Does X cheese have formed crystal?
Aged hard cheese that is made from animal milk will form crystal.
```
containCrystal(parmigiano). // T ( isHardCheese isAgedCheese Animal-Milk )
containCrystal(granaPadano). // T ( isHardCheese isAgedCheese Animal-Milk )
containCrystal(brie). // F ( X isHardCheese )
containCrystal(gouda). // F ( X isHardCheese )
```