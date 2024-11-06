# Python Project Template with MkDocs

This project is a template for creating Python projects with documentation generated using [MkDocs](https://www.mkdocs.org/). It provides a standard project structure, a sample `requirements.txt` for dependencies, and configurations for generating documentation in a simple, beautiful, and accessible format.

![template_main_page_snapshot](/docs/res/template_main_page_snapshot.png).

## Features

- **Organized Python Project Structure**: Includes `docs/` directory for markdown documentation files.
- **MkDocs Integration**: Easily create and serve project documentation locally or deploy to GitHub Pages.
- **Dependency Management**: Use `requirements.txt` for managing project dependencies.
- **Sample Scripts**: Helpful Bash scripts for managing virtual environments and installing dependencies.

## Getting Started

### Prerequisites

Make sure you have the following installed:

- **Python 3.6+**

### Project Structure

```plaintext
.
|── .github
|   |── workflows        # Github actions scripts
|   |── ...
|── docs/                # MkDocs documentation files
|   |── res              # Ressources (images, etc...) for the documentation
|   |── stylesheets      # Custom CSS theme for your documentation
|   |── index.md         # Home page for the documentation
|   |── ...              # Additional documentation files
|── scripts              # Scripts to generate the venv and deploy locally
|── requirements.txt     # Python dependencies
|── mkdocs.yml           # MkDocs configuration file
.
```

### Installation

1. **Clone the repository**:

   ```bash
   git clone https://github.com/username/repo-name.git
   cd repo-name
   ```

2. **Create a virtual environment, installs dependencies** (recommended):

   ```bash
   sh scripts/venv.sh make
   ```

### Usage

#### Running the Project

You can place your documentation files in the `docs/` directory and use it as your primary documentation location.
Each new markdown file has to be registered in the [mdkocs.yml](mdkocs.yml) file (see [mkdocs documentation](https://www.mkdocs.org/)).

#### Building and Serving Documentation

1. **Build the documentation**:

   ```bash
   mkdocs build
   ```

   or

   ```bash
   sh scripts/build_static.sh
   ```

   This will generate static HTML files in the `site/` directory.

2. **Serve documentation locally**:

   ```bash
   mkdocs serve
   ```

   or

   ```bash
   sh scripts/deploy_locally.sh
   ```

   Navigate to `http://127.0.0.1:8000` in your browser to view the documentation.

#### Deploying Documentation to GitHub Pages

1. Create a token for Github actions to read the repository
2. Replace the token where it is mentioned in [.github\workflows\deploy.yaml](.github\workflows\deploy.yaml).
3. Repository will automatically be deployed on pull request on the main branch: it will build and push the `site/` folder to the `gh-pages` branch, which GitHub Pages uses to host the site.

## Configuration

Customize the MkDocs configuration by editing `mkdocs.yml`. Here you can change the site name, theme, navigation, and more.

## Contributing

If you want to contribute to this project template:

1. Fork the repository.
2. Create a new branch (`git checkout -b feature/YourFeature`).
3. Make your changes.
4. Push your branch (`git push origin feature/YourFeature`).
5. Open a pull request.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
