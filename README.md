# Sports Results Analysis Tool

A Haskell-based command-line application for analyzing and managing sports performance data. This tool provides statistical insights, filtering, sorting, and persistence capabilities for tracking athlete results across different sports.

## Features

### Core Analysis
- **Average Score Calculation**: Compute the mean performance score across all results
- **Top/Bottom Performers**: Identify the best and worst results with customizable N-values
- **Multi-criteria Filtering**: Filter results by:
  - Sport type
  - Athlete/team name
  - Date

### Data Management
- **Date Sorting**: View results chronologically (ascending/descending)
- **File Operations**: Load from and save to persistent storage
- **Clean Data Display**: Formatted tabular output with clear separation

### User Experience
- Interactive menu-driven interface
- Input validation with error handling
- Sample data for immediate testing
- Clear, structured output formatting

## Installation

### Prerequisites
- Haskell Platform or GHC (Glasgow Haskell Compiler)
- Cabal or Stack build tools

### Steps
1. Clone or download the source code
2. Ensure the following modules are available:
   - `Data.List`
   - `System.IO`
   - `Text.Read`

3. Compile the program:
   ```bash
   ghc -o sports-analyzer Main.hs
   ```

4. Run the executable:
   ```bash
   ./sports-analyzer
   ```

## Data Structure

The program uses a custom `Result` type with the following fields:

```haskell
data Result = Result
    { athlete :: String    -- Athlete/team name
    , sport   :: String    -- Sport type
    , date    :: String    -- Date in YYYY-MM-DD format
    , score   :: Double    -- Performance score
    }
```

## Usage Guide

### Starting the Program
Upon launch, the program loads with 6 sample records and displays the main menu:

```
Sports Results Analysis
=======================
Loaded demonstration dataset (6 records).
```

### Menu Options

| Option | Description | Input Required |
|--------|-------------|----------------|
| 1 | Calculate average score | None |
| 2 | Show top N results | Integer N |
| 3 | Show bottom N results | Integer N |
| 4 | Filter results | Sub-menu selection + filter value |
| 5 | Sort by date | Sub-menu selection (newest/oldest first) |
| 6 | Load from file | Filename |
| 7 | Save to file | Filename |
| 8 | Show all results | None |
| 9 | Exit program | None |

### Filtering Sub-menu (Option 4)
1. **By Sport**: Enter sport name (e.g., "Swimming")
2. **By Athlete**: Enter athlete/team name (e.g., "Ivanov")
3. **By Date**: Enter date in YYYY-MM-DD format (e.g., "2024-05-10")

### Sorting Sub-menu (Option 5)
1. **Newest first**: Reverse chronological order
2. **Oldest first**: Chronological order

### File Operations
- **Loading**: Files must contain serialized Haskell `Result` data
- **Saving**: Data is saved in Haskell-readable format
- **Format**: Files use Haskell's `show`/`read` serialization

## Example Workflow

1. **View all data** (Option 8)
   ```
   Ivanov | Swimming | 2024-05-10 | 89.5
   Petrov | Running  | 2024-05-11 | 92.3
   Sidorov | Swimming | 2024-05-10 | 85.0
   Kuznetsov | Jumping | 2024-05-12 | 78.9
   Ivanov | Running  | 2024-05-11 | 95.7
   Smirnov | Swimming | 2024-05-13 | 88.2
   ```

2. **Calculate average** (Option 1)
   ```
   Average score: 88.28333333333333
   ```

3. **Find top 3 performers** (Option 2 → Enter: 3)
   ```
   Top-3 best results:
   Ivanov | Running | 2024-05-11 | 95.7
   Petrov | Running | 2024-05-11 | 92.3
   Ivanov | Swimming | 2024-05-10 | 89.5
   ```

4. **Filter by sport** (Option 4 → 1 → Enter: "Swimming")
   ```
   Results for sport 'Swimming':
   Ivanov | Swimming | 2024-05-10 | 89.5
   Sidorov | Swimming | 2024-05-10 | 85.0
   Smirnov | Swimming | 2024-05-13 | 88.2
   ```

5. **Save to file** (Option 7 → Enter: "my_results.dat")
   ```
   Data saved.
   ```

## Sample Data

The program includes the following demonstration records:

| Athlete | Sport | Date | Score |
|---------|-------|------|-------|
| Ivanov | Swimming | 2024-05-10 | 89.5 |
| Petrov | Running | 2024-05-11 | 92.3 |
| Sidorov | Swimming | 2024-05-10 | 85.0 |
| Kuznetsov | Jumping | 2024-05-12 | 78.9 |
| Ivanov | Running | 2024-05-11 | 95.7 |
| Smirnov | Swimming | 2024-05-13 | 88.2 |

## Functions Overview

### Pure Functions (Data Processing)
- `averageScore` – Calculate mean performance
- `filterBySport` / `filterByAthlete` / `filterByDate` – Data filtering
- `topN` / `bottomN` – Extreme value identification
- `sortByDateDesc` / `sortByDateAsc` – Chronological ordering

### IO Functions (Interaction)
- `loadFromFile` / `saveToFile` – Persistent storage
- `showResults` – Formatted output
- `mainLoop` – Program control flow
- `printMenu` – User interface

## Error Handling

The program includes basic error handling for:
- Invalid menu selections
- Non-integer inputs for N-values
- File operations (minimal – assumes file exists for loading)
- Empty result sets

## Limitations & Future Enhancements

### Current Limitations
- Date validation assumes correct YYYY-MM-DD format
- No duplicate detection or data deduplication
- Basic error handling for file operations
- Single-file data storage

### Potential Improvements
1. **Data Validation**
   - Validate date format and ranges
   - Score range validation (e.g., 0-100)
   - Duplicate entry detection

2. **Enhanced Features**
   - Advanced statistics (median, mode, standard deviation)
   - Time period analysis (weekly/monthly averages)
   - Athlete comparison tools
   - Graphical output options

3. **User Experience**
   - Search functionality
   - Batch operations
   - Export to CSV/JSON formats
   - Undo/redo capabilities

## Technical Details

### Dependencies
- Base Haskell libraries only
- No external packages required

### Code Structure
- **Functional Design**: Emphasizes pure functions for data transformation
- **Modular Organization**: Separate concerns for data, logic, and IO
- **Type Safety**: Leverages Haskell's strong typing for reliability

## License

This is an educational project. Feel free to use, modify, and distribute as needed.

## Author

Haskell Sports Analysis Tool – Demonstrating functional programming principles for practical data analysis applications.
