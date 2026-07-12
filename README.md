# <img src="https://www.rationescurare.org/favicon/favicon-32x32.png" alt="logo" /> RationesCurare
An open-source software for the management of the personal economy.

## Overview
RationesCurare is a personal finance web application designed to help users monitor balances, track movements, analyze cash flow, and manage recurring transactions in a simple and intuitive interface.

## Features
- Track income and expense movements
- Monitor account balances and financial trends
- Visualize cash flow and expense breakdowns with charts
- Manage recurring transactions
- Handle multiple currencies and exchange-related operations
- Keep user data separated through per-user SQLite databases

## Technology stack
- .NET 10 / ASP.NET Core
- Blazor Server
- Entity Framework Core with SQLite
- ApexCharts for interactive data visualization

## Getting started
1. Install the .NET 10 SDK.
2. Clone the repository and open the project folder.
3. Restore dependencies with `dotnet restore`.
4. Run the application with `dotnet run`.

The application will start locally and create the required SQLite files under the App_Data folder on first use. A production publish script is also available in `publish.sh`.

## License
Copyright 2026 (c) [MAIONE MIKY]. All rights reserved.

Licensed under the [GNU](LICENSE) License.
