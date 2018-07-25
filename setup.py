import setuptools

with open("README.md", "r") as fh:
    long_description = fh.read()

setuptools.setup(
    name="pythontwist",
    version="0.0.1",
    author="Phani Rithvij",
    author_email="phanirithvij2000@gmail.com",
    description="A small example package based on anime_downloader",
    long_description=long_description,
    long_description_content_type="text/markdown",
    url="https://github.com/phanirithvij/twist.moe/tree/pythontwist",
    packages=setuptools.find_packages(),
    classifiers=(
        "Programming Language :: Python :: 3",
        "Operating System :: POSIX :: Linux"
    )
)