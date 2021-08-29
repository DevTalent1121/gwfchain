# GWFS

GLobal Wealth & Freedom World StableCoin

Continent	    Population (2020)   Area (Km²)      Density (P/Km²)	World Population Share
----------------------------------------------------------------------------------------------
1	Asia	            4,641,054,775	31,033,131	    150	            59.54%
2	Africa	            1,340,598,147	29,648,481	    45	            17.20%
3	Europe	            747,636,026	    22,134,900	    34	            9.59%
4	North America	    592,072,212	    21,330,000	    28	            7.60%
5	South America	    430,759,766	    17,461,112	    25	            5.53%
6	Australia/Oceania	43,111,704	    8,486,460   	5	            0.55%


## GWFS price is based off these fiat currencies

- Asia         
    - KUWAITI DINAR 
    - BAHRAINI DINAR
    - OMANI RIYAL
- Africa 
    - Libyan Dinar
    - Tunisian Dinar
    - Ghanaian Cedi
- Europe       
    - European euro
    - Switzerland Swiss franc
    - Russia Russian ruble
- North America   
    - USA
    - Canada 
    - Mexico
- South America    
    - Brazilian real
    - Bolivian boliviano
    - Guatemalan quetzal

## GWFS Price calculated using these historic values of each Fiat currency

- Mean3Hr
- Mean12Hr
- Mean24Hr
- Mean84Hr
- Mean1Wk
- Mean1Mo
- Mean3Mo
- Mean6Mo
- Mean1Yr   

## GWFS Price Calculation

Current Price = 
```
RoundTo 10th (
    (
        ((Fiat1 Mean3hr + ... Fiat1 Mean 1Yr) / 11)
        + ...
        ((Fiat15 Mean3Hr + ... Fiat15 Mean 1Yr) / 11)
    ) / 15
)
```

**Example 2.34**

## GWFS Update Interval

Fiat prices are polled every 3 hours and are based off
- 19 Years of historical data
- 16 reliable data sources