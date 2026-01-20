# Robot-Framework-Custom

A data-driven test automation framework built with **Robot Framework** that uses **Excel/Pandas** for test data management. This project demonstrates a custom approach to data-driven testing where test cases are parameterized with data read from Excel spreadsheets.

## Project Overview

Robot-Framework-Custom is a structured automation testing framework that separates test logic from test data. The framework enables QA engineers to maintain test cases in Robot Framework syntax while storing test data in familiar Excel files. This approach offers several advantages:

- **Data-Driven Testing**: Test cases are templates that can be executed with multiple data sets from Excel
- **Easy Data Maintenance**: Non-technical team members can update test data without touching test code
- **Centralized Data Management**: All test data is stored in a single Excel file with multiple sheets
- **Flexible Test Organization**: Data can be organized by feature, module, or test type across different sheets

The framework uses a custom keyword architecture where test data is retrieved dynamically based on test case ID and description. This allows for granular control over test data selection and enables sophisticated data filtering scenarios.

## Project Structure

```
Robot-Framework-Custom/
├── .DS_Store                    # macOS system file
├── README.md                    # This file
├── requirement.txt              # Python dependencies
├── interactive_console_output.xml
├── log.html                     # Test execution log
├── output.xml                   # Machine-readable test results
├── report.html                  # HTML test report
├── .git/                        # Git version control
├── data/                        # Test data directory
│   └── Data_Test.xlsx          # Excel workbook with test data
├── func/                        # Functional keywords
│   └── fungsional_1.robot      # Test action keywords
├── lib/                         # Python libraries
│   └── rby-excel.py            # Custom Excel data handler
├── resources/                   # Shared resources
│   └── GetData.robot           # Data retrieval keywords
└── tests/                       # Test cases
    └── Test_1.robot            # Test suite with templates
```

### Directory Descriptions

#### data/
Contains all test data files in Excel format. The Data_Test.xlsx file is the central repository for all test data used across the project. Excel files support multiple sheets, allowing you to organize data by feature, test type, or any other logical grouping.

#### func/
Functional keyword definitions that implement the core test actions. These keywords define what happens during test execution, such as validating data, performing calculations, or interacting with application components.

#### lib/
Python custom libraries that extend Robot Framework capabilities. The rby-excel.py module provides Excel reading functionality using pandas, enabling sophisticated data extraction from complex Excel workbooks.

#### resources/
Shared resource files containing reusable keywords and variables. GetData.robot contains the CALL DATA keyword that serves as the primary interface between test cases and Excel data.

#### tests/
Test case files organized by test suite. Test_1.robot demonstrates the test template pattern, where a single test case definition can be executed with multiple data sets from Excel.

## Prerequisites

### System Requirements
- **Operating System**: macOS, Linux, or Windows
- **Python**: 3.7 or higher (3.9+ recommended)
- **Robot Framework**: 4.0 or higher
- **Browser**: Chrome/Firefox for Selenium-based tests

### Required Python Packages

The following packages are required for this framework:

| Package | Version | Purpose |
|---------|---------|---------|
| robotframework | 6.0+ | Core test automation framework |
| selenium | 4.0+ | Browser automation |
| pandas | Latest | Excel file processing |
| openpyxl | Latest | Excel file format support |
| xlrd | Latest | Legacy Excel format support |

Additional typing support for Python type hints is recommended.

## Installation

### Step 1: Clone or Navigate to the Project
```bash
# Navigate to your project directory
cd /Users/robbydarmawan/Documents/Automation/Robby

# Navigate to the Robot-Framework-Custom project
cd Robot-Framework-Custom
```

### Step 2: Create Virtual Environment (Recommended)
Creating a virtual environment isolates project dependencies from system-wide Python installations:

```bash
# Create a virtual environment
python3 -m venv venv

# Activate the virtual environment
# On macOS/Linux:
source venv/bin/activate

# On Windows:
venv\Scripts\activate
```

