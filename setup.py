from setuptools import setup, find_packages

setup(
    name='NeutroQuantumModule',
    version='0.1.0',
    packages=find_packages(),
    install_requires=[
        'mindsdb',
        'torch',
        'torchquantum',
        'qiskit',
        'transformers',
        'pycaret',
        'ray[tune]',
        'pillow',
        'numpy',
        'onnxruntime',
        'securidme-engine',
        'clai-helper',
        'bigdata',
        'datagrip',
    ],
    entry_points={
        'console_scripts': [
            'neutroquantum=src.modules.NeutrosophicDataProcessing.data_filter_adapter:main',
        ],
    },
    author='Your Name',
    author_email='your.email@example.com',
    description='A module for Neutrosophic Quantum Data Processing',
    url='https://github.com/Celebrum/NeutroQuantumModule',
    classifiers=[
        'Programming Language :: Python :: 3',
        'License :: OSI Approved :: MIT License',
        'Operating System :: OS Independent',
    ],
    python_requires='>=3.6',
)
