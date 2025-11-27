import pandas as pd

df = pd.read_csv("HR-Employee-Attrition.csv")
df = df.drop_duplicates()

num_cols = df.select_dtypes(include=['int64', 'float64']).columns
df[num_cols] = df[num_cols].fillna(df[num_cols].median())

cat_cols = df.select_dtypes(include=['object']).columns
df[cat_cols] = df[cat_cols].fillna(df[cat_cols].mode().iloc[0])

df['Age'] = df['Age'].astype(int)
df['MonthlyIncome'] = df['MonthlyIncome'].astype(float)
df['YearsAtCompany'] = df['YearsAtCompany'].astype(int)

# df['Attrition_Flag'] = df['Attrition'].map({"Yes": 1, "No": 0})

df['AgeGroup'] = pd.cut(
    df['Age'], bins=[18, 30, 40, 50, 100],
    labels=['20-30', '30-40', '40-50', '50+']
)

df['SalaryGroup'] = pd.cut(
    df['MonthlyIncome'],
    bins=[0, 5000, 10000, 20000, 100000],
    labels=['Low', 'Medium', 'High', 'Very High']
)

df.to_csv("HR_Attrition_Cleaned.csv", index=False)
print("Cleaning Complete ✔")