### Step 3: Install Dependencies
```bash
# Install all required packages
pip install -r requirement.txt

# Or install packages individually:
pip install robotframework
pip install selenium
pip install pandas
pip install openpyxl
pip install xlrd
pip install typing
```

### Step 4: Verify Installation
```bash
# Verify Robot Framework installation
robot --version

# Verify Selenium installation
python -c "import selenium; print(selenium.__version__)"

# Verify pandas installation
python -c "import pandas; print(pandas.__version__)"
```

### Step 5: WebDriver Setup
For Selenium-based tests, ensure you have the appropriate WebDriver:

```bash
# Check if ChromeDriver is available
which chromedriver    # macOS/Linux
where chromedriver    # Windows

# If not installed, download from:
# Chrome: https://chromedriver.chromium.org/downloads
# Firefox: https://github.com/mozilla/geckodriver/releases
```

## Test Data Configuration

### Excel File Structure

The test data is stored in `data/Data_Test.xlsx`. The Excel file should follow this structure:

| Column | Description | Example |
|--------|-------------|---------|
| TEST ID | Unique test case identifier | TC001 |
| DESKRIPSI | Test description or category | personal information |
| NAME | Test subject name | John Doe |
| AGE | Test subject age | 25 |
| ADDRESS | Test subject address | 123 Main St |

### Multi-Sheet Support

The framework supports multiple sheets within a single Excel workbook. Each sheet can contain different test data sets:

```python
# Example: Reading from multiple sheets
SHEET_NAMES = ["Data_1", "Data_2"]
```

To add a new sheet:
1. Open `data/Data_Test.xlsx`
2. Add a new worksheet
3. Ensure the worksheet has the same column structure
4. Update the `SHEET_NAMES` variable in your test file

### Adding Test Data

To add new test data:

1. Open `data/Data_Test.xlsx` in Microsoft Excel or LibreOffice
2. Add a new row with the following columns:
   - **TEST ID**: Unique identifier (e.g., TC004)
   - **DESKRIPSI**: Description of the test scenario
   - **NAME**: Name value for the test
   - **AGE**: Age value for the test
   - **ADDRESS**: Address value for the test
3. Save the file
4. Run tests to use the new data

## Running Tests

### Basic Test Execution

Run all tests in the tests directory:
```bash
robot tests/
```

Run a specific test file:
```bash
robot tests/Test_1.robot
```

Run with custom output directory:
```bash
robot --outputdir results tests/
```

### Execute Specific Test Cases

Run a specific test case by name:
```bash
robot -t "TC001 - GET DATA TESTING" tests/Test_1.robot
```

Run multiple specific test cases:
```bash
robot -t "TC001 - GET DATA TESTING" -t "TC002 - GET DATA TESTING" tests/Test_1.robot
```

### Generate Reports

```bash
# Generate reports with custom names
robot --outputdir results \
      --output output.xml \
      --log log.html \
      --report report.html \
      tests/

# Generate reports only
robot --report report.html --log NONE tests/
```

### Debug Mode

Run tests with debug output for troubleshooting:
```bash
robot -L DEBUG tests/Test_1.robot
```

## Test Case Structure

### Test Template Pattern

The framework uses Robot Framework's Test Template feature to create data-driven tests:

```robot
*** Settings ***
Resource    ../func/fungsional_1.robot
Test Template    GET DATA TEST 1

*** Test Cases ***
# =================================================================
# TEST CASE                 DESKRIPSI                      TESTID 
# =================================================================
TC001 - GET DATA TESTING    personal information           TC001
TC002 - GET DATA TESTING    personal information fail 1    TC002
TC003 - GET DATA TESTING    personal information fail 2    TC003
```

### Template Syntax Explanation

The test template works as follows:

