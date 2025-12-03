def remove_duplicates(text):
    result = ""                          
    for ch in text:
        if ch not in result:             
            result += ch
    return result

# user input

a=input("Enter the string: ")
print("user input is:",a)
print("output is:",remove_duplicates(a))

# test cases

print(remove_duplicates("mississippi"))  
print(remove_duplicates("aabbccdde"))    
print(remove_duplicates("programming"))  
