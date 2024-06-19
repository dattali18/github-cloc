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

```
|language              |files|line of code|
|----------------------|-----|------------|
|C++                   |116  |11651       |
|C/C++ Header          |57   |4154        |
|CMake                 |2    |65          |
|C#                    |113  |10569       |
|Python                |117  |8190        |
|Jupyter Notebook      |7    |4005        |
|JavaScript            |51   |15639       |
|TypeScript            |47   |1986        |
|JSX                   |40   |1655        |
|CSS                   |71   |9902        |
|HTML                  |56   |7699        |
|Java                  |70   |9822        |
|Swift                 |120  |11055       |
|Markdown              |45   |6099        |
|XML                   |80   |4088        |
|Sass                  |15   |2703        |
|XAML                  |19   |2381        |
|YAML                  |2    |121         |
|Bash                  |4    |83          |
|Assembly              |1    |54          |
|JSON                  |36   |69186       |
|SQL                   |47   |33327       |
|CSV                   |20   |9943        |
...
```

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
