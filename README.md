# FETHCharacterPlanner
A Flutter project that will help end users plan their Fire Emblem Three Houses character builds better. It will allow for planning of the games houses, as well as user created houses.

## Data
All data for growth rates, character profiles, etc were pulled from https://serenesforest.net.

# NEED
CREST OF FLAME NEEDS TO BE RECOLORED TO MATCH ALL THEMES - NEEDS SOME EDIT SOFTWARE OR SOMETHING
POTNETIALLY CHANGE THEM TO BE THE ACCENT COLORS?!

---

## Important Notes
- Stats may be lower than expected in game as base stats and bonus stats (hidden and not) are not considered in the calculation. 
- Since stats are all based on random number generation these stats will only be a close approximation of what to expect. This is why there are 3 fully randomized stats generations, 1 low-luck generation, and 1 average generation which uses the past 4 calculations to find the average.

---

## How Stats Are Calculated

<dl>
    <dt><strong>Random Generations (1-3)</strong></dt>
        <dd>
            This uses the growth rates from the character and the character class to create the combined growth rates.
        </dd>
        <dd>
            For all levels of the class used in the combined growth rates a random number generator will generate a number for all stats. If that number is less than or equal to that growth rate number (RNG <= Stat Growth Rate Number) the stat will increase on this level up.
        </dd>
        <dd>
            This is repeated for all classes and levels up until they reach the characters final level.
        </dd>
    <dt><strong>Low-Luck Generation (4)</strong></dt>
        <dd>
            This uses the growth rates from the character and the character class to create the combined growth rates.
        </dd>
        <dd>
            For all classes for the character their combined growth rates will be calculated. Then this growth rate will be multiplied by how many levels are spent in that class (Growth Rate x levels). The answer will be rounded to nearest whole number, and that will be how many times that stat has grown while within that class.
        </dd>
        <dd>
            <strong>Example 1:</strong> 75% growth rate x 10 levels = 7.5 --> 8 stat increases in that class.
        </dd>
        <dd>
            <strong>Example 2:</strong> 32% growth rate x 10 levels = 3.2 --> 3 stat increases in that class.
        </dd>
    <dt><strong>Average Generation (5)</strong></dt>
        <dd>
            This takes the stats of the past four generations and finds the average stats for the character.
        </dd>
</dl>

---

## Themes

### Default

#### FETH Purple
Dark theme based on the purple UI present in Fire Emblem Three Houses

### Generic

#### Light
short Descriptions

#### Dark
short Descriptions

### Houses

#### Ashen Wolves
short Descriptions

#### Black Eagles
short Descriptions

#### Black Eagles (Alternative)
short Descriptions

#### Blue Lions
short Descriptions

#### Blue Lions (Alternative)
short Descriptions

#### Golden Deer
short Descriptions
