# Fedora Kde System

Date : 01/15/2026
Version : Fedora 42

https://docs.fedoraproject.org/en-US/quick-docs/

1. Installing System
    https://docs.fedoraproject.org/en-US/kde/getkde/
    
    Update System before everything else

2. Install Nvidia Drivers and Related 
    https://rpmfusion.org/Howto/NVIDIA
    https://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html
    
    wait about 5-10 minutes for kmod is built
    check using modinfo -F version nvidia, which should output driver #
    *if after 10 mins still nothing restart anyways, should still work

3. Install Fedora-Hyprland desktop enviroment
    https://github.com/JaKooLit/Fedora-Hyprland/

    config qt app settings for kde plasma and hyprland
    https://github.com/JaKooLit/Hyprland-Dots/wiki/Customizing_QT_APPS_theming

    *if rofi is misbehaving install rofi-wayland instead
    
4. Basic Setups
    a. Auto-Mount drives
        add each line to auto mount drives based on drive UUID 
            /etc/fstab
    
    b. Configure Default Folders [System Settings -> Locations]
            Desktop Folder -> /home/xinghai/Desktop
            Documents Folder -> /mnt/shared/Documents
            Downloads Folder -> /mnt/shared/Downloads
            Videos Folder -> /mnt/shared/Video
            Pictures Folder -> /mnt/shared/Art
            Music Folder -> /mnt/shared/Music
            
            add symlink for downloads, pictures, video, music
            
    c. Setup fcitx5
        https://fedoraproject.org/wiki/I18N/Fcitx5
            sudo dnf install fcitx5 fcitx5-configtool fcitx5-hangul fcitx5-autostart fcitx5-chinese-addons fcitx5-mozc
            set as default input
            add chinese, korean, japanese as input

5. Complete Virtualization Setup
    https://itsfoss.gitlab.io/post/how-to-install-virtualbox-on-fedora-linux-step-by-step/
    
6. Setup Default Applications
    a. Setup Browser Librewolf
        install librewolf
        import previous profile data (no native import option, manually replace the profile that already exist)
        set as default in kde plasma ->
            System Settings -> Default Applications -> web browser
        set as default in hyprland
    
    b. Setup media player 
        install mpv media player
        set as default in kde plasma ->
            System Settings -> Default Appllications -> muisc/vido player

        *install additoanl media codec -> sudo dnf install @multimedia

    c. Set Other defualt applications
        set kitty as terminal emulator
        set dolphin as file manager

    d. Setup Dolphin 
        hide Remove and Recent from Quick Access
        hide Desktop from Places in Quick Access
        Add Code to Dolphin Quick Access Places

7. Complete Local GenAI Setup
    a. Install ollama -> sudo dnf install ollama
        customize ollama model location to via systemd->
            /mnt/linux_data/Local Chatbot/models/ollama_models/

    b. Install docker -> sudo dnf install moby-engine docker-compose
        https://linuxcapable.com/how-to-install-docker-on-fedora-linux/
        https://linuxiac.com/how-to-change-docker-data-directory/
        customize docker data location to ->
            /home/xinghai/docker

    c. Setting Up Docker Container of Openwebui and Ollama
        run docker compose up on ~/open-webui/docker-compose.yaml
            pulls image of ollama and build openwebui 
                (might not be needed complete copying of docker data to new sys)
                ***use :z suffix to mount volumes in compose file so docker applies labels
                ***make sure the data location has sufficent perrmisson to read/write
        
    d. Add to Startup
        add folder opt/scripts and chotbot_*.sh to dir
        add chatbot_startup.service to 
            /etc/systemd/system/
        add service to startup via systemctl enable *.service
        *make sure script is executable

8. Setup PostgreSQL Database
    sudo dnf install postgresql-server postgresql-contrib
        https://docs.fedoraproject.org/en-US/quick-docs/postgresql/
    configing PostgreSQL
        postgresql.service.d/ -> /etc/systemd/system/ [data setting]

    pgAdmin4 via flatpak (hassle free)
    new server, address -> localhost

9. Complete Programming Setup
        install vscodium

    a. git
        run git config --global user.name/user.email
        setup ssh key on device and add to github

    a. Python 
        pyenv, pipx

    b. R
        RStudio
        
    c. Java, JS, C

10. Complete Productivity Setup
    a. Setup LaTeX 
        sudo dnf install texlive-scheme-full
        install texlive-chktex, LateXML, texstudio
    
    b. Setup media editing applications
        installing davinci resolve 
        https://gist.github.com/tapscodes/21b934274ef06f180a8807153f425de1
        installing picard, chromaprint-tools

11. Remove overlapping and useless Programs

12. Complete Gaming Setup
    Incomplete (Steam disk write error on exfat external ssd)