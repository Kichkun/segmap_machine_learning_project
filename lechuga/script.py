import daemon

from full_model import main

with daemon.DaemonContext():
    main()