1. **Test Template Declaration**: `Test Template    GET DATA TEST 1` defines that all test cases are variations of the "GET DATA TEST 1" keyword
2. **Test Case Arguments**: Each test case provides arguments that are passed to the template keyword
3. **Data-Driven Execution**: Each test case row is executed as a separate test with its own data set

### Custom Test Case Example

```robot
*** Settings ***
Resource    ../func/fungsional_1.robot
Test Template    Custom Test Keyword

*** Test Cases ***
TC100 - Custom Test    description_here    TC100
TC101 - Another Test    another_description    TC101
```

### Non-Template Test Cases

You can also write standard test cases without templates:

```robot
*** Test Cases ***
TC900 - Standalone Test
    [Documentation]    Test that doesn't use template
    [Tags]    SMOKE
    Log    This is a standalone test case
    ${data}    CALL DATA    personal information    TC001    Data_1
    Log    Retrieved data: ${data}
```

## Keywords Reference

### Custom Keywords

#### CALL DATA
Retrieves test data from Excel based on test ID and description.

```robot
${result}    CALL DATA    ${DESKRIPSI}    ${TCID}    ${SHEET_DATA}
```

**Parameters:**
- `DESKRIPSI`: Description matching the data row (string)
- `TCID`: Test ID to search for (string)
- `SHEET_DATA`: Sheet names to search in, comma-separated (string, optional)

**Returns:** Dictionary containing the row data, or "Data Not Found" if no match

**Example:**
```robot
${user_data}    CALL DATA    personal information    TC001    Data_1
${name}         Set Variable    ${user_data['NAME']}
${age}          Set Variable    ${user_data['AGE']}
Log    User: ${name}, Age: ${age}
```

#### GET DATA TEST 1
Template keyword that retrieves and processes test data.

```robot
GET DATA TEST 1    ${DESKRIPSI}    ${TCID}
```

**Parameters:**
- `DESKRIPSI`: Description for data lookup
- `TCID`: Test ID for data retrieval

**Behavior:**
- Calls the CALL DATA keyword with the provided parameters
- Extracts individual fields from the returned data
- Sets local variables for TEST ID, DESKRIPSI, NAME, AGE, ADDRESS

### SeleniumLibrary Keywords

Commonly used SeleniumLibrary keywords:

| Keyword | Description | Example |
|---------|-------------|---------|
| Open Browser | Opens a browser | `Open Browser    https://example.com    Chrome` |
| Close Browser | Closes the browser | `Close Browser` |
| Go To | Navigates to URL | `Go To    https://example.com` |
| Input Text | Enters text into field | `Input Text    id=email    test@example.com` |
| Click Element | Clicks an element | `Click Element    id=submit` |
| Page Should Contain | Verifies text on page | `Page Should Contain    Welcome` |
| Wait Until Element Visible | Waits for element | `Wait Until Element Visible    id=result    timeout=30` |

### Collections Keywords

| Keyword | Description | Example |
|---------|-------------|---------|
| Create List | Creates a list variable | `${items}    Create List    item1    item2` |
| Get From List | Gets item by index | `${first}    Get From List    ${items}    0` |
| Append To List | Adds item to list | `Append To List    ${items}    item3` |

## Python Library Reference

### rby-excel.py

The custom Excel library provides data retrieval functionality using pandas:

```python
from lib.rby-excel import get_data_by_id_from_sheets
```

#### get_data_by_id_from_sheets

```python
def get_data_by_id_from_sheets(file_path, deskripsi, id_value, sheet_names=None):
    """
    Retrieves test data from Excel sheets.
    
    Args:
        file_path: Path to the Excel file
        deskripsi: Description to match
        id_value: Test ID to search for
        sheet_names: List of sheet names to search (optional)
    
    Returns:
        Dictionary with row data or None if not found
    """
```

