%Cheese
cheese(mozzarella).
cheese(feta).
cheese(ricotta).
cheese(cottage_Cheese).
cheese(almond_Cheese).
cheese(cashew_Cheese).
cheese(camembert).
cheese(brie).
cheese(parmesan).
cheese(parmigiano).
cheese(cheddar).
cheese(gorgonzola).
cheese(granaPadano).
cheese(edam).
cheese(gouda).
cheese(roquefort).

isFresh(mozzarella).
isFresh(feta).
isFresh(ricotta).
isFresh(cottage_Cheese).
isFresh(almond_Cheese).
isFresh(cashew_Cheese).

% Soft Cheeses
isSoft(camembert).
isSoft(brie).

% Hard Cheeses
isHard(parmesan).
isHard(parmigiano).
isHard(granaPadano).

isAged(camembert).
isAged(brie).
isAged(parmesan).
isAged(parmigiano).
isAged(cheddar).
isAged(gorgonzola).
isAged(granaPadano).
isAged(edam).
isAged(gouda).
isAged(roquefort).

milk(cow_Milk).
milk(buffalo_Milk).
milk(goat_Milk).
milk(sheep_Milk).
milk(almond_milk).
milk(cashew_Milk).

animal(cow).
animal(buffalo).
animal(goat).
animal(sheep).

plant(almond).
plant(cashew).

madeFrom(cow_Milk, cow).
madeFrom(buffalo_Milk, buffalo).
madeFrom(goat_Milk, goat).
madeFrom(sheep_Milk, sheep).
madeFrom(almond_Milk, almond).
madeFrom(cashew_Milk, cashew).

mold(penicillium_roqueforti).
mold(white_surface_mold).

blue(penicillium_roqueforti).

white(white_surface_mold).

hasComponent(mozzarella, buffalo_Milk).
hasComponent(feta, goat_Milk).
hasComponent(ricotta, sheep_Milk).
hasComponent(cottage_Cheese, cow_Milk).
hasComponent(almond_Cheese, almond_Milk).
hasComponent(cashew_Cheese, cashew_Milk).
hasComponent(camembert, cow_Milk).
hasComponent(camembert, white_surface_mold).
hasComponent(brie, cow_Milk).
hasComponent(brie, white_surface_mold).
hasComponent(parmesan, cow_Milk).
hasComponent(parmigiano, cow_Milk).
hasComponent(cheddar, cow_Milk).
hasComponent(gorgonzola, cow_Milk).
hasComponent(gorgonzola, penicillium_roqueforti).
hasComponent(granapadano, cow_Milk).
hasComponent(edam, cow_Milk).
hasComponent(gouda, goat_Milk).
hasComponent(roquefort, sheep_Milk).
hasComponent(roquefort, penicillium_roqueforti).

country(italy).
country(greece).
country(america).
country(france).
country(england).
country(netherlands).

originatedFrom(mozzarella, italy).
originatedFrom(feta, greece).
originatedFrom(ricotta, italy).
originatedFrom(cottage_Cheese, america).
originatedFrom(almond_Cheese, america).
originatedFrom(cashew_Cheese, america).
originatedFrom(camembert, france).
originatedFrom(brie, france).
originatedFrom(parmesan, italy).
originatedFrom(parmigiano, italy).
originatedFrom(cheddar, england).
originatedFrom(gorgonzola, italy).
originatedFrom(granapadano, italy).
originatedFrom(edam, netherlands).
originatedFrom(gouda, netherlands).
originatedFrom(roquefort, france).

person(maroj).
person(pawitchaya).
person(pakorn).
person(supakrit).
person(tanabodee).
person(thanadol).
person(karen).

isVegan(karen).

isVegetarian(pakorn).

isLactoseIntolerant(pawitchaya).

% MeltAt({cheese}, {celsius})
MeltAt(camembert, 55).
MeltAt(brie, 55).
MeltAt(parmesan, 82).
MeltAt(parmigiano, 82).
MeltAt(granaPadano, 82).

% Every person who is not vegan, not vegetarian and does not have lactose intolerance can eat every cheese
CanConsume(x, y) :- \+ isVegan(x), \+ isVegetarian(x), \+ isLactoseIntolerant(x), cheese(y), person(x).

% Person who has LactoseIntolerance can eat cheese that does not contain milk from animals which always have lactose
CanConsume(X, Y) :- isLactoseIntolerant(X), cheese(Y), forall(milk(W), animal(Z), madeFrom(W, Z), \+ hasComponent(Y, W)).

% IsSoftCheese(X)
isSoftCheese(X) :- cheese(X), isSoft(X), \+ isHard(X).

% isSemiFirmCheese(X)
isSemiFirmCheese(X) :- cheese(X), isSoft(X), isHard(X).

% isHardCheese
isHardCheese(X) :- cheese(X), isHard(X), \+ isSoft(X).

% isAgedCheese(X)
isAgedCheese(X) :- cheese(X), isHard(X), isAged(X), \+ isFresh(X).

% isFreshCheese(X)
isFreshCheese(X) :- cheese(X), isSoft(X), isFresh(X), \+ isHard(X).
