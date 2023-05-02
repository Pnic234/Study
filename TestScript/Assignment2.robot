*** Settings ***
Library  OperatingSystem
Variables  ../Resources/Variable.py
Resource    ../Resources/Keywords.robot
Suite Setup   Browser Setup
Suite Teardown   Browser Teardown


*** Variable ***
&{products}
@{items}

*** Test Cases ***
Login Test Case
    Login   ${user}  ${passw}
    ${title}=  Log Title
    Page Should Contain  Products
    Title Should be  ${title}

Sort Inventory
    Sort Inventory By Name (A to Z)
    Sort Inventory By Name (Z to A)
    Sort Inventory By Price (Low To High)
    Sort Inventory By Price (High To Low)

Print All Products info and store into file
    Select From List By Index  css:.product_sort_container  0
    Log To console  ${\n}Todays Deal
    Create File  Product/productinfo.txt  Todays Deal
    FOR  ${i}  IN RANGE  1  7
      ${item_name}=  Get Text  xpath:(//*[@class="inventory_item_name"])[${i}]
      ${item_price}=  Get Text  xpath:(//*[@class="inventory_item_price"])[${i}]
      Log To console  ${item_name} : ${item_price}
      Append To File  Product/productinfo.txt  ${\n}${item_name} : ${item_price}
    END

Print product worth Price grater than $10
    Log to console  ${\n}Product costlier than $10
    FOR  ${i}  IN RANGE  1  7
      ${item_name}=  Get Text  xpath:(//*[@class="inventory_item_name"])[${i}]
      ${item_price}=  Get Text  xpath:(//*[@class="inventory_item_price"])[${i}]
      ${item_price2}=  Get Substring  ${item_price}  1
      ${item_price3}=  Convert To Number  ${item_price2}
      IF  ${item_price3}>10
         Log to console  ${item_name} is costlier then $10
      END
    END

Add Product Logout and Verify Product Present
    Add Product In Cart  Sauce Labs Backpack
    Logout
    Login   ${user}  ${passw}
    ${result}=  Check if Added in Cart  Sauce Labs Backpack
    Run Keyword If  '${result}'=='Pass'  Log to console  Product is still In the cart

Verify Empty Cart
    Remove Product From Cart    Sauce Labs Backpack
    ${count}=  Get Element Count  xpath:(//*[@class="inventory_item_name"])
    IF  '${count}'=='0'
        Log To Console    Product is Removed and cart is empty
    ELSE
        Log To Console    Cart is not empty
    END

Verify Locked Username
    Logout
    Login   ${lockeduser}  ${passw}
    Page Should Contain Element  //*[@id="login-button"]
    Set Screenshot Directory    \screenshots
    Capture Page Screenshot
    Log To Console    Error Message



