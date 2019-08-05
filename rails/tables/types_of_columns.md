----------------------------------
#         Table Types 
----------------------------------
• String: 
  • Limited to 255 characters (depending on DBMS) 
  • Use for short text fields or input using textstrings 

• Text: 
  • Unlimited length (depending on DBMS)
  • Use for comments, blog posts etc. If it's captured via 
    textarea, use Text

• Integer: 
  • Whole numbers 

• Float: 
  • Decimal numbers stored with floating point precision 
  • Precision is fixed, which can be a problem for some calcs, 
    usually not good for math that needs to be accurate 
  • Also has problem with decimal fractions, because floats are   
    binary floating points

• Decimal: 
  • Decimal numbers stored that varies according to what is needed 
    by your calcs, used for math that needs to be accurate. 
  • Decimal floats are good for calcs with decimal fractions (money 
    or some shit) 
  • Ruby 'BigDecimal' also works when we need arbitrary floating 
    points, but don't really care if they're decimal or binary floating points. 

• Boolean: 
  • Used to store true/false attributes 
• Binary: 
  • Used to store images, movies, and other files in their original 
    raw format in chunks of data --> blobs 

• :primary_key 
  • placeholder that Rails translates to whatever the key datatype requires. Not really recommended 

