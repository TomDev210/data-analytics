import pandas as pd
import numpy as np

# Load dataset
df = pd.read_csv("Hotel Reservations.csv")

print("Before Cleaning Shape:", df.shape)

# 1️⃣ Remove Duplicate Rows
df.drop_duplicates(inplace=True)

# 2️⃣ Handle Missing Values

# Show missing count
print("\nMissing Values:\n", df.isna().sum())

# Fill numeric columns with median
num_cols = df.select_dtypes(include=['int64', 'float64']).columns
for col in num_cols:
    df[col].fillna(df[col].median(), inplace=True)

# Fill categorical columns with mode
cat_cols = df.select_dtypes(include=['object']).columns
for col in cat_cols:
    df[col].fillna(df[col].mode()[0], inplace=True)

# 3️⃣ Convert Data Types Properly

# Convert booking_status to category
df["booking_status"] = df["booking_status"].astype("category")

# Convert meal plan, room type, etc. to category
category_cols = ["type_of_meal_plan", "room_type_reserved", 
                 "market_segment_type"]
for col in category_cols:
    df[col] = df[col].astype("category")

# 5️⃣ Create New Useful Features

# Total guests
df["total_guests"] = df["no_of_adults"] + df["no_of_children"]

# Stay duration
df["total_nights"] = df["no_of_week_nights"] + df["no_of_weekend_nights"]


# 7️⃣ Final check
print("\nAfter Cleaning Shape:", df.shape)
print("\nData Types:\n", df.dtypes)
print("\nSample Cleaned Data:\n", df.head())

# 8️⃣ Export cleaned dataset
df.to_csv("cleaned_hotel_booking.csv", index=False)
print("\nCleaned file saved as cleaned_hotel_booking.csv")
