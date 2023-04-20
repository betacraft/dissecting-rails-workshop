# Validating CSV Uploads using Active Model APIs

Let's say you had to implement a CSV Upload feature which would populate a database table.

However the CSV file might have columns that have missing data and you decide that only if all the rows have valid data then only that import should succeed.

Using Active Model APIs can help immensely here, specifically the ActiveModel::Validations.
