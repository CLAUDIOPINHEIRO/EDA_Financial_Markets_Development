# EDA_Financial_Markets_Development
Basic Exploration: Development of selected Financial Markets during Brexit and US Election -R, D3js



## Final Visualisation
The final visualisation can be accessed under: http://bl.ocks.org/MertonBoerlin/raw/ac1ef350c4b571a7a69b7f74d6249e92/

## Summary

This visualisation project began with a question: 

**How did financial markets develop during the Brexit Referendum and the US Election?**

In the final visualisation, the viewer is invited to explore this question freely by choosing the currency lens as well as the indexes to be highlighted. 

Three main aspects in the data:

1. During the days of the Brexit Referendum (looking through the currency lens of US Dollars), all indexes suffered daily losses that were more severe than the general noise of ups and downs you would normaly observe. At the same time, the price for Gold went up. These drops in the indexes turned to the normal pattern again shortly after. One interpretation for this can be, that an "unexpected" outcome of a socio-economic event can lead to more perceived uncertainty in the markets which leads to indexes falling in price, while Gold being perceived as a more stable and secure investment and therefore going up. 

2. If the currency lens is changed to British Pound an interesting effect can be observed. US Indexes gained in price and did not suffer losses during the Brexit Referendum. This can be explained by the British Pound falling in Price in regard to US Dollar. This drop in currency price was so strong for British Pound to US Dollars, that it outbalanced the drop of US Indexes, turning a daily negative change in USD to a positive change when looking through the lens of GBP.  

3. Comparing the changes of financial market prices between the Brexit Referendum and the US Election, it seems like the US Election had "shocked" the markets less.

## Process

Financial market data was collected from different sources. This was done using the [Quandl-Plattform](https://www.quandl.com/). Data for the daily progressions of the indexes DAX , S&P, Nasdaq, FTSE and Dow Jones were retrieved as well as the daily development of Gold price and the currency pairs USD/EUR, USD/GBP. 

Through [Data Wrangling with R](https://github.com/MertonBoerlin/EDA_Financial_Markets_Development/blob/master/Data_Wrangling.R), a single csv file was created including info on the daily change in price of the above stated indexes and gold in regard to different currencies.

## Design

As a design, a multi-series line chart with object constancy was chosen. The viewer can select the indexes by marking them and in a second step selecting the currency lens in a menu. By changing the lens, the data will automatically and seemlessly adapt. 

As an alternative, a visualisation via boxplots or barcharts might have also worked in making the degree of change for different indexes visible. For plotting the daily change of multiple indexes simultaneously, a line chart design works well, reduces visual complexity and was therefore chosen.

## Feedback

The first visualisation ([index1.html](https://github.com/MertonBoerlin/EDA_Financial_Markets_Development/blob/master/index1.html)) was shared in the udacity forum as well as with three friends from a shared coworking space. In the Udacity Forum, no written Feedback was received in the feedback-thread.

When I asked three friends to review the visualisation, there was positive and negative oral feedback. Positive feedback was received from Reviewer A. Reviewer A liked the overall strategy, to look at the development of financial markets through the lens of different currencies and gave a thumbs up!

When giving Reviewer B and Reviewer C the choice between a visualisation of the overall development vs. the daily change of the financial markets, both were in favor of daily change. Hence, the converted data portraying the daily change was used in the final visualisation. This choice was not done easily but considered through weighing pros and cons. 

One major advantage of daily change is that scope-differences in the data are leveled out. While FTSE is over 20000 points in USD for example, Gold is only about 1200-1300 points. This means that including them in one graph with a continuous y-axis has a disadvantage:

- If FTSE falls 1%, this is 200 points. If Gold also falls 1% on the same day, it is only about 12.5 points and therefore less visible in the visualisation. Using daily change as the y-axis accounts for that and portrays a 1% change of gold and FTSE in the same way.
- A disadvantage of using daily change is that it does not portray the overall development of the indexes well. If FTSE falls 1% on one day (200 points) to 19800 and the next day gains 1% (198 points) to reach 19998, a reduction of 2 data points is not visible when using daily change but instead looks like it completely balanced itself out.

In the final visualisation, daily change was used because accounting for scope-differences of indexes was considered more important for the purpose of this visualisation than looking at the overall development.

From the technical side, an adjustment was made through the help of a truly awesome udacity forum mentor: Before, object constancy was not implemented the right way. As a result, more lines were added to the graph when changing the currency lens. The existing lines of each index did not change, but stayed the same. The error in the code was that a wrong column name in the csv was used to select the series of data to be portrayed. When the column name was changed to the one that marked the different currency to each index value, object constancy worked. 

## References

http://stackoverflow.com/questions/3171426/compare-two-data-frames-to-find-the-rows-in-data-frame-1-that-are-not-present-in

https://cran.r-project.org/web/packages/compare/vignettes/compare-intro.pdf

http://stackoverflow.com/questions/7531868/how-to-rename-a-single-column-in-a-data-frame-in-r

https://www.youtube.com/watch?v=fqjltQoF9-g

https://www.r-bloggers.com/date-formats-in-r/

http://stackoverflow.com/questions/7146435/change-row-order-in-a-matrix-dataframe

https://egret.psychol.cam.ac.uk/statistics/R/enteringdata.html

http://stackoverflow.com/questions/4862178/remove-rows-with-nas-missing-values-in-data-frame

https://en.wikibooks.org/wiki/R_Programming/Times_and_Dates

http://stackoverflow.com/questions/27994590/finding-growth-in-dataframe-in-r

http://bl.ocks.org/nsonnad/4175202

https://groups.google.com/forum/#!topic/d3-js/QWDA5Z9IjSU

http://stackoverflow.com/questions/10085806/extracting-specific-columns-from-a-data-frame

https://leanpub.com/D3-Tips-and-Tricks/read#leanpub-auto-line

http://bl.ocks.org/nsonnad/4175202

http://stackoverflow.com/questions/29352970/dimple-js-add-vertical-line

http://www.d3noob.org/2013/01/making-dashed-line-in-d3js.html

http://stackoverflow.com/questions/24446465/d3-dashed-line-from-a-datapoint-to-an-axis-seen-in-dimplejs-org

http://www.d3noob.org/2012/12/adding-axis-labels-to-d3js-graph.html

## Data

Dow Jones: https://www.quandl.com/data/YAHOO/INDEX_DJ

S&P: https://www.quandl.com/data/GOOG/LON_IGUS

DAX: https://www.quandl.com/data/YAHOO/INDEX_GDAXI

FTSE: http://www.digitallook.com/index/FTSE_250/prices/download

NASDAQ: https://indexes.nasdaqomx.com/Index/Overview/COMP

Gold: https://www.quandl.com/data/WGC/GOLD_DAILY_USD


EUR/USD: https://www.quandl.com/data/BOE/XUDLERD

USD/GBP: https://www.quandl.com/data/CUR/GBP