**Usage Example:**
```python
from lib.rby-excel import get_data_by_id_from_sheets

# Read from specific sheets
result = get_data_by_id_from_sheets(
    file_path="data/Data_Test.xlsx",
    deskripsi="personal information",
    id_value="TC001",
    sheet_names=["Data_1", "Data_2"]
)

if result:
    print(f"Found: {result['NAME']}, Age: {result['AGE']}")
else:
    print("Data not found")
```

## Test Reports

### Report Files

After test execution, three types of reports are generated:

1. **report.html**: Executive summary with:
   - Overall test statistics (passed/failed)
   - Test execution summary
   - Statistics by tags and suites
   - Visual charts and graphs

2. **log.html**: Detailed execution log with:
   - Step-by-step test execution details
   - Keyword execution times
   - Print statements and logs
   - Error messages and stack traces

3. **output.xml**: Machine-readable XML output for:
   - CI/CD pipeline integration
   - Custom report generation
   - Test management system integration

### Viewing Reports

Open reports in a web browser:

```bash
# macOS
open report.html

# Linux
xdg-open report.html

# Windows
start report.html
```

### Report Customization

Customize report output with options:

```bash
# Custom report title
robot --reporttitle "My Custom Report" tests/

# Include or exclude specific outputs
robot --output output.xml --log log.html --report report.html tests/

# Set report width
robot --reportwidth 120 tests/
```

## Troubleshooting

### Common Issues

#### Data Not Found Error
**Error:** "Data Not Found" message in test output

**Solutions:**
- Verify the Excel file path is correct
- Check that TEST ID matches exactly (including case)
- Ensure DESKRIPSI matches the value in Excel
- Verify the sheet name exists in the workbook
- Check for extra spaces in cell values

```robot
# Debug: Print data being searched
Log    Looking for TCID: TC001, Deskripsi: personal information
Log    Sheet names: ${SHEET_NAMES}
```

#### Import Error - SeleniumLibrary
**Error:** Importing library 'SeleniumLibrary' failed

**Solutions:**
- Reinstall SeleniumLibrary: `pip install --upgrade robotframework-seleniumlibrary`
- Verify Selenium is installed: `pip show selenium`
- Check Python path includes site-packages

#### Excel File Not Found
**Error:** FileNotFoundError when reading Excel

**Solutions:**
- Verify file path in test file
- Ensure file is not open in another application
- Check file permissions

```python
# Verify file exists
import os
print(os.path.exists("data/Data_Test.xlsx"))
```

#### pandas Import Error
**Error:** ModuleNotFoundError: No module named 'pandas'

**Solutions:**
- Install pandas: `pip install pandas`
- Activate virtual environment
- Check Python version compatibility

#### Test Template Issues
**Error:** Test case doesn't use template correctly

**Solutions:**
- Ensure `Test Template` is set in Settings section
- Verify template keyword exists and is imported
- Check that test case provides correct number of arguments

### Debugging Tips

1. **Increase Verbosity**: Use `-L DEBUG` for detailed logs
2. **Print Variables**: Use `Log` keyword to print variable values
3. **Console Output**: Use `Log To Console` for real-time output
4. **Step-by-Step**: Run single test case to isolate issues

```robot
*** Test Cases ***
TC001 - Debug Test
    Log To Console    Starting test...
    ${data}    CALL DATA    personal information    TC001    Data_1
    Log To Console    Data: ${data}
    Log    Data dictionary: ${data}
```

## Best Practices

### Test Data Management
1. **Consistent Naming**: Use consistent naming conventions for TEST ID
2. **Descriptive Descriptions**: Make DESKRIPSI clear and meaningful
3. **Data Validation**: Validate Excel data before running tests
4. **Backup Data**: Keep backups of Excel files before modifications

### Test Case Design
1. **Single Responsibility**: Each test should verify one thing
2. **Independent Tests**: Tests should not depend on each other
3. **Clear Assertions**: Use clear verification points
4. **Proper Tags**: Tag tests for better organization

