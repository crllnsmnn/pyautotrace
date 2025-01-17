@echo off
if exist "third-party" (
    rmdir /s /q "third-party"
)
if not exist ".venv" (
    python -m venv .venv
)
call .venv\Scripts\activate.bat
pip install -r requirements-dev.txt
mkdir third-party
cd third-party
git clone https://github.com/autotrace/autotrace.git
cd autotrace
git reset --hard fcd9043f6227979ea2b21ac5d9f796325bdb1343
cd distribute\win\3rdparty
mkdir glib
cd glib
tar -xf ..\glib-dev_2.34.3-1_win64.zip
cd ..\..\..\..\..\..
python setup.py clean --all
if exist "build" (
    rmdir /s /q "build"
)
if exist "dist" (
    rmdir /s /q "dist"
)
python setup.py sdist
python setup.py bdist_wheel
