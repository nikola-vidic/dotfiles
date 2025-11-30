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
        @{ Path = "$env:APPDATA\Code\User\keybindings.json" ; Target = "$env:USERPROFILE\.config\dotfiles\vscode\keybindings.json" }
        @{ Path = "$env:APPDATA\Code\User\settings.json" ; Target = "$env:USERPROFILE\.config\dotfiles\vscode\settings.json" }
        @{ Path = "$env:LOCALAPPDATA\nvim" ; Target = "$env:USERPROFILE\.config\dotfiles\nvim" }
        @{ Path = "$env:USERPROFILE\.config\starship.toml" ; Target = "$env:USERPROFILE\.config\dotfiles\starship\starship.toml" }
        @{ Path = "$env:USERPROFILE\.gitconfig" ; Target = "$env:USERPROFILE\.config\dotfiles\git\.gitconfig" }
        @{ Path = "$env:USERPROFILE\.glzr" ; Target = "$env:USERPROFILE\.config\dotfiles\glzr" }
        @{ Path = "$env:USERPROFILE\Documents\PowerShell" ; Target = "$env:USERPROFILE\.config\dotfiles\PowerShell" }
    )

    foreach ($item in $table) {
        $item.Name = Split-Path -Leaf $item.Path
    }
}

Describe "Symbolic Links" {
    Context "<name>" -ForEach $table {
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