```robot
*** Test Cases ***
TC001 - Valid User Data
    [Documentation]    Verify valid user data is retrieved correctly
    [Tags]    SMOKE    VALID
    GET DATA TEST 1    personal information    TC001
```

### Keyword Development
1. **Reusability**: Create reusable keywords
2. **Documentation**: Document all custom keywords
3. **Error Handling**: Handle expected errors gracefully
4. **Modularity**: Break complex actions into smaller keywords

### Framework Extensibility
1. **New Sheets**: Add new sheets for different data categories
2. **New Keywords**: Extend fungsional_1.robot for new actions
3. **New Libraries**: Add Python libraries in lib/ directory
4. **New Resources**: Create additional resource files for specific features

## CI/CD Integration

### GitHub Actions Example

```yaml
name: Robot Framework Tests
on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Set up Python
        uses: actions/setup-python@v4
        with:
          python-version: '3.9'
      
      - name: Install dependencies
        run: |
          pip install -r requirement.txt
      
      - name: Run tests
        run: |
          robot --outputdir results tests/
      
      - name: Upload reports
        uses: actions/upload-artifact@v3
        with:
          name: test-results
          path: results/
```

### Jenkins Pipeline Example

```groovy
pipeline {
    agent any
    stages {
        stage('Install') {
            steps {
                sh 'pip install -r requirement.txt'
            }
        }
        stage('Test') {
            steps {
                sh 'robot --outputdir results tests/'
            }
        }
        stage('Report') {
            steps {
                archiveArtifacts artifacts: 'results/**', fingerprint: true
                publishHTML([
                    reportDir: 'results',
                    reportFiles: 'report.html',
                    reportName: 'Test Report'
                ])
            }
        }
    }
}
```

## Extending the Framework

### Adding New Test Data Sheets

1. Add a new sheet to `data/Data_Test.xlsx`
2. Ensure the sheet has required columns
3. Update `SHEET_NAMES` variable in test files:

```robot
*** Variables ***
${SHEET_NAMES}      Data_1, Data_2, New_Sheet_Name
```

### Creating New Test Keywords

Add new keywords to `func/fungsional_1.robot`:

```robot
*** Keywords ***
My New Keyword
    [Documentation]    Description of what this keyword does
    [Arguments]    ${arg1}    ${arg2}
    Log    Processing: ${arg1} and ${arg2}
    # Add your keyword logic here
```

### Adding New Python Libraries

1. Create new Python file in `lib/` directory
2. Import in resource files:

```robot
*** Settings ***
Library    ../lib/my_new_library.py
```

### Creating New Test Suites

1. Create new file in `tests/` directory
2. Use appropriate settings and resources
3. Follow the project's naming conventions:

```robot
*** Settings ***
Resource    ../func/fungsional_1.robot

*** Test Cases ***
TC001 - New Test
    GET DATA TEST 1    description    TC001
```

## Contributing

1. **Fork the Repository**: Create your own fork
2. **Create Branch**: `git checkout -b feature/new-feature`
3. **Make Changes**: Add tests, keywords, or improvements
4. **Test Changes**: Run tests to verify functionality
5. **Submit PR**: Create pull request with clear description

### Coding Standards
- Follow Robot Framework best practices
- Use 4 spaces for indentation
- Add documentation to all keywords
- Use descriptive variable names
- Keep test cases simple and focused

## License

This project is open-source and available under the MIT License. See the LICENSE file for more details.

## Support

For questions or issues:

1. **Robot Framework Documentation**: https://robotframework.org/
2. **SeleniumLibrary Documentation**: https://robotframework.org/SeleniumLibrary/
3. **Pandas Documentation**: https://pandas.pydata.org/
4. **Robot Framework User Guide**: https://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html

## Version History

- **v1.0.0** - Initial release with basic Excel data-driven testing
  - Custom Excel data retrieval using pandas
  - Test template pattern implementation
  - Sample test cases and data
  - Basic reporting setup

---

**Happy Testing! 🚀**

