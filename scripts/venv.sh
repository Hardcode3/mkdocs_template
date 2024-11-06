#!/bin/bash
# This script was made using the help of: https://makwanadhruv.medium.com/automating-virtual-environments-bash-script-magic-for-python-developers-3a06df1777a6

VENV_NAME="venv"

print_help() {
    echo "Usage: $0 [option]"
    echo "Options:"
    echo "  make        Creates, activates, and installs requirements.txt or setup.py"
    echo "  create      Creates a blank virtual environment"
    echo "  install     Installs dependencies from requirements.txt or setup.py"
    echo "  export      Exports installed dependencies to requirements.txt within a virtual environment"
    echo "  remove      Removes the virtual environment"
}

check_venv_existence() {
    if [ ! -d "$VENV_NAME" ]; then
        echo "Virtual environment '$VENV_NAME' not found. Use '$0 create' to create one."
        return 1
    fi
}

check_python() {
    if command -v python3 &> /dev/null; then
        echo "Python3 is installed."
    elif command -v python &> /dev/null; then
        echo "Python is installed."
    else
        echo "Python is not installed."
        return 1
    fi
}

create_venv() {
    if [ -d "$VENV_NAME" ]; then
        echo "Virtual environment '$VENV_NAME' already exists. Aborting."
        return 1
    fi

    echo "Creating Python virtual environment... (may take a few seconds)"
    python3 -m venv "$VENV_NAME" || return 1
    echo "Finished creating the Python virtual environment."
}

activate_venv() {
    echo "Activating Python virtual environment..."
    if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" ]]; then
        source "$VENV_NAME/Scripts/activate" || return 1
    else
        source "$VENV_NAME/bin/activate" || return 1
    fi
    echo "Virtual environment activated."
}

install_deps() {
    echo "Installing packages... (may take a few seconds)"
    if [ -f "requirements.txt" ]; then
        pip install -r ./requirements.txt || return 1
    elif [ -f "setup.py" ]; then
        pip install -e . || return 1
    else
        echo "No requirements.txt or setup.py file found."
        return 1
    fi

    echo "Upgrading pip..."
    pip install --upgrade pip || return 1
    echo "Finished upgrading pip."
}

export_deps() {
    echo "Exporting dependencies..."
    pip freeze > requirements.txt || return 1
    echo "Dependencies exported to requirements.txt"
}

remove_venv() {
    echo "Removing virtual environment..."
    rm -rf "$VENV_NAME"
    echo "Virtual environment removed."
}

# Display help if --help or -h is provided
if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
    print_help
    exit 0
fi

case "$1" in
    "make")
        check_python || exit 1
        create_venv || exit 1
        activate_venv && install_deps
        deactivate
        ;;
    "create")
        check_python || exit 1
        create_venv
        ;;
    "install")
        check_python || exit 1
        check_venv_existence || exit 1
        activate_venv && install_deps
        deactivate
        ;;
    "export")
        check_python || exit 1
        check_venv_existence || exit 1
        activate_venv && export_deps
        deactivate
        ;;
    "remove")
        check_venv_existence || exit 1
        remove_venv
        ;;
    *)
        echo "Unknown option: $1"
        print_help
        exit 1
        ;;
esac
