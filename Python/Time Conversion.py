def convert_minutes(total_minutes):
    if total_minutes < 0:
        print("minutes must be non-negative")
    else:
        hours = total_minutes // 60        
        minutes = total_minutes % 60        
        return f"{hours} hrs {minutes} minutes"

# User input Example
a=int(input("Enter the number of minutes: "))
print("user input is:",a)
print("output is:",convert_minutes(a))
# Test Cases
print(convert_minutes(130))
print(convert_minutes(45))    
print(convert_minutes(200))  
