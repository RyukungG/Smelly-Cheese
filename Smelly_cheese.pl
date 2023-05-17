% Cheese
cheese(mozzarella).
cheese(feta).
cheese(ricotta).
cheese(cottage_cheese).
cheese(almond_cheese).
cheese(cashew_cheese).
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

% Fresh Cheeses
isFresh(mozzarella).
isFresh(feta).
isFresh(ricotta).
isFresh(cottage_cheese).
isFresh(almond_cheese).
isFresh(cashew_cheese).

% Soft Cheeses
isSoft(camembert).
isSoft(brie).
isSoft(mozzarella).
isSoft(feta).
isSoft(ricotta).
isSoft(cottage_cheese).
isSoft(almond_cheese).
isSoft(cashew_cheese).
isSoft(cheddar).
isSoft(edam).
isSoft(gouda).

% Hard Cheeses
isHard(parmesan).
isHard(parmigiano).
isHard(granaPadano).
isHard(cheddar).
isHard(edam).
isHard(gouda).

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

milk(cow_milk).
milk(buffalo_milk).
milk(goat_milk).
milk(sheep_milk).
milk(almond_milk).
milk(cashew_milk).

rennet(cow_rennet).

animal(cow).
animal(buffalo).
animal(goat).
animal(sheep).

plant(almond).
plant(cashew).

madeFrom(cow_milk, cow).
madeFrom(buffalo_milk, buffalo).
madeFrom(goat_milk, goat).
madeFrom(sheep_milk, sheep).
madeFrom(almond_milk, almond).
madeFrom(cashew_milk, cashew).
madeFrom(cow_rennet, cow).

mold(penicillium_roqueforti).
mold(white_surface_mold).

blue(penicillium_roqueforti).

white(white_surface_mold).

isSafeForConsumption(penicillium_roqueforti).
isSafeForConsumption(white_surface_mold).

hasComponent(mozzarella, buffalo_milk).
hasComponent(feta, goat_milk).
hasComponent(ricotta, sheep_milk).
hasComponent(cottage_cheese, cow_milk).
hasComponent(almond_cheese, almond_milk).
hasComponent(cashew_cheese, cashew_milk).
hasComponent(camembert, cow_milk).
hasComponent(camembert, white_surface_mold).
hasComponent(brie, cow_milk).
hasComponent(brie, white_surface_mold).
hasComponent(parmesan, cow_milk).
hasComponent(parmigiano, cow_milk).
hasComponent(cheddar, cow_milk).
hasComponent(gorgonzola, cow_milk).
hasComponent(gorgonzola, penicillium_roqueforti).
hasComponent(granaPadano, cow_milk).
hasComponent(edam, cow_milk).
hasComponent(gouda, goat_milk).
hasComponent(roquefort, sheep_milk).
hasComponent(roquefort, penicillium_roqueforti).

% Rennet composed
hasComponent(mozzarella, cow_rennet).
hasComponent(feta, cow_rennet).
hasComponent(camembert, cow_rennet).
hasComponent(brie, cow_rennet).
hasComponent(parmesan, cow_rennet).
hasComponent(cheddar, cow_rennet).
hasComponent(gorgonzola, cow_rennet).
hasComponent(granaPadano, cow_rennet).
hasComponent(edam, cow_rennet).
hasComponent(gouda, cow_rennet).
hasComponent(roquefort, cow_rennet).

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
meltAt(mozzarella, 52).
meltAt(feta, 55).
meltAt(ricotta, 55).
meltAt(cottage_cheese, 55).
meltAt(almond_cheese, 55).
meltAt(cashew_cheese, 55).
meltAt(camembert, 55).
meltAt(brie, 55).
meltAt(parmesan, 82).
meltAt(parmigiano, 82).
meltAt(granaPadano, 82).
meltAt(cheddar, 65).
meltAt(edam, 65).
meltAt(gouda, 65).
meltAt(gorgonzola, 65).
meltAt(roquefort, 65).

% Place
place(heated_oven).
place(direct_sunlight).
place(room_with_no_air_conditioner).
place(room_with_air_conditioner).
place(refrigerator).
place(cellar).
place(cheese_cave).

% hasTemperature(X, Y)
hasTemperature(heated_oven, 90).
hasTemperature(direct_sunlight, 60).
hasTemperature(room_with_no_air_conditioner, 32).
hasTemperature(room_with_air_conditioner, 25).
hasTemperature(refrigerator, 4).
hasTemperature(cellar, 18).
hasTemperature(cheese_cave, 8).

% Consume
% Every person who is not vegan, not vegetarian and does not have lactose intolerance can eat every cheese
canConsume(X, Y) :- person(X), \+ isVegan(X), \+ isVegetarian(X), \+ isLactoseIntolerant(X), cheese(Y).

% Person who is vegetarian can eat cheese that does not have rennet that is made from animals
canConsume(X, Y) :- person(X), isVegetarian(X), cheese(Y), rennet(Z), animal(W), madeFrom(Z, W), \+ hasComponent(Y, Z).

% Person who is vegan can eat cheese that does not have animal products(milk, rennet)
canConsume(X, Y) :- person(X), isVegan(X), cheese(Y), \+ (milk(W), animal(Z), madeFrom(W, Z), hasComponent(Y, W)), \+ (rennet(V), animal(U), madeFrom(V, U), hasComponent(Y, V)).

% Person who has LactoseIntolerance can eat cheese that does not contain milk from animals which always have lactose
canConsume(X, Y) :- person(X), isLactoseIntolerant(X), cheese(Y), \+ (milk(W), animal(Z), madeFrom(W, Z), hasComponent(Y, W)).

% IsSoftCheese(X)
isSoftCheese(X) :- cheese(X), isSoft(X), \+ isHard(X).
isSoftCheese(X) :- cheese(X), isSoft(X), \+ isHard(X), mold(Y), white(Y), isSafeForConsumption(Y), hasComponent(X,Y).

% isSemiFirmCheese(X)
isSemiFirmCheese(X) :- cheese(X), isSoft(X), isHard(X).

% isHardCheese
isHardCheese(X) :- cheese(X), isHard(X), \+ isSoft(X).

% isAgedCheese(X)
isAgedCheese(X) :- cheese(X), isAged(X), \+ isFresh(X).

% isFreshCheese(X)
isFreshCheese(X) :- cheese(X), isSoft(X), isFresh(X), \+ isHard(X).

% isBlueCheese(X)
isBlueCheese(X) :- cheese(X), isAged(X), mold(Y), blue(Y), isSafeForConsumption(Y), hasComponent(X, Y).

% Crystal formation
containCrystal(X) :- cheese(X), isAgedCheese(X), isHardCheese(X), milk(Y), animal(Z), madeFrom(Y,Z), hasComponent(X,Y).

% canBeStoredIn(X, Y)
canBeStoredIn(X, Y) :- cheese(X), place(Y), meltAt(X, Z), hasTemperature(Y, W), (Z > W).

% IsSharpTasting: x cheese tastes sharp and mature if it is aged
isSharpTasting(X) :- cheese(X), isAged(X).

% IsMildTasting: x cheese tastes mild if it is not aged
isMildTasting(X) :- cheese(X), \+ isAged(X).
