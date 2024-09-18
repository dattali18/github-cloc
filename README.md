# GitHub User Repositories Line of Code Counter

This bash script takes a GitHub username, downloads all the public repositories of that user, and then uses the `cloc` and `jq` tools to count the lines of code the user has written for each programming language.

## Requirements

To run this script, you need to have the following installed:
1. **bash**
2. **jq**: A JSON query tool, very useful for working with JSON data.
3. **cloc**: A tool to count lines of code.

## Usage

1. Clone this repository or copy the script to your local machine.
2. Open the script in a text editor and replace the `USERNAME` variable with your GitHub username.
3. Save the changes and close the editor.
4. Open a terminal and navigate to the directory where the script is located.
5. Make the script executable by running:
   ```bash
   chmod +x script_name.sh
   ```
6. Run the script:
   ```bash
   ./script_name.sh
   ```
7. The script will create a directory with your GitHub username, clone all your public repositories into that directory, and generate a `result.csv` file with the lines of code statistics.

## Example Output

Here is an example of what the `result.csv` file might look like:

|files |language               |blank |comment |code   |
|------|-----------------------|------|--------|-------|
|89    |SQL                    |242   |137     |5197571|
|35    |CSV                    |0     |0       |1713189|
|15    |Text                   |0     |0       |202103 |
|42    |JSON                   |3     |0       |78518  |
|117   |Markdown               |5645  |31      |16945  |
|121   |JavaScript             |3814  |3954    |12848  |
|103   |CSS                    |2477  |726     |9456   |
|113   |C#                     |1650  |1206    |7713   |
|116   |C++                    |1398  |2604    |7649   |
|120   |Swift                  |2134  |1316    |7605   |
|64    |HTML                   |939   |115     |7568   |
|126   |Python                 |1859  |1264    |5660   |
|61    |Java                   |1602  |2570    |5429   |
|85    |JSX                    |726   |179     |4749   |
|86    |XML                    |1     |23      |4086   |
|57    |C/C++ Header           |955   |548     |2651   |
|19    |XAML                   |253   |46      |2082   |
|19    |Jupyter Notebook       |0     |2174    |1907   |
|15    |SCSS                   |482   |325     |1896   |
|47    |TypeScript             |177   |51      |1758   |
|6     |R                      |165   |126     |244    |
|5     |Visual Studio Solution |5     |5       |244    |
|10    |MSBuild script         |38    |0       |194    |
|40    |SVG                    |0     |0       |145    |
|5     |Bourne Shell           |25    |26      |59     |
|2     |YAML                   |8     |59      |54     |
|2     |Bourne Again Shell     |21    |22      |46     |
|1     |Assembly               |7     |3       |44     |
|2     |CMake                  |13    |10      |42     |
|1     |GDScript               |7     |0       |32     |
|1     |INI                    |3     |0       |17     |
|3     |Pug                    |2     |0       |16     |
|1528  |SUM                    |24651 |17520   |7292520|



## Script

```bash
#!/bin/bash

# GitHub username
# NOTE: change this to be your username on GitHub
USERNAME="dattali18"

# Create a directory to store the cloned repositories
mkdir -p $USERNAME
cd $USERNAME

# Get all repositories for the user
REPOS=$(curl -s "https://api.github.com/users/$USERNAME/repos?per_page=100" | jq -r '.[].clone_url')

# Clone each repository
for REPO in $REPOS; do
    git clone $REPO
done

# Run cloc on all repositories and save the results to result.csv
cloc . --csv --out=result.csv

echo "Lines of code and programming languages statistics saved to result.csv"
```
