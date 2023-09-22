# helper-tools
Useful scripts and brief notes on data science topics that keep arising in my work. 

- `pca_orthogonality.R`

Calculating the relative orthogonality between two sets of variables in the principal component space by using the dot product.

$$
\mathbf{w} \cdot \mathbf{v} = |w||v|~cos~\theta
$$

- `pao2_fio2_interpolation.Rmd`
 
How different strategies for interpolating missing data from electronic health records affects results and derived measurements. 

## Colour blind safe colours

Okabe-Ito (2008) developed this palette which can be easily interpreted with different colour visual deficiencies for qualitiative scales. 

![](../img/palette-Okabe-Ito-1.png)

Orange, skyblue, bluish green, yellow, blue, vermilion, reddish purple, black

#E69F00 #56b4e9 #009e73 #f0e442 #0072b2 #d55e00 #cc79a7 #000000

See https://clauswilke.com/dataviz/color-basics.html and  https://clauswilke.com/dataviz/color-pitfalls.htm sections of the data vis handbook.  

ColorBrewer PiYG (pink to yellow-green) is also distinguishable by cvd individuals for diverging scales. 
