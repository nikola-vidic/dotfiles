BeforeDiscovery {
    $modules = @(
        @{ module = "posh-git" }
        @{ module = "PSFzf" }
        @{ module = "PSScriptAnalyzer" }
    )
}

Describe "Modules" {
    It "<module>" -ForEach $modules {
        Install-Module -Name $module -Force
        $installed = $(Get-InstalledModule -Name $module).Name
        $installed | Should -BeLike $module
    }
}

BeforeDiscovery {
    $table = @(
        @{ path = "$env:APPDATA\Code\User\keybindings.json" ; target = "$env:USERPROFILE\.config\dotfiles\vscode\keybindings.json" }
        @{ path = "$env:APPDATA\Code\User\settings.json" ; target = "$env:USERPROFILE\.config\dotfiles\vscode\settings.json" }
        @{ path = "$env:LOCALAPPDATA\nvim" ; target = "$env:USERPROFILE\.config\dotfiles\nvim" }
        @{ path = "$env:USERPROFILE\.config\starship.toml" ; target = "$env:USERPROFILE\.config\dotfiles\starship\starship.toml" }
        @{ path = "$env:USERPROFILE\.gitconfig" ; target = "$env:USERPROFILE\.config\dotfiles\git\.gitconfig" }
        @{ path = "$env:USERPROFILE\.glzr" ; target = "$env:USERPROFILE\.config\dotfiles\glzr" }
        @{ path = "$env:USERPROFILE\Documents\PowerShell" ; target = "$env:USERPROFILE\.config\dotfiles\PowerShell" }
    )
}

Describe "Symbolic Links" {
    Context "<path>" -ForEach $table {
        BeforeEach {
            New-Item -ItemType SymbolicLink -Path $path -Target $target -Force
        }
        It "created" {
            Test-Path $target | Should -Be $true
        }

    }
}

BeforeDiscovery {
    $packages = @(
        @{ package = "Git.Git" }
        @{ package = "Neovim.Neovim" }
        @{ package = "glzr-io.glazewm" }
        @{ package = "Microsoft.Sysinternals.ZoomIt" }
        @{ package = "Microsoft.NuGet" }
        @{ package = "junegunn.fzf" }
        @{ package = "sharkdp.bat" }
        @{ package = "sharkdp.fd" }
    )
}

Describe "Install" {
    Context "<package>" -ForEach $packages {
        BeforeEach {
            winget install $package
            $result = winget show $package
        }
        It "Installed" {
            $result | Should-NotBeNull
        }
    }
}
