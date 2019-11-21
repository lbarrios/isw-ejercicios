#!/usr/bin/env bash

curlOut=`curl -s "http://localhost:8081/createCart?clientId=user1&password=pass1"`
cartId=${curlOut:2}

curlOut=`curl -s "http://localhost:8081/addToCart?cartId=${cartId}&bookIsbn=validBook1&bookQuantity=1"`
echo $curlOut

curlOut=`curl -s "http://localhost:8081/addToCart?cartId=${cartId}&bookIsbn=validBook2&bookQuantity=2"`
echo $curlOut

curlOut=`curl -s "http://localhost:8081/listCart?cartId=${cartId}"`
echo $curlOut

curlOut=`curl -s "http://localhost:8081/checkOutCart?cartId=${cartId}&ccn=12345678&cced=112020"`
echo $curlOut





curlOut=`curl -s "http://localhost:8081/createCart?clientId=user1&password=pass1"`
cartId=${curlOut:2}

curlOut=`curl -s "http://localhost:8081/addToCart?cartId=${cartId}&bookIsbn=validBook1&bookQuantity=1"`
echo $curlOut

curlOut=`curl -s "http://localhost:8081/addToCart?cartId=${cartId}&bookIsbn=validBook2&bookQuantity=2"`
echo $curlOut

curlOut=`curl -s "http://localhost:8081/listCart?cartId=${cartId}"`
echo $curlOut

curlOut=`curl -s "http://localhost:8081/checkOutCart?cartId=${cartId}&ccn=12345678&cced=112020"`
echo $curlOut





curlOut=`curl -s "http://localhost:8081/listPurchases?clientId=user1&password=pass1"`
echo $curlOut