from os import environ
from pathlib import Path

import rtoml

if __name__ == "__main__":
    env_vars = rtoml.load("C:\Users\tin0976\OneDrive - Volvo Group\Personal\08-Writing\Vaults\Thoughts At Fifty\netlify.toml")["build"][
        "environment"
    ]
    for k, v in env_vars.items():
        val = v.replace("'", "'\\''")
        print(
            f"export {k}='{val}'",
            file=open("env.sh", "a"),
        )
