Blotiu Mihnea-Andrei - 323CA
Tema 2 - Memoria lui Biju - 07.12.2021

rotp.asm:

In order to solve this task I used a function called "rotp_algo" 
that works as follows:

- Using the AL register to move the coresponding byte
from the key in reverse order;
- Realising the XOR operation between the AL value that was
assigned previously and the coresponding byte from the
plaintext;
- Storing the result in the current byte of the ciphertext;
- Updating the indexes for the next step and looping these
steps as many times as the length of the key/plaintext.

ages.asm:

In order to solve this task I used a function called "calcAges" 
that works as follows:

- First of all we are keeping count of the index of the date we
are currently calculating
- Comparing the present year with the current index one and
if the current index is bigger, we have to return 0. Else, we
are considering the age as the difference of these two years.
- Afterwords, comparing the months and the days and if needed
we substract 1 from the final age (in case in the current year
we did not yet arrive on the month/day the person was born)
- Going back in order to write the final answer in the all_ages
array.

columnar.asm:

In order to solve this task I used a function called "codingTransposition" 
that works as follows:

- First of all we are starting from the first position in the order
array and we check if we arrived at the end of the array or
not;
- If not we are considering the next column from the matrix
as exposed in the order array;
- We put the answer by taking the byte from len_cheie in len_cheie
bytes until the plaintext is finished;
- Then repeating these steps for the next column exposed in
the order array.

cache.asm:

In order to solve this task I calculated the tag and the offset
of the address given by using left and right shifts and the
used a function called "searchTags"  that works as follows:

- We are considering that we start with an empty matrix and
tags array so we currently have 0 tags;
- We are starting with the first tag and if it matches the calculated
tag we jump to the found part. If not, we are iterating over the
entire tags array that can have maximum CACHE_LINES elements.
- If we found somewhere in the array the tag we are searching for
we just bring in the reg the value from the coresponded position in the
matrix (coresponding line + the offset).
- If we did not find the tag in the array after iterating all over
it, first of all we generate the 8 bytes in the matrix at the to_replace
position starting from the tag.
- We also add the tag in the tags array at the to_replace position
- We load the corespondend value in the register and we end the 
function.
